library ieee;
use ieee.std_logic_1164.all;
entity D_flip_flop is
    port (clk,D : in std_logic;
             Q: out std_logic);
end D_flip_flop;

architecture D_comportament of D_flip_flop is
    begin
        process (clk,D)
          begin
           if(clk'event and clk='1') then
                 Q <= D;
           end if;
        end process;
end D_comportament;