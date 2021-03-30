----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2021 17:03:06
-- Design Name: 
-- Module Name: d_ff_arst - Behavioral
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

entity d_ff_arst is
    Port 
    ( 
           clk    : in STD_LOGIC;
           rst  : in STD_LOGIC;
           j     : in STD_LOGIC;
           k     : in STD_LOGIC;
           q     : out STD_LOGIC;
           q_bar : out STD_LOGIC;
           s_q     : out STD_LOGIC;
           s_q_bar : out STD_LOGIC
     );
end d_ff_arst;

architecture Behavioral of d_ff_arst is

begin
    p_t_ff_rst : process(clk,rst)
        begin
            if rising_edge(clk) then
                if (rst = '1') then
                    s_q     <= '0';
                    s_q_bar <= '1';    
                else
                    if (t = '1') then
                        s_q       <= not s_q;
                        s_q_bar   <= not s_q_bar;
                    else
                        s_q       <=  s_q;
                        s_q_bar   <=  s_q_bar; 
                    end if;
                end if;
            end if;
    end process p_t_ff_rst;

    q       <= s_q;
    q_bar   <= s_q_bar;

end Behavioral;
