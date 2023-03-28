----------------------------------------------------------------------------------
-- Company: Strathclyde
-- Engineer: Ross Cathcart
-- Function: switches on/off the heating and adjusts the current temperature
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity temp_counter is
    Port ( clk : in std_logic;
           min_temp : in std_logic_vector (5 downto 0);
           cur_temp : out std_logic_vector (5 downto 0);
           is_heating : out std_logic);
end temp_counter;

architecture Behavioral of temp_counter is

constant default_clk : integer := 100000000; -- synth clk
--constant default_clk : integer := 10; --sim clk
constant max_count_12s : integer := default_clk * 12;
constant max_count_20s : integer := default_clk * 20;
signal internal_temp : unsigned(5 downto 0):= "000101";
begin

temp_change : process(clk)
--process to count up (wait in a synthesisable format) then adjust the current
--temperature accordingly
variable count12 : INTEGER := 0;
variable count20 : INTEGER := 0;

begin
    if (rising_edge(clk)) then
        --increment both the counters
        count12 := count12 + 1;
        count20 := count20 + 1;    
        
        if (count12 = max_count_12s) then
		--reset count and increment curtemp if it is lower than or equal to the preset
            count12 := 0;  
            if(internal_temp <= unsigned(min_temp)) then
                internal_temp <= internal_temp + 1;
                is_heating <= '1';
            end if;     
                     
        elsif (count20 = max_count_20s) then
		--reset count and decrement curtemp if it is above than preset
            count20 := 0; 
            if(internal_temp > unsigned(min_temp)) then
                internal_temp <= internal_temp - 1;
                is_heating <= '0';
            end if;                
        end if;  
          
    end if;  

end process temp_change;

--concurrently assign the current temp when internal temp changes
cur_temp <= std_logic_vector(internal_temp);  
    
end Behavioral;