library IEEE;
use IEEE.std_logic_1164.all;

entity Monostabil is
  port(
       Buton : in STD_LOGIC;
       Clk : in STD_LOGIC;
       ButonMono : out STD_LOGIC
  );
end Monostabil;

architecture Monostabil of Monostabil is

component D_flip_flop
  port (
       D : in STD_LOGIC;
       clk : in STD_LOGIC;
       Q : out STD_LOGIC
  );
end component;

constant VCC_CONSTANT   : STD_LOGIC := '1';
signal NET61 : STD_LOGIC;
signal NET64 : STD_LOGIC;
signal NET72 : STD_LOGIC;
signal VCC : STD_LOGIC;

begin
U1 : D_flip_flop
  port map(
       D => Buton,
       Q => NET61,
       clk => Clk
  );
U2 : D_flip_flop
  port map(
       D => NET61,
       Q => NET64,
       clk => clk
  );

NET72 <= not(NET64) and NET61;

ButonMono <= NET72 and VCC;

VCC <= VCC_CONSTANT;

end Monostabil;
