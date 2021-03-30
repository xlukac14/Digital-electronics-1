# Lab 07-FFS

### My GitHub repository

https://github.com/xlukac14/Digital-electronics-1

## Task1: Preparation

### D-type Flip-Flop

   | **d** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-- |
   | 0 | 0 | 0 | Remember |
   | 0 | 1 | 0 | Remember |
   | 1 | 0 | 1 | Sample |
   | 1 | 1 | 1 | Sample |

### JK-type Flip-Flop

   | **j** | **k** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | 0 | 0 | 0 | 0 | No Change |
   | 0 | 0 | 1 | 1 | No Change |
   | 0 | 1 | 0 | 0 | Reset |
   | 0 | 1 | 1 | 0 | Reset |
   | 1 | 0 | 0 | 1 | Set |
   | 1 | 0 | 1 | 1 | Set |
   | 1 | 1 | 0 | 1 | Toggle |
   | 1 | 1 | 1 | 0 | Toggle |

### T-type Flip-Flop

   | **t** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-- |
   | 0 | 0 | 0 | No Change |
   | 0 | 1 | 1 | No Change |
   | 1 | 0 | 1 | Toggle |
   | 1 | 1 | 0 | Toggle |

## Task2: D latch

### VHDL code listing of the process p_d_latch

```vhdl
    p_d_latch : process(d, arst, en)
    begin
        if (arst = '1') then
            q <= '0';
            q_bar <= '1';
            
        elsif (en = '1') then
            q <= d;
            q_bar <= not d;
        end if;
    end process p_d_latch;
```

### Listing of VHDL reset and stimulus processes from the testbench tb_d_latch.vhd

```vhdl
    p_reset_gen : process
    begin
        s_arst <= '0';
        wait for 50 ns;
        
        -- Reset activated
        s_arst <= '1';
        wait for 10 ns;

        -- Reset deactivated
        s_arst <= '0';
        wait for 108ns;
        
        wait;
    end process p_reset_gen;

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
     p_stimulus : process
     begin
       report "Stimulus process started" severity note;
       
       s_en   <= '0';
       s_d    <= '0';
       s_arst <= '0';
       wait for 20 ns;
            
       s_d    <= '1';  
       wait for 20 ns;  
       s_d    <= '0';
       wait for 20 ns;
       s_d    <= '1';  
       wait for 20 ns;  
       s_d    <= '0';
       wait for 20 ns;
       
       --test enable
       s_en   <= '1';
       wait for 20 ns;
       s_d    <= '1';
       wait for 20 ns;
       s_d    <= '0';   
       wait for 20 ns;
       s_d    <= '1'; 
       wait for 20 ns;
       s_d    <= '0'; 
       wait for 20 ns;
       s_en   <= '0'; --enable deactivated
       wait for 20 ns;
       s_d    <= '1';
       wait for 20 ns;
       s_d    <= '0';   
       wait for 20 ns;
       s_d    <= '1'; 
       wait for 20 ns;
       s_d    <= '0'; 
       wait for 20 ns;

       --test reset
       s_en   <= '1';
        wait for 20 ns;
       s_d    <= '1';
        wait for 20 ns;
       s_d    <= '0';   
       wait for 20 ns;
       s_d    <= '1'; 
       wait for 20 ns;
       s_d    <= '0'; 
       wait for 20 ns;
       s_arst <= '1'; --reset active
       wait for 20 ns;
       s_d    <= '1';
       wait for 20 ns;
       s_d    <= '0';
       wait for 20 ns;
       s_arst <= '0'; --reset deactive
       wait for 50 ns;
       s_d    <= '1';
       wait for 20 ns;
       s_d    <= '0';   
       wait for 20 ns;
       s_d    <= '1'; 
       wait for 20 ns;
       s_d    <= '0'; 
       wait for 20 ns;
                    
       report "Stimulus process finished" severity note;
       wait;
   end process p_stimulus;
```

### Screenshot with simulated time waveforms

![screenshot_a]()

## Task3: Flip-Flops

### VHDL code listing of the processes p_d_ff_arst, p_d_ff_rst, p_jk_ff_rst, p_t_ff_rst

#### p_d_ff_arst

