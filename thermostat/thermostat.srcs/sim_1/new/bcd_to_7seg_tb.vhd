----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.03.2023 14:18:24
-- Design Name: 
-- Module Name: bcd_to_7seg_tb - Behavioral
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

entity bcd_to_7seg_tb is
--  Port ( );
end bcd_to_7seg_tb;

architecture Behavioral of bcd_to_7seg_tb is
--declare component
component bcd_to_7seg is
    Port ( bcd : in STD_LOGIC_VECTOR (3 downto 0);
           seven_seg : out STD_LOGIC_VECTOR (6 downto 0));
end component bcd_to_7seg;

--create signals
signal bcd : STD_LOGIC_VECTOR(3 downto 0);
signal seven_seg : STD_LOGIC_VECTOR(6 downto 0);

begin
--instantiate component
DUT : bcd_to_7seg Port Map(bcd=>bcd, seven_seg=>seven_seg);

--create a test stimuli, testing each 'case' of the case statement for the entity bcd_to_7seg
--consult truth table to confirm working https://allaboutfpga.com/wp-content/uploads/2017/07/BCD-TO-7-SEGMENT-DECODER-TRUTH-TABLE.png
test: process begin
    bcd <= "0000"; wait for 20 ns;
    bcd <= "0001"; wait for 20 ns;
    bcd <= "0010"; wait for 20 ns;
    bcd <= "0011"; wait for 20 ns;
    bcd <= "0100"; wait for 20 ns;
    bcd <= "0101"; wait for 20 ns;
    bcd <= "0110"; wait for 20 ns;
    bcd <= "0111"; wait for 20 ns;
    bcd <= "1000"; wait for 20 ns;
    bcd <= "1001"; wait for 20 ns;
    bcd <= "1010"; wait for 20 ns;
end process test;

end Behavioral;
