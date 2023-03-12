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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity binary_to_bcd is
    Port ( temp_in : in STD_LOGIC_VECTOR (5 downto 0);
           temp_out_tens : out STD_LOGIC_VECTOR (3 downto 0);
           temp_out_ones : out STD_LOGIC_VECTOR (3 downto 0));
end binary_to_bcd;

--Double dabble will be used to convert binary to bcd
architecture Behavioral of binary_to_bcd is

begin


end Behavioral;
