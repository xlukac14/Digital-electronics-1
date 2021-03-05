library ieee;
use ieee.std_logic_1164.all;

entity tb_hex_7seg is
    
end entity tb_hex_7seg;


architecture testbench of tb_hex_7seg is

    signal s_hex    : std_logic_vector(4 - 1 downto 0);
    signal s_seg    : std_logic_vector(7 - 1 downto 0);

begin
    
    uut_hex_7seg : entity work.hex_7seg
        port map(
            hex_i   =>  S_hex,
            seg_o   =>  s_seg
        );

    
    p_stimulus : process
    begin
      
        report "Stimulus process started" severity note;
        -- max. length -> 1000ns
        -- 1000ns/16 = 62.5ns
        s_hex <=  "0000"; wait for 62.5ns;
        s_hex <=  "0001"; wait for 62.5ns;
        s_hex <=  "0010"; wait for 62.5ns;
        s_hex <=  "0011"; wait for 62.5ns;
        s_hex <=  "0100"; wait for 62.5ns;
        s_hex <=  "0101"; wait for 62.5ns;
        s_hex <=  "0110"; wait for 62.5ns;
        s_hex <=  "0111"; wait for 62.5ns;
        s_hex <=  "1000"; wait for 62.5ns;
        s_hex <=  "1001"; wait for 62.5ns;
        s_hex <=  "1010"; wait for 62.5ns;
        s_hex <=  "1011"; wait for 62.5ns;
        s_hex <=  "1100"; wait for 62.5ns;
        s_hex <=  "1101"; wait for 62.5ns;
        s_hex <=  "1110"; wait for 62.5ns;
        s_hex <=  "1111"; wait for 62.5ns;
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
