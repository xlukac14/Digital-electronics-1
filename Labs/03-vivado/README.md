# Lab 03-Vivado

## My GitHub repository

https://github.com/xlukac14/Digital-electronics-1

## Task 1: Table with connection of 16 slide switches and 16 LEDs on Nexys board

| **SW** | **SW-PIN** | **Resistor1** | **Resisitor2** | **LED** | **LED-PIN** |
| :-: | :-: | :-: | :-: | :-: | :-: |
| **SW0** | J15 | R35 | R33 | LD0 | H17 |
| **SW1** | L16 | R37 | R34 | LD1 | K15 |
| **SW2** | M13 | R38 | R36 | LD2 | J13|
| **SW3** | R15 | R40 | R39 | LD3 | N18 |
| **SW4** | R17 | R42 | R41 | LD4 | R18 |
| **SW5** | T18 | R43 | R44 | LD5 | V17 |
| **SW6** | U18 | R46 | R47 | LD6 | U17 |
| **SW7** | R13 | R48 | R50 | LD7 | U16 |
| **SW8** | T8 | R56 | R52 | LD8 | V16 |
| **SW9** | U8 | R58 | R54 | LD9 | T15 |
| **SW10** | R16 | R64 | R57 | LD10 | U14 |
| **SW11** | T13 | R66 | R65 | LD11 | T16 |
| **SW12** | H6 | R68 | R67 | LD12 | V15 |
| **SW13** | U12 | R69 | R70 | LD13 | V14 |
| **SW14** | U11 | R71 | R72 | LD14 | V12 |
| **SW15** | V10 | R73 | R74 | LD15 | V11 |

## Task 2: Two-bit wide 4-to-1 multiplexer

### VHDL architecture

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity mux_2bit_4to1 is
    port(
        a_i           : in  std_logic_vector(2 - 1 downto 0);
		b_i           : in  std_logic_vector(2 - 1 downto 0);
		c_i           : in  std_logic_vector(2 - 1 downto 0);
		d_i           : in  std_logic_vector(2 - 1 downto 0);
		sel_i         : in  std_logic_vector(2 - 1 downto 0);
		f_o           : out std_logic_vector(2 - 1 downto 0)       
    );
end entity mux_2bit_4to1;

architecture Behavioral of mux_2bit_4to1 is
begin

       f_o <= a_i when(sel_i = "00") else
              b_i when(sel_i = "01") else
              c_i when(sel_i = "10") else
              d_i;
end architecture Behavioral;
```

### VHDL stimulus process

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity tb_mux_2bit_4to1 is
    
end entity tb_mux_2bit_4to1;


architecture testbench of tb_mux_2bit_4to1 is

    signal s_a       : std_logic_vector(2 - 1 downto 0);
    signal s_b       : std_logic_vector(2 - 1 downto 0);
    signal s_c       : std_logic_vector(2 - 1 downto 0);
    signal s_d       : std_logic_vector(2 - 1 downto 0);
    signal s_sel     : std_logic_vector(2 - 1 downto 0);
    signal s_f       : std_logic_vector(2 - 1 downto 0);

begin
    
    uut_mux_2bit_4to1 : entity work.mux_2bit_4to1
        port map(
            a_i           => s_a,
            b_i           => s_b,
            c_i           => s_c,
            d_i           => s_d,
            sel_i         => s_sel,
            f_o           => s_f
        );

    
    p_stimulus : process
    begin
      
        report "Stimulus process started" severity note;

        s_d <= "00"; s_c <= "00"; s_b <= "00"; s_a <= "00"; 
        s_sel <= "00"; wait for 100 ns;
        
        s_d <= "10"; s_c <= "01"; s_b <= "01"; s_a <= "00"; 
        s_sel <= "00"; wait for 100 ns;
        
        s_d <= "10"; s_c <= "01"; s_b <= "01"; s_a <= "11"; 
        s_sel <= "00"; wait for 100 ns;
        
        s_d <= "10"; s_c <= "01"; s_b <= "01"; s_a <= "00"; 
        s_sel <= "01"; wait for 100 ns;
        
        s_d <= "10"; s_c <= "01"; s_b <= "11"; s_a <= "00"; 
        s_sel <= "01"; wait for 100 ns;
        
        s_d <= "10"; s_c <= "01"; s_b <= "11"; s_a <= "00"; 
        s_sel <= "10"; wait for 100 ns;
        
        s_d <= "10"; s_c <= "01"; s_b <= "11"; s_a <= "00"; 
        s_sel <= "11"; wait for 100 ns;
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
```

## Screenshot with simulated time waveforms

![03-vivado](https://github.com/xlukac14/Digital-electronics-1/blob/main/Labs/03-vivado/images/de1_pc3_output_mltplx.PNG)

## Task 3: A Vivado tutorial

link: https://github.com/xlukac14/Digital-electronics-1/blob/main/Labs/03-vivado/Vivado_maual_Lukac_221340.pdf