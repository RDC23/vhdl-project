----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.03.2023 13:13:01
-- Design Name: 
-- Module Name: binary_to_bcd_tb - Behavioral
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
    
    --test more cases!
end process;
end Behavioral;