```vhdl
    p_d_ff_arst : process(clk,arst)
    begin
        if (arst = '1') then
            q <= '0';
            q_bar <= '1';
            
        elsif rising_edge(clk) then
            q <= d;
            q_bar <= not d;
        end if;
    end process p_d_ff_arst;
```

#### p_d_ff_rst

```vhdl
    p_d_ff_rst : process(clk,rst)
        begin
            if rising_edge(clk) then
                if (rst = '1') then
                    q     <= '0';
                    q_bar <= '1';    
                else
                    q       <= d;
                    q_bar   <= not d;
                end if;
            end if;
    end process p_d_ff_rst;
```

#### p_jk_ff_rst

```vhdl
    p_jk_ff_rst : process(clk,rst)
        begin    
            if rising_edge(clk) then
                if (rst = '1') then
                    q       <= '0';
                    q_bar   <= '1';
                else
                    if (j = '0' and k = '0') then
                        q       <= q;
                        q_bar   <= q_bar;
                    elsif (j = '0' and k = '1') then 
                        q       <= '0';
                        q_bar   <= '1';
                    elsif (j = '1' and k = '0') then 
                        q       <= '1';
                        q_bar   <= '0';
                    else 
                        q       <= not q;
                        q_bar   <= not q_bar;     
                    end if;
                end if;
            end if;
    end process p_jk_ff_rst;
```

#### p_t_ff_rst

```vhdl
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
```

### Listing of VHDL clock, reset and stimulus processes from the testbench files

#### tb_p_d_ff_arst

```vhdl
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
        s_arst <= '0';
        wait for 300 ns;
        s_arst <= '1';                 
        wait for 100 ns;
        s_arst <= '0';
        wait for 17 ns;
        s_arst <= '1';
        wait for 7 ns;
        s_arst <= '0';
        wait;
    end process p_reset_gen;
    
    p_stimulus : process
    begin
       report "Stimulus process started" severity note;
       

       s_d    <= '0';
       
       wait for 20 ns;
            
       s_d    <= '1';  
       wait for 20 ns;  
       s_d    <= '0';
       wait for 20 ns;
       s_d    <= '1';  
       wait for 20 ns;  
       s_d    <= '0';
       wait for 20 ns;   
       
       
       
       wait for 20 ns;
       s_d    <= '1';
       wait for 20 ns;
       s_d    <= '0';   
       wait for 20 ns;
       s_d    <= '1'; 
       wait for 20 ns;
       s_d    <= '0'; 
       wait for 20 ns; 
       
       wait for 20 ns;
       s_d    <= '1';
       wait for 20 ns;
       s_d    <= '0';   
       wait for 20 ns;
       s_d    <= '1'; 
       wait for 70 ns;
       s_d    <= '0'; 
       wait for 20 ns; 
       
       
       
       
       
        wait for 20 ns;
       s_d    <= '1';
        wait for 20 ns;
       s_d    <= '0';   
       wait for 20 ns;
       s_d    <= '1'; 
       wait for 20 ns;
       s_d    <= '0'; 
       wait for 20 ns;
      
       wait for 20 ns;
       s_d    <= '1';
       wait for 20 ns;
       s_d    <= '0';
       wait for 20 ns;
       wait for 50 ns;
       s_d    <= '1';
       wait for 20 ns;
       s_d    <= '0';   
       wait for 20 ns;
       s_d    <= '1'; 
       wait for 20 ns;
       s_d    <= '0'; 
       wait for 20 ns;
       
       report "Stimulus process finished" severity note;
       wait;
   end process p_stimulus;
```

#### tb_p_d_ff_rst

