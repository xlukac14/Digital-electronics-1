# Lab 02-logic

## My GitHub repository

https://github.com/xlukac14/Digital-electronics-1

## Task 1: Truth table

| **Dec. equivalent** | **B[1:0]** | **A[1:0]** | **B is greater than A** | **B equals A** | **B is less than A** |
| :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0 0 | 0 0 | 0 | 1 | 0 |
| 1 | 0 0 | 0 1 | 0 | 0 | 1 |
| 2 | 0 0 | 1 0 | 0 | 0 | 1 |
| 3 | 0 0 | 1 1 | 0 | 0 | 1 |
| 4 | 0 1 | 0 0 | 1 | 0 | 0 |
| 5 | 0 1 | 0 1 | 0 | 1 | 0 |
| 6 | 0 1 | 1 0 | 0 | 0 | 1 |
| 7 | 0 1 | 1 1 | 0 | 0 | 1 |
| 8 | 1 0 | 0 0 | 1 | 0 | 0 |
| 9 | 1 0 | 0 1 | 1 | 0 | 0 |
| 10 | 1 0 | 1 0 | 0 | 1 | 0 |
| 11 | 1 0 | 1 1 | 0 | 0 | 1 |
| 12 | 1 1 | 0 0 | 1 | 0 | 0 |
| 13 | 1 1 | 0 1 | 1 | 0 | 0 |
| 14 | 1 1 | 1 0 | 1 | 0 | 0 |
| 15 | 1 1 | 1 1 | 0 | 1 | 0 |

## Task 2: A 2-bit comparator

### Karnaugh maps

#### B<A

![B<A](https://github.com/xlukac14/Digital-electronics-1/blob/main/Labs/02-logic/Images/BlessA2.png "B<A")

#### B=A

![B=A](https://github.com/xlukac14/Digital-electronics-1/blob/main/Labs/02-logic/Images/BequalsA2.png "B=A")

#### B>A

![B>A](https://github.com/xlukac14/Digital-electronics-1/blob/main/Labs/02-logic/Images/BgreaterA2.png "B>A")

### Equations of simplified SoP (greater than) and PoS (less than) functions

B<A (PoS)-> NOT A1 * B1 + NOT A0 * B1 * B0 + NOT A1 * NOT A0 * B0

B>A (SoP) -> (NOT B1 + A1) * (NOT B0 + A1) * (A0 + A1) * (NOT B1 + NOT B0) * (NOT B1 + A0)

### EDA Playground Link

https://www.edaplayground.com/x/cerU

## Task 3: A 4-bit binary comparator

### Listing of VHDL architecture from design file

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity comparator_4bit is
    port(
        a_i           : in  std_logic_vector(4 - 1 downto 0);
	b_i           : in  std_logic_vector(4 - 1 downto 0);
	B_greater_A_o : out std_logic;
        B_equals_A_o  : out std_logic;
        B_less_A_o    : out std_logic       
    );
end entity comparator_4bit;

architecture Behavioral of comparator_4bit is
begin

        B_greater_A_o  <= '1' when (b_i > a_i) else '0';
	B_equals_A_o   <= '1' when (b_i = a_i) else '0';
	B_less_A_o     <= '1' when (b_i < a_i) else '0';
    
end architecture Behavioral;
```

### Listing of VHDL stimulus process from testbench file

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity tb_comparator_4bit is
    
end entity tb_comparator_4bit;


architecture testbench of tb_comparator_4bit is

    signal s_a           : std_logic_vector(4 - 1 downto 0);
    signal s_b           : std_logic_vector(4 - 1 downto 0);
    signal s_B_greater_A : std_logic;
    signal s_B_equals_A  : std_logic;
    signal s_B_less_A    : std_logic;

begin
    
    uut_comparator_4bit : entity work.comparator_4bit
        port map(
            a_i           => s_a,
            b_i           => s_b,
            B_greater_A_o => s_B_greater_A,
            B_equals_A_o  => s_B_equals_A,
            B_less_A_o    => s_B_less_A
        );

    
    p_stimulus : process
    begin
      
        report "Stimulus process started" severity note;

        s_b <= "0000"; s_a <= "0011"; wait for 100 ns;
        assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
        report "Test failed for input combination: 0000, 0011" severity error;
        
        s_b <= "1000"; s_a <= "1011"; wait for 100 ns;
        assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
        report "Test failed for input combination: 1000, 1011" severity error;
        
        s_b <= "0010"; s_a <= "0000"; wait for 100 ns;
        assert ((s_B_greater_A = '1') and (s_B_equals_A = '0') and (s_B_less_A = '0'))
        report "Test failed for input combination: 0010, 0000" severity error;
        
        s_b <= "0110"; s_a <= "0011"; wait for 100 ns;
        assert ((s_B_greater_A = '1') and (s_B_equals_A = '0') and (s_B_less_A = '0'))
        report "Test failed for input combination: 0110, 0011" severity error;
        
        s_b <= "1001"; s_a <= "1001"; wait for 100 ns;
        assert ((s_B_greater_A = '0') and (s_B_equals_A = '1') and (s_B_less_A = '0'))
        report "Test failed for input combination: 1001, 1001" severity error;
        --
        s_b <= "1110"; s_a <= "0111"; wait for 100 ns;
        assert ((s_B_greater_A = '1') and (s_B_equals_A = '0') and (s_B_less_A = '0'))
        report "Test failed for input combination: 1110, 0111" severity error;
        
        s_b <= "1110"; s_a <= "1011"; wait for 100 ns;
        assert ((s_B_greater_A = '1') and (s_B_equals_A = '0') and (s_B_less_A = '0'))
        report "Test failed for input combination: 1110, 1011" severity error;
        
        s_b <= "0101"; s_a <= "1010"; wait for 100 ns;
        assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
        report "Test failed for input combination: 0101, 1010" severity error;
        
        s_b <= "0010"; s_a <= "0010"; wait for 100 ns;
        assert ((s_B_greater_A = '0') and (s_B_equals_A = '1') and (s_B_less_A = '0'))
        report "Test failed for input combination: 0010, 0010" severity error;
        
        --intentional error
        s_b <= "1011"; s_a <= "0111"; wait for 100 ns;
        assert ((s_B_greater_A = '0') and (s_B_equals_A = '1') and (s_B_less_A = '0'))
        report "Test failed for input combination: 1011, 0111" severity error;
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
```

### Listing of simulator console output

```
[2021-02-20 04:43:09 EST] ghdl -i design.vhd testbench.vhd  && ghdl -m  tb_comparator_2bit && ghdl -r  tb_comparator_2bit   --vcd=dump.vcd && sed -i 's/^U/X/g; s/^-/X/g; s/^H/1/g; s/^L/0/g' dump.vcd 
analyze design.vhd
analyze testbench.vhd
elaborate tb_comparator_2bit
testbench.vhd:32:9:@0ms:(report note): Stimulus process started
testbench.vhd:72:9:@1us:(assertion error): Test failed for input combination: 1011, 0111
testbench.vhd:75:9:@1us:(report note): Stimulus process finished
Finding VCD file...
./dump.vcd
[2021-02-20 04:43:10 EST] Opening EPWave...
Done
```

### EDA playground link

https://www.edaplayground.com/x/E6vE


