library IEEE;
	use IEEE.std_logic_1164.all;

	-- 1. Crear en VHDL un sumador completo de 1 bit. Simularlo.

entity sum1b is
	port (
		a_i  : in  std_logic;
		b_i  : in  std_logic;
		ci_i : in  std_logic;
		s_o  : out std_logic;
		co_o : out std_logic
	);
end entity;

architecture sum1b_arq of sum1b is
	-- Parte delcarativa
begin
	-- Parte descriptiva
	-- Cálculo combinacional de la salida
	s_o <= a_i xor b_i xor ci_i;
	-- Cálculo combinacional del carry out
	co_o <= (a_i and b_i) or (a_i and ci_i) or (b_i and ci_i);
end architecture;


