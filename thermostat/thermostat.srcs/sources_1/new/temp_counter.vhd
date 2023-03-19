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

begin
--asssign default is_heating

--process to either increment or decrement temp in response to time changes (signified rising clock edges)
delta_t : process(slow_clk_12, slow_clk_20)

--op_temp tracks the current (output) temperature and is modfied to maintain equilibrium based on user-set minimum 
variable op_temp : unsigned(5 downto 0) := (others=>'0');

begin
   --heat up process if the current temp is below minimum
   if (op_temp <= unsigned(min_temp)) then
        if (rising_edge(slow_clk_12)) then
            op_temp := op_temp + 1;
            is_heating <= '1';
        end if;
   --cool down process if te current temp is above minimum
   elsif (op_temp > unsigned(min_temp)) then
        if (rising_edge(slow_clk_20)) then
            op_temp := op_temp - 1;
            is_heating <= '0';
        end if;
  end if; 
  --assign the local op_temp variable to the global output temperature
  cur_temp <= std_logic_vector(op_temp);
  
end process delta_t;   


end Behavioral;
