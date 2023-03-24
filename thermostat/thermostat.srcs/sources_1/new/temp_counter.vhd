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
    Port ( clk : in std_logic;
           min_temp : in std_logic_vector (5 downto 0);
           cur_temp : out std_logic_vector (5 downto 0);
           is_heating : out std_logic);
end temp_counter;

architecture Behavioral of temp_counter is

constant default_clk : integer := 100000000; -- default Basys 3 clock rate of 100 MHz --use this clock for synthesis
--constant default_clk : integer := 10; -- use this for simulation
constant max_count_12s : integer := default_clk * 6; -- 12s clock period 50% duty cycle
constant max_count_20s : integer := default_clk * 10; -- 20s clock period 50% duty cycle
signal internal_temp : unsigned(5 downto 0):= "000101";
begin

temp_change : process(clk)
variable count12 : INTEGER := 0;
variable count20 : INTEGER := 0;

begin
    if (rising_edge(clk)) then
        --increment both the counters
        count12 := count12 + 1;
        count20 := count20 + 1;    
        
        if (count12 = max_count_12s) then
            if(internal_temp <= unsigned(min_temp)) then
                internal_temp <= internal_temp + 1;
                is_heating <= '1';
            end if;
            count12 := 0;            
        end if;    
    
        if (count20 = max_count_20s) then
            if(internal_temp > unsigned(min_temp)) then
                internal_temp <= internal_temp - 1;
                is_heating <= '0';
            end if;   
            count20 := 0;   
        end if;  
          
    end if;
  

end process temp_change;

cur_temp <= std_logic_vector(internal_temp);  
    
end Behavioral;