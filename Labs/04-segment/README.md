# Lab 03-Vivado

## My GitHub repository

https://github.com/xlukac14/Digital-electronics-1

## Preparation

| **Hex** | **Inputs** | **A** | **B** | **C** | **D** | **E** | **F** | **G** |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0000 | 0 | 0 | 0 | 0 | 0 | 0 | 1 |
| 1 | 0001 | 1 | 0 | 0 | 1 | 1 | 1 | 1 |
| 2 | 0010 | 0 | 0 | 1 | 0 | 0 | 1 | 0 |
| 3 | 0011 | 0 | 0 | 0 | 0 | 1 | 1 | 0 |
| 4 | 0100 | 1 | 0 | 0 | 1 | 1 | 0 | 0 |
| 5 | 0101 | 0 | 1 | 0 | 0 | 1 | 0 | 0 |
| 6 | 0110 | 0 | 1 | 0 | 0 | 0 | 0 | 0 |
| 7 | 0111 | 0 | 0 | 0 | 1 | 1 | 1 | 1 |
| 8 | 1000 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| 9 | 1001 | 0 | 0 | 0 | 0 | 1 | 0 | 0 |
| A | 1010 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |
| b | 1011 | 1 | 1 | 0 | 0 | 0 | 0 | 0 |
| C | 1100 | 0 | 1 | 1 | 0 | 0 | 0 | 1 |
| d | 1101 | 1 | 0 | 0 | 0 | 0 | 1 | 0 |
| E | 1110 | 0 | 1 | 1 | 0 | 0 | 0 | 0 |
| F | 1111 | 0 | 1 | 1 | 1 | 0 | 0 | 0 |

## Task1...

### Table with connection of 7-segment displays






----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.03.2021 14:46:07
-- Design Name: 
-- Module Name: tb_hex_7seg - Behavioral
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

entity tb_hex_7seg is
--  Port ( );
end tb_hex_7seg;

architecture Behavioral of tb_hex_7seg is
    
    signal s_hex    : std_logic_vector(4 - 1 downto 0);
    signal s_seg    : std_logic_vector(7 - 1 downto 0)
    
begin

    uut_hex_7seg : entity work.hex_7seg
    port map
    (
        hex_i   =>  S_hex,
        seg_o   =>  s_seg  
    );
    
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        s_hex <=  "0000"; wait for 100ns;
        s_hex <=  "0001"; wait for 100ns;
        s_hex <=  "0010"; wait for 100ns;
        s_hex <=  "0011"; wait for 100ns;
        s_hex <=  "0100"; wait for 100ns;
        s_hex <=  "0101"; wait for 100ns;
        s_hex <=  "0110"; wait for 100ns;
        s_hex <=  "0111"; wait for 100ns;
        s_hex <=  "1000"; wait for 100ns;
        s_hex <=  "1001"; wait for 100ns;
        s_hex <=  "1010"; wait for 100ns;
        s_hex <=  "1011"; wait for 100ns;
        s_hex <=  "1100"; wait for 100ns;
        s_hex <=  "1101"; wait for 100ns;
        s_hex <=  "1110"; wait for 100ns;
        s_hex <=  "1111"; wait for 100ns;
        wait;

end Behavioral;

