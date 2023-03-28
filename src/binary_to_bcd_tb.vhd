library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity binary_to_bcd_tb is
--  Port ( );
end binary_to_bcd_tb;

architecture Behavioral of binary_to_bcd_tb is

--declare a binary_to_bcd converter component
component binary_to_bcd is
 Port ( temp_in : in STD_LOGIC_VECTOR (5 downto 0); 
           temp_out_tens : out STD_LOGIC_VECTOR (3 downto 0);
           temp_out_ones : out STD_LOGIC_VECTOR (3 downto 0));
end component;

--create the signals
signal temp_in : STD_LOGIC_VECTOR (5 downto 0);
signal temp_out_ones, temp_out_tens : STD_LOGIC_VECTOR(3 downto 0);

begin
--instantiate the component
DUT : binary_to_bcd 
    Port Map(temp_in=>temp_in, temp_out_ones=>temp_out_ones, temp_out_tens=>temp_out_tens);

stimuli : process 
begin
    temp_in <= "101111"; wait for 20 ns; -- should be tens = "0100" ones = "0111"
    temp_in <= "001101"; wait for 20 ns; -- should be tens = "0001" ones = "0011"
    temp_in <= "111111"; wait for 20ns;  -- should be tens = "0101" ones = "1001"
    temp_in <= "111111"; wait for 20 ns; -- should be tens = "0100" ones = "0111"
    temp_in <= "010010"; wait for 20 ns; -- convert and check ...
    temp_in <= "000000"; wait for 20ns;  
    temp_in <= "001111"; wait for 20 ns; 
    temp_in <= "010111"; wait for 20 ns; 
    temp_in <= "111110"; wait for 20ns;  
    temp_in <= "101011"; wait for 20 ns; 
    temp_in <= "101101"; wait for 20 ns; 
    temp_in <= "000001"; wait for 20ns;  
    
    --test more cases!
end process;
end Behavioral;
