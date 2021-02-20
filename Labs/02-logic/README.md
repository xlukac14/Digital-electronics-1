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

(https://www.edaplayground.com/x/cerU)

## Task 3: A 4-bit binary comparator

### Listing of VHDL architecture from design file

```ruby
library ieee;
use ieee.std_logic_1164.all;

entity comparator_2bit is
    port(
        a_i           : in  std_logic_vector(4 - 1 downto 0);
		b_i           : in  std_logic_vector(4 - 1 downto 0);
		B_greater_A_o : out std_logic;
        B_equals_A_o  : out std_logic;
        B_less_A_o    : out std_logic       
    );
end entity comparator_2bit;

architecture Behavioral of comparator_2bit is
begin

    B_greater_A_o  <= '1' when (b_i > a_i) else '0';
	B_equals_A_o   <= '1' when (b_i = a_i) else '0';
	B_less_A_o     <= '1' when (b_i < a_i) else '0';
    
end architecture Behavioral;
```

### Listing of VHDL stimulus process from testbench file





