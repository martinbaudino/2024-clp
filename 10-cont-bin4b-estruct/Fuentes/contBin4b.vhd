library IEEE;
	use IEEE.std_logic_1164.all;

	-- 10. Crear en VHDL un contador binario de 4 bits de manera estructural. Simularlo.

entity contBin4b is
	port (
		clk_i    : in  std_logic;
		rst_i    : in  std_logic;
		ena_i    : in  std_logic;
		cuenta_o : out std_logic_vector(3 downto 0)
	);
end entity;

architecture contBin4b_arq of contBin4b is
	-- Parte delcarativa
	component ffd is
		port (
			clk_i : in  std_logic;
			rst_i : in  std_logic;
			ena_i : in  std_logic;
			d_i   : in  std_logic;
			q_o   : out std_logic
		);
	end component;

	-- Señal de intermedia que une la lógica de conexión a las entradas los FFDs
	signal valor_cadena : std_logic_vector(3 downto 0) := (others => '0');
	-- Señal que conecta las salidas de los FFDs con las entradas del siguiente, con valor inicial.
	signal valor_salida : std_logic_vector(3 downto 0) := (others => '0');

begin
	-- Parte descriptiva
	-- Utiliza un registro de 4 FFD de 1 bit y lógica combinacional
	ffd0_inst: ffd
		port map (
			clk_i => clk_i,
			rst_i => rst_i,
			ena_i => ena_i,
			d_i   => valor_cadena(0),
			q_o   => valor_salida(0)
		);

	ffd1_inst: ffd
		port map (
			clk_i => clk_i,
			rst_i => rst_i,
			ena_i => ena_i,
			d_i   => valor_cadena(1),
			q_o   => valor_salida(1)
		);
	ffd2_inst: ffd
		port map (
			clk_i => clk_i,
			rst_i => rst_i,
			ena_i => ena_i,
			d_i   => valor_cadena(2),
			q_o   => valor_salida(2)
		);
	ffd3_inst: ffd
		port map (
			clk_i => clk_i,
			rst_i => rst_i,
			ena_i => ena_i,
			d_i   => valor_cadena(3),
			q_o   => valor_salida(3)
		);

	valor_cadena(0) <= ena_i xor valor_salida(0);
	valor_cadena(1) <= (ena_i and valor_salida(0)) xor valor_salida(1);
	valor_cadena(2) <= (ena_i and valor_salida(0) and valor_salida(1)) xor valor_salida(2);
	valor_cadena(3) <= (ena_i and valor_salida(0) and valor_salida(1) and valor_salida(2)) xor valor_salida(3);
	cuenta_o        <= valor_salida;
end architecture;


