library IEEE;
	use IEEE.std_logic_1164.all;

	-- 2. Crear en VHDL un sumador de 4 bits de manera estructural. Simularlo.

entity sum4b is
	port (
		-- La interfaz cambia de 1 a 4 bits
		a_i  : in  std_logic_vector(3 downto 0);
		b_i  : in  std_logic_vector(3 downto 0);
		ci_i : in  std_logic;
		s_o  : out std_logic_vector(3 downto 0);
		co_o : out std_logic
	);
end entity;

architecture sum4b_arq of sum4b is
	-- Parte delcarativa
	-- Utiliza el componente sum1b del ejercicio 1.
	component sum1b is
		port (
			a_i  : in  std_logic;
			b_i  : in  std_logic;
			ci_i : in  std_logic;
			s_o  : out std_logic;
			co_o : out std_logic
		);
	end component;

	-- La señal para los carry tiene que tener un bit mas por el ci
	signal aux : std_logic_vector(4 downto 0);

begin
	-- Parte descriptiva
	-- Se conecta la entrada de ci con la señal correspondiente
	aux(0) <= ci_i;
	-- Etiqueta: Nom_componente port map y la conexión
	sum1b_0: sum1b
		port map (
			-- Los elementos a la derecha se refieren a los de la entidad sum4b
			a_i  => a_i(0),
			b_i  => b_i(0),
			ci_i => aux(0),
			s_o  => s_o(0),
			co_o => aux(1)
		);

	sum1b_1: sum1b
		port map (
			-- Los elementos a la derecha se refieren a los de la entidad sum4b
			a_i  => a_i(1),
			b_i  => b_i(1),
			ci_i => aux(1),
			s_o  => s_o(1),
			co_o => aux(2)
		);

	sum1b_2: sum1b
		port map (
			-- Los elementos a la derecha se refieren a los de la entidad sum4b
			a_i  => a_i(2),
			b_i  => b_i(2),
			ci_i => aux(2),
			s_o  => s_o(2),
			co_o => aux(3)
		);
	sum1b_3: sum1b
		port map (
			-- Los elementos a la derecha se refieren a los de la entidad sum4b
			a_i  => a_i(3),
			b_i  => b_i(3),
			ci_i => aux(3),
			s_o  => s_o(3),
			co_o => aux(4)
		);

	-- Conecta la señal del carry out con la salida co
	co_o <= aux(4);
	-- El orden de las declaraciones no importa porque se evaluan de manera concurrente
end architecture;


