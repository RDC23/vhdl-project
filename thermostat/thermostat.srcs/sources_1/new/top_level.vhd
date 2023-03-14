----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.03.2023 19:14:14
-- Design Name: 
-- Module Name: top_level - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
    Port ( clk : in STD_LOGIC;
           heat_on : out STD_LOGIC; -- boolean to light LED
           temp_preset : in STD_LOGIC_VECTOR (5 downto 0);
           curtemp_ones, curtemp_tens, preset_ones, preset_tens : out STD_LOGIC_VECTOR (6 downto 0)); --seven segment vectors
end top_level;

architecture Behavioral of top_level is

--temperature counter component declaration
component temp_counter is
Port ( slow_clk_20 : in std_logic;
           slow_clk_12 : in std_logic;
           min_temp : in std_logic_vector (5 downto 0);
           cur_temp : out std_logic_vector (5 downto 0);
           is_heating : out std_logic);
end component temp_counter;

--clock divider component declaration
component slow_clocks is
Port ( clk : in STD_LOGIC;
           clk_20s : out STD_LOGIC;
           clk_12s : out STD_LOGIC);
end component slow_clocks;

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
   
--create the internal signals
signal clk_20, clk_12 : STD_LOGIC;
signal curtemp_binary : STD_LOGIC_VECTOR (5 downto 0); --between temp counter and binary to bcd converter
signal bcd_preset_ones, bcd_preset_tens, bcd_cur_ones, bcd_cur_tens : STD_LOGIC_VECTOR(3 downto 0); --between bcd and 7segs
   
begin

--instantiate components
CLK_DIV : slow_clocks Port Map(clk=>clk, clk_20s=>clk_20, clk_12s=>clk_12);

TEMP_COUNT : temp_counter Port Map(slow_clk_20=>clk_20, slow_clk_12=>clk_12, min_temp=>temp_preset, cur_temp=>curtemp_binary, is_heating=>heat_on);

CURTEMP_BINARY_TO_BCD : binary_to_bcd Port Map(temp_in=>curtemp_binary, temp_out_tens=>bcd_cur_tens, temp_out_ones=>bcd_cur_ones);

PRESET_BINARY_TO_BCD : binary_to_bcd Port Map(temp_in=>temp_preset, temp_out_tens=>bcd_preset_tens, temp_out_ones=>bcd_preset_ones);

--use a for-if generate for the 4 7-segment component instantiations
SEG_GEN: for i in 0 to 3 generate

    SEG_GEN0 : if i = 0 generate --generate the bcd -> 7 seg for the 'ones' of the current temperature
        CUR_ONES : bcd_to_7seg
        Port Map (bcd=>bcd_cur_ones, seven_seg=>curtemp_ones);
    end generate;
    
    SEG_GEN1 : if i = 1 generate --generate the bcd -> 7 seg for the 'tens' of the current temperature
        CUR_TENS : bcd_to_7seg
        Port Map (bcd=>bcd_cur_tens, seven_seg=>curtemp_tens);
    end generate;
    
    SEG_GEN2 : if i = 3 generate --generate the bcd -> 7 seg for the 'ones' of the preset temperature
        PRE_ONES : bcd_to_7seg
        Port Map (bcd=>bcd_preset_ones, seven_seg=>preset_ones);
    end generate;
    
    SEG_GEN3 : if i = 4 generate --generate the bcd -> 7 seg for the 'tens' of the preset temperature
        PRE_TENS : bcd_to_7seg
        Port Map (bcd=>bcd_preset_tens, seven_seg=>preset_tens);
    end generate;    
end generate;

end Behavioral;
