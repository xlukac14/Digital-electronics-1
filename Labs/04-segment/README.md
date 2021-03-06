# Lab 04-Segment

## My GitHub repository

https://github.com/xlukac14/Digital-electronics-1

## Task1: Preparation

### Table with connection of 7-segment displays

| **SW** | **SW-PIN** | **AN(transistor)** | **AN-PIN** | **7seg-led** | **7seg-PIN** |
| :-: | :-: | :-: | :-: | :-: | :-: |
| **SW0** | J15 | AN7 | U13 | CA | T10 |
| **SW1** | L16 | AN6 | K2 | CB | R10 |
| **SW2** | M13 | AN5 | T14 | CC | K16 |
| **SW3** | R15 | AN4 | P14 | CD | K13 |
| **SW4** | R17 | AN3 | J14 | CE | P15 |
| **SW5** | T18 | AN2 | T9 | CF | T11 |
| **SW6** | U18 | AN1 | J18 | CG | L18 |
| **SW7** | R13 | AN0 | J17 | DP | H15 |

### Decoder truth table for common anode 7-segment display

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

## Task2: Seven-segment display decoder

### Listing of VHDL architecture

```vhdl
architecture Behavioral of hex_7seg is

begin
    --------------------------------------------------------------------
    -- p_7seg_decoder:
    -- A combinational process for 7-segment display (Common Anode)
    -- decoder. Any time "hex_i" is changed, the process is "executed".
    -- Output pin seg_o(6) controls segment A, seg_o(5) segment B, etc.
    --       segment A
    --        | segment B
    --        |  | segment C
    --        |  |  |   ...   segment G
    --        +-+|+-+          |
    --          |||            |
    -- seg_o = "0000001"-------+
    --------------------------------------------------------------------
    p_7seg_decoder : process(hex_i)
    begin
        case hex_i is
            when "0000" =>
                seg_o <= "0000001";     -- 0
            when "0001" =>
                seg_o <= "1001111";     -- 1
            when "0010" =>
                seg_o <= "0010010";     -- 2
            when "0011" =>
                seg_o <= "0000110";     -- 3
            when "0100" =>
                seg_o <= "1001100";     -- 4
            when "0101" =>
                seg_o <= "0100100";     -- 5
            when "0110" =>
                seg_o <= "0100000";     -- 6
            when "0111" =>
                seg_o <= "0001111";     -- 7
            when "1000" =>
                seg_o <= "0000000";     -- 8
            when "1001" =>
                seg_o <= "0000100";     -- 9
            when "1010" =>
                seg_o <= "0001000";     -- A
            when "1011" =>
                seg_o <= "1100000";     -- b
            when "1100" =>
                seg_o <= "0110001";     -- C
            when "1101" =>
                seg_o <= "1000010";     -- d
            when "1110" =>
                seg_o <= "0110000";     -- E
            when others =>
                seg_o <= "0111000";     -- F
        end case;
    end process p_7seg_decoder;
```

### Listing of VHDL stimulus process

```vhdl
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
```

### Screenshot with simulated time waveforms

![04-segment](https://github.com/xlukac14/Digital-electronics-1/blob/main/Labs/04-segment/images/04-7segment_output.PNG)

### Listing of VHDL code - 7-segment module instantiation

```vhdl
    hex2seg : entity work.hex_7seg
        port map(
            hex_i    => SW,
            seg_o(6) => CA,
            seg_o(5) => CB,
            seg_o(4) => CC,
            seg_o(3) => CD,
            seg_o(2) => CE,
            seg_o(1) => CF,
            seg_o(0) => CG
        );
```

## Task3: LED(7:4) indicators

### Truth table for LEDs(7:4)

| **Hex** | **Inputs** | **LED4** | **LED5** | **LED6** | **LED7** |
| :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0000 | 1 | 0 | 0 | 0 |
| 1 | 0001 | 0 | 0 | 1 | 1 |
| 2 | 0010 | 0 | 0 | 0 | 1 |
| 3 | 0011 | 0 | 0 | 1 | 0 |
| 4 | 0100 | 0 | 0 | 0 | 1 |
| 5 | 0101 | 0 | 0 | 1 | 0 |
| 6 | 0110 | 0 | 0 | 0 | 0 |
| 7 | 0111 | 0 | 0 | 1 | 0 |
| 8 | 1000 | 0 | 0 | 0 | 1 |
| 9 | 1001 | 0 | 0 | 1 | 0 |
| A | 1010 | 0 | 1 | 0 | 0 |
| b | 1011 | 0 | 1 | 1 | 0 |
| C | 1100 | 0 | 1 | 0 | 0 |
| d | 1101 | 0 | 1 | 1 | 0 |
| E | 1110 | 0 | 1 | 0 | 0 |
| F | 1111 | 0 | 1 | 1 | 0 |

### Listing of VHDL code for LEDs(7:4)

```vhdl
    AN <= b"1111_0111";
    LED(4 - 1 downto 0) <= SW;

    -- LED(7:4) indicators
    -- Turn LED(4) on if input value is equal to 0, ie "0000"
    LED(4) <= '1' when SW >= "0000";
    
    -- Turn LED(5) on if input value is greater than "1001", ie 9
    LED(5) <= '1' when SW >= "1001";
    
    -- Turn LED(6) on if input value is odd, ie 1, 3, 5, ...
    LED(6) <= '1' when SW = "0001" else
              '1' when SW = "0011" else
              '1' when SW = "0101" else
              '1' when SW = "0111" else
              '1' when SW = "1001" else
              '1' when SW = "1011" else
              '1' when SW = "1101" else
              '1' when SW = "1111";
    
    -- Turn LED(7) on if input value is a power of two, ie 1, 2, 4, or 8
    LED(7) <= '1' when SW = "0001" else
              '1' when SW = "0010" else
              '1' when SW = "0100" else
              '1' when SW = "1000";
```

### Screenshot with simulated time waveforms

![04-segment]()
