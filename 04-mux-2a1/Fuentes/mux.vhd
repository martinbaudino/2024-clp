library IEEE;
	use IEEE.std_logic_1164.all;

	-- 4. Crear en VHDL un multiplexor 2x1. Simularlo.

entity mux is
	port (
		a_i   : in  std_logic;
		b_i   : in  std_logic;
		sel_i : in  std_logic;
		sal_o : out std_logic
	);
end entity;

architecture mux_arq of mux is
	-- Parte delcarativa
begin
	-- Parte descriptiva
	-- Con sentencia concurrente when/else sería
	-- sal_o <= a_i when sel_i = '1' else b_i;
	sal_o <= (a_i and sel_i) or (b_i and not sel_i);

end architecture;


