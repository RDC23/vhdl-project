----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.03.2023 17:15:05
-- Design Name: 
-- Module Name: temp_counter_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity temp_counter_tb is
--  Port ( );
end temp_counter_tb;

architecture Behavioral of temp_counter_tb is

--declare component
component temp_counter is
 Port (    clk : in std_logic;
           min_temp : in std_logic_vector (5 downto 0);
           cur_temp : out std_logic_vector (5 downto 0);
           is_heating: out std_logic);
end component temp_counter;

--declare signals
signal clk, is_heating : std_logic := '0';
signal min_temp, cur_temp : std_logic_vector(5 downto 0);

begin

--instantiate component
DUT : temp_counter Port Map (is_heating => is_heating, clk=>clk, min_temp => min_temp, cur_temp => cur_temp);

--create test 20s clock
clkgen : process
begin
    while (now <= 1 ms) loop
       clk <= '1'; wait for 10 ns;
       clk <= '0'; wait for 10 ns;    
    end loop;
    wait;
end process clkgen;


--stimuli
stimuli : process 
begin
    min_temp <= "010101";
    wait;
end process stimuli;


end Behavioral;
