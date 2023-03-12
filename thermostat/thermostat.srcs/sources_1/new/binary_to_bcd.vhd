----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.03.2023 08:40:04
-- Design Name: 
-- Module Name: binary_to_bcd - Behavioral
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

entity binary_to_bcd is
    --max 6 bit input (0-65 Celsius)
    --two 4 bit outputs to hold digits from 0-9 for BCD
    Port ( temp_in : in STD_LOGIC_VECTOR (5 downto 0); 
           temp_out_tens : out STD_LOGIC_VECTOR (3 downto 0);
           temp_out_ones : out STD_LOGIC_VECTOR (3 downto 0));
end binary_to_bcd;

architecture Behavioral of binary_to_bcd is

begin
--sensitive to a change in input data
convert process(temp_in):
    variable intermediate : STD_LOGIC_VECTOR(5 downto 0);
    variable scratch_space : unsigned(7 downto 0); --need to perfom arithmetic operations
begin:
    scratch_space := (others => '0');
    intermediate := temp_in;
    --n = input width iterations
    for i in range 0 to 5 loop
        --add 3 to each nibble of scratch space if it is >=5 to correct carry...
        if scratch_space(3 downto 0) >= 5 then
            scratch_space(3 downto 0) := scratch_space(3 downto 0) + 3;
        end if;

        if scratch_space(7 downto 4) >= 5 then
            scratch_space(7 downto 4) := scratch_space(7 downto 4) + 3;
        end if;

        --shift the intermediate left into scratch space by 1 bit
        scratch_space(7 downto 0) := scratch_space(6 downto 0) & intermediate(5);
        intermediate := intermediate(4 downto 0) & '0';
    
    end loop;    
    --push the respective portion of the scratch space into each BCD output digit
    temp_out_tens <= STD_LOGIC_VECTOR(scratch_space(7 downto 4));
    temp_out_ones <= STD_LOGIC_VECTOR(scratch_space(3 downto 0));

end convert process;

end Behavioral;
