library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level_tb is
--  Port ( );
end top_level_tb;

architecture Behavioral of top_level_tb is
--declare the thermometer component
component top_level is
    Port ( clk : in STD_LOGIC;
           heat_on : out STD_LOGIC; -- boolean to light LED
           temp_preset : in STD_LOGIC_VECTOR (5 downto 0);
           anode_out : out STD_LOGIC_VECTOR (3 downto 0);
           cathode_out : out STD_LOGIC_VECTOR (6 downto 0)
           );
end component top_level;

--declare signals
signal temp_preset : STD_LOGIC_VECTOR (5 downto 0);
signal clk, heat_on : STD_LOGIC := '0';
signal cathode_out : STD_LOGIC_VECTOR (6 downto 0) ;
signal anode_out : STD_LOGIC_VECTOR (3 downto 0);

begin
--instantiate the DUT
DUT : top_level 
Port Map(temp_preset=>temp_preset, clk=>clk, heat_on=>heat_on, anode_out=>anode_out, cathode_out=>cathode_out);

--create test stimuli
clk_gen : process 
begin
    while (now<1 ms)loop
        clk<='0'; wait for 10 ns;
        clk<='1'; wait for 10 ns;
    end loop;
    wait;
end process clk_gen;

--set a mock desired heater switch on temperature of 7 degrees
temp_preset<="000111";


end Behavioral;