```vhdl
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
        s_arst <= '0';
        wait for 300 ns;
        s_arst <= '1';                 -- Reset activated
        wait for 100 ns;
        s_arst <= '0';
        wait for 17 ns;
        s_arst <= '1';
        wait for 7 ns;
        s_arst <= '0';
        wait;
    end process p_reset_gen;
    
    p_stimulus : process
    begin
       report "Stimulus process started" severity note;
       

       s_d    <= '0';
       
       wait for 20 ns;
            
       s_d    <= '1';  
       wait for 20 ns;  
       s_d    <= '0';
       wait for 20 ns;
       s_d    <= '1';  
       wait for 20 ns;  
       s_d    <= '0';
       wait for 20 ns;   --100ns
       
       
       
       wait for 20 ns;
       s_d    <= '1';
       wait for 20 ns;
       s_d    <= '0';   
       wait for 20 ns;
       s_d    <= '1'; 
       wait for 20 ns;
       s_d    <= '0'; 
       wait for 20 ns; -- 200 ns
       
       wait for 20 ns;
       s_d    <= '1';
       wait for 20 ns;
       s_d    <= '0';   
       wait for 20 ns;
       s_d    <= '1'; 
       wait for 70 ns;
       s_d    <= '0'; 
       wait for 20 ns; --350ns
       
       
       
       --test reset
       
        wait for 20 ns;
       s_d    <= '1';
        wait for 20 ns;
       s_d    <= '0';   
       wait for 20 ns;
       s_d    <= '1'; 
       wait for 20 ns;
       s_d    <= '0'; 
       wait for 20 ns;
      
       wait for 20 ns;
       s_d    <= '1';
       wait for 20 ns;
       s_d    <= '0';
       wait for 20 ns;
       wait for 50 ns;
       s_d    <= '1';
       wait for 20 ns;
       s_d    <= '0';   
       wait for 20 ns;
       s_d    <= '1'; 
       wait for 20 ns;
       s_d    <= '0'; 
       wait for 20 ns;
       
       report "Stimulus process finished" severity note;
       wait;
   end process p_stimulus;
```

#### tb_jk_ff_rst

```vhdl
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
        s_rst <= '1';                 
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
       

       s_j    <= '0';
       s_k    <= '0';
       wait for 20 ns;
            
       s_j    <= '1';
       s_k    <= '0';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '0';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '1';
       wait for 20 ns;
       s_j    <= '1';
       s_k    <= '1';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '0';
       wait for 20 ns; 
       
       s_j    <= '1';
       s_k    <= '0';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '0';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '1';
       wait for 20 ns;
       s_j    <= '1';
       s_k    <= '1';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '0';
       wait for 20 ns;
       
       s_j    <= '1';
       s_k    <= '0';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '0';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '1';
       wait for 20 ns;
       s_j    <= '1';
       s_k    <= '1';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '0';
       wait for 20 ns;
       
       s_j    <= '1';
       s_k    <= '0';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '0';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '1';
       wait for 20 ns;
       s_j    <= '1';
       s_k    <= '1';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '0';
       wait for 20 ns;
       
       s_j    <= '1';
       s_k    <= '0';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '0';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '1';
       wait for 20 ns;
       s_j    <= '1';
       s_k    <= '1';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '0';
       wait for 20 ns;
       
       s_j    <= '1';
       s_k    <= '0';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '0';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '1';
       wait for 20 ns;
       s_j    <= '1';
       s_k    <= '1';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '0';
       wait for 20 ns;
       
       s_j    <= '1';
       s_k    <= '0';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '0';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '1';
       wait for 20 ns;
       s_j    <= '1';
       s_k    <= '1';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '0';
       wait for 20 ns;
       
       s_j    <= '1';
       s_k    <= '0';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '0';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '1';
       wait for 20 ns;
       s_j    <= '1';
       s_k    <= '1';
       wait for 20 ns;
       s_j    <= '0';
       s_k    <= '0';
       wait for 20 ns;
       
       
       report "Stimulus process finished" severity note;
       wait;
   end process p_stimulus;
```

#### tb_t_ff_rst

```vhdl
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
        s_rst <= '1';             
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
       wait for 20 ns;  
       
       
       
       wait for 20 ns;
       s_t    <= '1';
       wait for 20 ns;
       s_t    <= '0';   
       wait for 20 ns;
       s_t    <= '1'; 
       wait for 20 ns;
       s_t    <= '0'; 
       wait for 20 ns; 
       
       wait for 20 ns;
       s_t    <= '1';
       wait for 20 ns;
       s_t    <= '0';   
       wait for 20 ns;
       s_t    <= '1'; 
       wait for 70 ns;
       s_t    <= '0'; 
       wait for 20 ns; 
       
       
       
       
       
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
```

### Screenshot with simulated time waveforms

#### D_ARST_FF

![screenshot_b]()

#### D_RST_FF

![screenshot_c]()

#### JK_RST_FF

![screenshot_d]()

#### T_RST_FF

![screenshot_e]()

### Task4: Shift register 

![screenshot_f]()

