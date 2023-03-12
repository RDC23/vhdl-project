----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.03.2023 17:01:17
-- Design Name: 
-- Module Name: temp_counter - Behavioral
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

entity temp_counter is
    Port ( slow_clk_20 : in std_logic;
           slow_clk_12 : in std_logic;
           min_temp : in std_logic_vector (5 downto 0);
           cur_temp : out std_logic_vector (5 downto 0);
           is_heating : out std_logic);
end temp_counter;

architecture Behavioral of temp_counter is
--internal count temp to allow current temp to be accessed by processes
signal count_temp : unsigned(5 downto 0) := "000100";
begin

--process to heat up if the current temperature is below or equal to threshold
heat_on : process(slow_clk_12)
begin
   if (count_temp <= unsigned(min_temp)) then
        if (rising_edge(slow_clk_12)) then
            count_temp <= count_temp + 1;
        end if;
   end if;   
end process heat_on;

--process to cool down if the current temperature is above threshold
cool_down : process(slow_clk_20)
begin
   if (count_temp > unsigned(min_temp)) then
        if (rising_edge(slow_clk_20)) then
            count_temp <= count_temp -1;
        end if;
   end if;   
end process cool_down;

display : process(count_temp) is
begin
    if (count_temp >= unsigned(min_temp)) then
        is_heating <= '1';
    else
        is_heating <= '0';
    end if;
end process display;

cur_temp <= std_logic_vector(count_temp);
        


end Behavioral;
