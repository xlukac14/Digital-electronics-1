----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2021 17:09:07
-- Design Name: 
-- Module Name: tb_d_ff_arst - Behavioral
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

entity tb_d_ff_arst is
--  Port ( );
end tb_d_ff_arst;

architecture Behavioral of tb_d_ff_arst is

    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;

    signal s_clk_100MHz   : STD_LOGIC;
    signal s_arst  : STD_LOGIC;
    signal s_d     : STD_LOGIC;
    signal s_q     : STD_LOGIC;
    signal s_q_bar : STD_LOGIC;
        
begin

    uut_d_ff_arst : entity work.d_ff_arst
    port map(
    
       clk   => s_clk_100MHz,
       rst  => s_arst,
       d     => s_d,
       q     => s_q,
       q_bar => s_q_bar
    );
      
    p_clk_gen : process
    begin
        while now < 750 ns loop         -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
    p_reset_gen : process
    begin
        s_rst <= '0';
        wait for 300 ns;
        s_rst <= '1';                 -- Reset activated
        wait for 100 ns;
        s_rst <= '0';
        wait for 17 ns;
        s_rst <= '1';
        wait for 7 ns;
        s_rst <= '0';
        wait;
    end process p_reset_gen;
    
    p_stimulus : process
    begin
       report "Stimulus process started" severity note;
       

       s_t    <= '0';
       
       wait for 20 ns;
            
       s_t    <= '1';  
       wait for 20 ns;  
       s_t    <= '0';
       wait for 20 ns;
       s_t    <= '1';  
       wait for 20 ns;  
       s_t    <= '0';
       wait for 20 ns;   --100ns
       
       
       
       wait for 20 ns;
       s_t    <= '1';
       wait for 20 ns;
       s_t    <= '0';   
       wait for 20 ns;
       s_t    <= '1'; 
       wait for 20 ns;
       s_t    <= '0'; 
       wait for 20 ns; -- 200 ns
       
       wait for 20 ns;
       s_t    <= '1';
       wait for 20 ns;
       s_t    <= '0';   
       wait for 20 ns;
       s_t    <= '1'; 
       wait for 70 ns;
       s_t    <= '0'; 
       wait for 20 ns; --350ns
       
       
       
       
       
        wait for 20 ns;
       s_t    <= '1';
        wait for 20 ns;
       s_t    <= '0';   
       wait for 20 ns;
       s_t    <= '1'; 
       wait for 100 ns; 
       s_t    <= '0'; 
       wait for 20 ns;
      
       wait for 20 ns;
       s_t    <= '1';
       wait for 20 ns;
       s_t    <= '0';
       wait for 20 ns;
       wait for 50 ns;
       s_t    <= '1';
       wait for 20 ns;
       s_t    <= '0';   
       wait for 20 ns;
       s_t    <= '1'; 
       wait for 20 ns;
       s_t    <= '0'; 
       wait for 20 ns;
       
       report "Stimulus process finished" severity note;
       wait;
   end process p_stimulus;

end Behavioral;
