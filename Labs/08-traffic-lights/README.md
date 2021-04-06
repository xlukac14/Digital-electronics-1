# Lab 08-Traffic-Lights

### My GitHub repository

https://github.com/xlukac14/Digital-electronics-1

## Task1: Preparation

### State table

| **Input P** | `0` | `0` | `1` | `1` | `0` | `1` | `0` | `1` | `1` | `1` | `1` | `0` | `0` | `1` | `1` | `1` |
| :-- | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| **Clock** | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) |
| **State** | A | A | B | C | C | D | A | B | C | D | B | B | B | C | D | B |
| **Output R** | `0` | `0` | `0` | `0` | `0` | `1` | `0` | `0` | `0` | `1` | `0` | `0` | `0` | `0` | `1` | `0` |

### Figure with connection of RGB LEDs on Nexys A7 board

![image1](https://github.com/xlukac14/Digital-electronics-1/blob/main/Labs/08-traffic-lights/Images/RGB.png)

### Table with color settings

| **RGB LED** | **Artix-7 pin names** | **Red** | **Yellow** | **Green** |
| :-: | :-: | :-: | :-: | :-: |
| LD16 | N15, M16, R12 | `1,0,0` | `1,1,0` | `0,1,0` |
| LD17 | N16, R11, G14 | `1,0,0` | `1,1,0` | `0,1,0` |


## Task2: Traffic light controller

### State diagram

![image_a](https://github.com/xlukac14/Digital-electronics-1/blob/main/Labs/08-traffic-lights/Images/image_a.jpg)

### VHDL code of sequential process p_traffic_fsm

```vhdl
    p_traffic_fsm : process(clk)
    
     
    begin
        if rising_edge(clk) then
            if (reset = '1') then       -- Synchronous reset
                s_state <= STOP1 ;      -- Set initial state
                s_cnt   <= c_ZERO;      -- Clear all bits

            elsif (s_en = '1') then
                -- Every 250 ms, CASE checks the value of the s_state 
                -- variable and changes to the next state according 
                -- to the delay value.
                case s_state is

                    -- If the current state is STOP1, then wait 1 sec
                    -- and move to the next GO_WAIT state.
                    when STOP1 =>                                           
                        -- Count up to c_DELAY_STOP
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= WEST_GO;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;

                    when WEST_GO =>                                         
                        -- Count up to c_DELAY_GO
                        if (s_cnt < c_DELAY_4SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= WEST_WAIT;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                    
                    when WEST_WAIT =>                                       
                        -- Count up to c_DELAY_WAIT
                        if (s_cnt < c_DELAY_2SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= STOP2;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                        
                    when STOP2 =>                                           
                        -- Count up to c_DELAY_STOP
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= SOUTH_GO;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if; 
                        
                    when SOUTH_GO =>                                        
                        -- Count up to c_DELAY_GO
                        if (s_cnt < c_DELAY_4SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= SOUTH_WAIT;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                        
                    when SOUTH_WAIT =>                                      
                        -- Count up to c_DELAY_WAIT
                        if (s_cnt < c_DELAY_2SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= STOP1;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;    
                        
                    -- It is a good programming practice to use the 
                    -- OTHERS clause, even if all CASE choices have 
                    -- been made. 
                    when others =>                                          
                        s_state <= STOP1;

                end case;
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_traffic_fsm;
```

### VHDL code of combinatorial process p_output_fsm

```vhdl
    p_output_fsm : process(s_state)
    begin
        case s_state is
            when STOP1 =>
                south_o <= "100";   
                west_o  <= "100";   
                
            when WEST_GO =>
                south_o <= "100";   
                west_o  <= "010";   
                
            when WEST_WAIT =>
                south_o <= "100";   
                west_o  <= "110";  
                
            when STOP2 =>
                south_o <= "100";   
                west_o  <= "100";   
                
            when SOUTH_GO =>
                south_o <= "010";   
                west_o  <= "100";   
                
            when SOUTH_WAIT =>
                south_o <= "110";   
                west_o  <= "100";   
            
            when others =>
                south_o <= "100";   
                west_o  <= "100";   
        end case;
    end process p_output_fsm;
```

### Screenshots of the simulation,

![screenshot_a](https://github.com/xlukac14/Digital-electronics-1/blob/main/Labs/08-traffic-lights/Images/screenshot_a.PNG)

![screenshot_b](https://github.com/xlukac14/Digital-electronics-1/blob/main/Labs/08-traffic-lights/Images/screenshot_b.PNG)

![screenshot_c](https://github.com/xlukac14/Digital-electronics-1/blob/main/Labs/08-traffic-lights/Images/screenshot_c.PNG)

![screenshot_d](https://github.com/xlukac14/Digital-electronics-1/blob/main/Labs/08-traffic-lights/Images/screenshot_d.PNG)

## Task3: Smart controller

### State table

| **Current State** | **State Change** | **Min. Delay** |
| :-: | :-: | :-: |
| STOP1 | always | 1s |
| WEST_GO | sensor south | 4s |
| WEST_WAIT | always | 2s |
| STOP2 | always | 1s |
| SOUTH_GO | sensor west | 4s |
| SOUTH_WAIT | always | 2s |

### State diagram

![image_b.jpg](https://github.com/xlukac14/Digital-electronics-1/blob/main/Labs/08-traffic-lights/Images/image_b.jpg)

### VHDL code of sequential process p_smart_traffic_fsm

```vhdl
p_smart_traffic_fsm : process(clk)
    
     
    begin
        if rising_edge(clk) then
            if (reset = '1') then       -- Synchronous reset
                s_state <= STOP1 ;      -- Set initial state
                s_cnt   <= c_ZERO;      -- Clear all bits

            elsif (s_en = '1') then
                -- Every 250 ms, CASE checks the value of the s_state 
                -- variable and changes to the next state according 
                -- to the delay value.
                case s_state is

                    -- If the current state is STOP1, then wait 1 sec
                    -- and move to the next GO_WAIT state.
                    when STOP1 =>                                         
                        -- Count up to c_DELAY_STOP
                        if (s_cnt < c_DELAY_STOP) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= WEST_GO;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;

                    when WEST_GO =>
                        -- Count up to c_DELAY_GO
                        if (s_cnt < c_DELAY_GO) then
                            s_cnt <= s_cnt + 1;
                        else
                            if SW(1) = '1' then
                            
                            s_state <= WEST_WAIT;
                            end if;
                            
                            s_cnt   <= c_ZERO;
                        end if;
                    
                    when WEST_WAIT =>                                      
                        -- Count up to c_DELAY_WAIT
                        if (s_cnt < c_DELAY_WAIT) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= STOP2;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                        
                    when STOP2 =>                                           
                        -- Count up to c_DELAY_STOP
                        if (s_cnt < c_DELAY_STOP) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= SOUTH_GO;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if; 
                        
                    when SOUTH_GO =>                                       
                        -- Count up to c_DELAY_GO
                        if (s_cnt < c_DELAY_GO) then
                            s_cnt <= s_cnt + 1;
                        else
                            if SW(0) = '1' then     
                            
                            s_state <= SOUTH_WAIT;
                            end if;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                        
                    when SOUTH_WAIT =>                                    
                        -- Count up to c_DELAY_WAIT
                        if (s_cnt < c_DELAY_WAIT) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= STOP1;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;    
                        
                    -- It is a good programming practice to use the 
                    -- OTHERS clause, even if all CASE choices have 
                    -- been made. 
                    when others =>                                          
                        s_state <= STOP1;

                end case;
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_smart_traffic_fsm;
```







