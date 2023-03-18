library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seg_scanning_display is
    Port(curtemp_tens : in STD_LOGIC_VECTOR (6 downto 0);
         curtemp_ones : in STD_LOGIC_VECTOR (6 downto 0);
         preset_tens : in STD_LOGIC_VECTOR (6 downto 0);
         preset_ones : in STD_LOGIC_VECTOR (6 downto 0);
         clk : in STD_LOGIC; --100MHz input clock
         cathode_out : out STD_LOGIC_VECTOR (6 downto 0);
         anode_out : out STD_LOGIC_VECTOR (3 downto 0));
end seg_scanning_display;

architecture Behave of seg_scanning_display is

--internal signals    
signal clk_1kHz : STD_LOGIC := '0';--internal clock for refresh rate
signal anode : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal cathode : STD_LOGIC_VECTOR (6 downto 0) := (others=>'0');

--count constant
constant maxval : INTEGER := 5;
--constant maxval : INTEGER := 50000; --uncomment this for synthesis

begin
--concurrent transfer of internal signals to outputs
anode_out <= anode;
cathode_out <= cathode;

clk_gen : process(clk)
--count to 50,000 then invert clk to divide f to 1kHz
variable count : INTEGER := 0;
begin
    if (rising_edge(clk)) then
            count := count + 1;
    end if;

    if (count = maxval-1) then
        clk_1kHz <= not clk_1kHz; --invert clock
        count := 0; --reset count
    end if;
end process clk_gen;    

anode_scanner : process(clk_1kHz)
variable multiplex_count : integer := 0;
begin
    --increment the count
    if (rising_edge(clk_1kHz)) then
        multiplex_count := multiplex_count + 1;
    end if;
    --switch on the multiplex_count
    case multiplex_count is
        when 0 => 
            anode <= "0111";
        when 1 =>
            anode <= "1011";
        when 2 =>
            anode <= "1101";
        when 3 =>
            anode <= "1110";
        when others =>
            anode <= "1111"; --disables all 7 segs (should never happen)
    end case;
    --reset counter if 3 is reached
    if (multiplex_count = 3) then
        multiplex_count := 0;
    end if;    
end process anode_scanner;

cathode_scanner : process (anode)
begin
    --multiplexer selects cathode based on anode
    case anode is
        when "0111" =>
            cathode <= curtemp_tens;
        when "1011" =>
            cathode <= curtemp_ones;
        when "1101" =>
            cathode <= preset_tens;
        when "1110" =>
            cathode <= preset_ones;
        when others => --should never occur
            cathode <= cathode;
    end case;
end process cathode_scanner;    

end Behave;

