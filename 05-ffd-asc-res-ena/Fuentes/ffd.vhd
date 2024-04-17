library IEEE;
	use IEEE.std_logic_1164.all;

	-- 5. Crear en VHDL un flip-flop sensible al flanco ascendente de reloj con reset sincrónico y
	--    entrada de habilitación. Simularlo.

entity ffd is
	port (
		clk_i : in  std_logic;
		rst_i : in  std_logic;
		ena_i : in  std_logic;
		d_i   : in  std_logic;
		q_o   : out std_logic
	);
end entity;

architecture ffd_arq of ffd is
	-- Parte delcarativa
begin
	-- Parte descriptiva
	process (clk_i)
	begin
		if rising_edge(clk_i) then
			if rst_i = '1' then
				q_o <= '0';
			elsif ena_i = '1' then
				q_o <= d_i;
			end if;
			-- podría ir un 
			-- else
			--	q_o <= q_o;
			-- para que la salida sigue igual. Al no ponerlo 
			-- es lo que infiere el sintetizador
			-- No poner else final en el HDL implica generar un elemento de memoria
		end if;
	end process;
end architecture;


