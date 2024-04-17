library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

entity barrelsh is
	generic (
		M : natural := 4;
		N : natural := 8
	);
	port (
		a_i   : in  std_logic_vector(N - 1 downto 0);
		des_i : in  std_logic_vector(M - 1 downto 0);
		s_o   : out std_logic_vector(N - 1 downto 0)
	);
end entity;

architecture barrelsh_arq of barrelsh is
	-- Parte delcarativa

begin
	-- Parte descriptiva
	process (a_i, des_i)
		variable desp_entrada : integer;
		variable temp_val : std_logic_vector(N - 1 downto 0);
	begin
		-- Cantidad de bits a desplazar a la derecha coomo número entero
		desp_entrada := to_integer(unsigned(des_i));
		temp_val := a_i;

		-- Para cada cuenta, se desplaza el valor a la derecha y se 
		-- ingresa un '0' desde la izquierda
		for i in 1 to desp_entrada loop
			temp_val := '0' & temp_val(N-1 downto 1);
		end loop;

		s_o <= temp_val;
	end process;

end architecture;


