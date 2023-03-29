----------------------------------------------------------------------------------
-- Company: Strathclyde
-- Engineer: Ross Cathcart
-- Function: connects components together using signals to form the top-level
--           design entity.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level is
    Port ( clk : in STD_LOGIC;
           heat_on : out STD_LOGIC; -- boolean to light LED
           temp_preset : in STD_LOGIC_VECTOR (5 downto 0);
           cathode_out : out STD_LOGIC_VECTOR (6 downto 0); --the current 7-seg digit being displayed
           anode_out : out STD_LOGIC_VECTOR (3 downto 0));
end top_level;

architecture Behavioral of top_level is

--temperature counter component declaration
component temp_counter is
Port ( clk: in STD_LOGIC;
           min_temp : in std_logic_vector (5 downto 0);
           cur_temp : out std_logic_vector (5 downto 0);
           is_heating : out std_logic);
end component temp_counter;

--binary to bcd encoder component declaration
component binary_to_bcd is
 Port ( temp_in : in STD_LOGIC_VECTOR (5 downto 0); 
           temp_out_tens : out STD_LOGIC_VECTOR (3 downto 0);
           temp_out_ones : out STD_LOGIC_VECTOR (3 downto 0));
end component binary_to_bcd;

--bcd to 7-segment component declaration
component bcd_to_7seg is
 Port ( bcd : in STD_LOGIC_VECTOR (3 downto 0);
           seven_seg : out STD_LOGIC_VECTOR (6 downto 0));           
end component bcd_to_7seg;

--scanner display component declaration
component seg_scanning_display is
  Port(curtemp_tens : in STD_LOGIC_VECTOR (6 downto 0);
         curtemp_ones : in STD_LOGIC_VECTOR (6 downto 0);
         preset_tens : in STD_LOGIC_VECTOR (6 downto 0);
         preset_ones : in STD_LOGIC_VECTOR (6 downto 0);
         clk : in STD_LOGIC; --100MHz input clock
         cathode_out : out STD_LOGIC_VECTOR (6 downto 0);
         anode_out : out STD_LOGIC_VECTOR (3 downto 0));
end component seg_scanning_display;
   
--create the internal signals to link components
signal clk_int: STD_LOGIC;
signal curtemp_binary : STD_LOGIC_VECTOR (5 downto 0); --between temp counter and binary to bcd converter
signal bcd_preset_ones, bcd_preset_tens, bcd_cur_ones, bcd_cur_tens : STD_LOGIC_VECTOR(3 downto 0); --between bcd and 7segs
signal scanner_ct_ones, scanner_ct_tens, scanner_pst_ones, scanner_pst_tens : STD_LOGIC_VECTOR (6 downto 0);
   
begin

--instantiate components

clk_int <= clk;

TEMP_COUNT : temp_counter Port Map(clk=>clk_int, min_temp=>temp_preset, cur_temp=>curtemp_binary, is_heating=>heat_on);

CURTEMP_BINARY_TO_BCD : binary_to_bcd Port Map(temp_in=>curtemp_binary, temp_out_tens=>bcd_cur_tens, temp_out_ones=>bcd_cur_ones);

PRESET_BINARY_TO_BCD : binary_to_bcd Port Map(temp_in=>temp_preset, temp_out_tens=>bcd_preset_tens, temp_out_ones=>bcd_preset_ones);

--use a for-if generate for the 4 7-segment component instantiations
SEG_GEN: for i in 0 to 3 generate

    SEG_GEN0 : if i = 0 generate --generate the bcd -> 7 seg for the 'ones' of the current temperature
        CUR_ONES : bcd_to_7seg
        Port Map (bcd=>bcd_cur_ones, seven_seg=>scanner_ct_ones);
    end generate;
    
    SEG_GEN1 : if i = 1 generate --generate the bcd -> 7 seg for the 'tens' of the current temperature
        CUR_TENS : bcd_to_7seg
        Port Map (bcd=>bcd_cur_tens, seven_seg=>scanner_ct_tens);
    end generate;
    
    SEG_GEN2 : if i = 2 generate --generate the bcd -> 7 seg for the 'ones' of the preset temperature
        PRE_ONES : bcd_to_7seg
        Port Map (bcd=>bcd_preset_ones, seven_seg=>scanner_pst_ones);
    end generate;
    
    SEG_GEN3 : if i = 3 generate --generate the bcd -> 7 seg for the 'tens' of the preset temperature
        PRE_TENS : bcd_to_7seg
        Port Map (bcd=>bcd_preset_tens, seven_seg=>scanner_pst_tens);
    end generate;    
end generate;

SCANNER : seg_scanning_display 
Port Map(curtemp_ones=>scanner_ct_ones, curtemp_tens=>scanner_ct_tens,
         preset_tens=>scanner_pst_tens, preset_ones=>scanner_pst_ones, clk=>clk,
         cathode_out=>cathode_out, anode_out=>anode_out);
         
end Behavioral;
