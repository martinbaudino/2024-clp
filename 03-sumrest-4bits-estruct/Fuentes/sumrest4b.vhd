library IEEE;
	use IEEE.std_logic_1164.all;

	-- 3. Crear en VHDL un sumador/restador de 4 bits de manera estructural con una señal de
	--    control para seleccionar la operación. Simularlo.

entity sumrest4b is
	port (
		a_i  : in  std_logic_vector(3 downto 0);
		b_i  : in  std_logic_vector(3 downto 0);
		sr_i : in  std_logic;
		s_o  : out std_logic_vector(3 downto 0);
		co_o : out std_logic
	);
end entity;

architecture sumrest4b_arq of sumrest4b is
	-- Parte delcarativa
	-- Utiliza el componente sum4b del ejercicio 2.
	component sum4b is
		port (
			a_i  : in  std_logic_vector(3 downto 0);
			b_i  : in  std_logic_vector(3 downto 0);
			ci_i : in  std_logic;
			s_o  : out std_logic_vector(3 downto 0);
			co_o : out std_logic
		);
	end component;

	-- La entrada sr_i define si es suma o resta => aux = B xor sr para la resta será A + *B + 1 con sum4b.ci_i = sr
	signal aux : std_logic_vector(3 downto 0);

begin
	-- Parte descriptiva
	-- Para realizar la operación bit a bit se extiende el valor del selector de suma/resta
	aux <= b_i xor (b_i'range => sr_i);

	-- Etiqueta: Nom_componente port map y la conexión
	sum4b_inst: sum4b
		port map (
			-- Los elementos a la derecha se refieren a los de la entidad sumrest4b
			a_i  => a_i,
			b_i  => aux,
			ci_i => sr_i,
			s_o  => s_o,
			co_o => co_o
		);

end architecture;


