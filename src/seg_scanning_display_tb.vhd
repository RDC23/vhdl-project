library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seg_scanning_display_tb is
--  Port ( );
end seg_scanning_display_tb;

architecture Behavioral of seg_scanning_display_tb is
--declare component
component seg_scanning_display is
 Port(curtemp_tens : in STD_LOGIC_VECTOR (6 downto 0);
         curtemp_ones : in STD_LOGIC_VECTOR (6 downto 0);
         preset_tens : in STD_LOGIC_VECTOR (6 downto 0);
         preset_ones : in STD_LOGIC_VECTOR (6 downto 0);
         clk : in STD_LOGIC; --100MHz input clock
         cathode_out : out STD_LOGIC_VECTOR (6 downto 0);
         anode_out : out STD_LOGIC_VECTOR (3 downto 0));
end component;

--declare signals
signal curtemp_ones, curtemp_tens, preset_ones, preset_tens, cathode_out : STD_LOGIC_VECTOR (6 downto 0) := (others=>'0');
signal anode_out : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal clk : STD_LOGIC := '0';

begin
--instantiate DUT
CUT : seg_scanning_display
 Port Map(curtemp_ones=>curtemp_ones, curtemp_tens=>curtemp_tens, preset_ones=>preset_ones, preset_tens=>preset_tens,
 clk=>clk, anode_out=>anode_out, cathode_out=>cathode_out);

clk_gen :process
begin
    while (now<=10us) loop
        clk <= '1'; wait for 5 ns;
        clk <= '0'; wait for 5 ns;
    end loop;
    wait;
 end process clk_gen;

stim : process --create mock 7-segment values
begin
while (now <= 10us) loop
    curtemp_ones<= "1011101";
    curtemp_tens<="0011000";
    preset_ones<="0000000";
    preset_tens<="0100101";
    wait;
end loop;
end process stim;


end Behavioral;
