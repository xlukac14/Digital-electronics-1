# Lab 01-gates 

## My GitHub repository

https://github.com/xlukac14/Digital-electronics-1

## Task 1: Verification of De Morgan's laws

| **c** | **b** |**a** | **f(c,b,a)** |
| :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 1 |
| 0 | 0 | 1 | 1 |
| 0 | 1 | 0 | 0 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 |
| 1 | 1 | 0 | 0 |
| 1 | 1 | 1 | 0 |

### vhdl code (design.vhd)

```
library ieee;               
use ieee.std_logic_1164.all;

entity gates is
    port(
    	
        a_i     : in  std_logic;         
        b_i     : in  std_logic;         
        c_i	: in  std_logic;			
        f_o     : out std_logic;        
        fnand_o : out std_logic;         
        fnor_o  : out std_logic
        
    );
end entity gates;


architecture dataflow of gates is
begin
    f_o  <= ((not b_i) and a_i) or ((not c_i) and (not b_i));
    fnand_o <= not(not((not b_i) and (a_i)) and not((not c_i) and (not b_i)));
    fnor_o <= not((b_i) or (not a_i)) or not((c_i) or (b_i));
    
end architecture dataflow;
```

### Screenshot with simulated time waveforms

![De Morgan's laws simulation](Images/DMlaws.png)

### EDA Playground Link

[De Morgan's laws](https://www.edaplayground.com/x/m53W)

## Task 2: Verification of Distributive laws + Boolean's postulates

### vhdl code (design.vhd)

```
library ieee;               
use ieee.std_logic_1164.all;

entity gates is
    port(
        x_i		: in  std_logic;
        y_i		: in  std_logic;
        z_i		: in  std_logic;
        fbp1_o		: out std_logic;	--boolean1
        fbp2_o		: out std_logic;	--boolean2
        fbp3_o		: out std_logic;	--boolean3
        fbp4_o		: out std_logic;	--boolean4
        fdl1a_o		: out std_logic;	--distributive laws1
        fdl1b_o		: out std_logic;	--distributive laws1
        fdl2a_o		: out std_logic;	--distributive laws2
        fdl2b_o		: out std_logic		--distributive laws2
    );
end entity gates;


architecture dataflow of gates is
begin
    fbp1_o  <= x_i and not x_i;					--boolean1
    fbp2_o  <= x_i or not x_i;					--boolean1
    fbp3_o  <= x_i or x_i or x_i;				--boolean1
    fbp4_o  <= x_i and x_i and x_i;				--boolean1
    fdl1a_o <= (x_i and y_i) or (x_i and z_i);	                --distributive laws1
    fdl1b_o <= x_i and (y_i or z_i);			        --distributive laws1
    fdl2a_o <= (x_i or y_i) and (x_i or z_i);	                --distributive laws2
    fdl2b_o <= x_i or (y_i and z_i);			        --distributive laws2
    	
end architecture dataflow;
```

### Screenshots with simulated time waveforms

![Distributive laws simulation](Images/Dlaws.png)
![Boolean's postulates simulation](Images/Bpostulates.png)


### EDA Playground Link

[Distributive laws + Boolean's postulates](https://www.edaplayground.com/x/srNS)


