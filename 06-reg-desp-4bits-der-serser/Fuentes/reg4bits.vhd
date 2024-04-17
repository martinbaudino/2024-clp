library IEEE;
	use IEEE.std_logic_1164.all;

	-- 6. Crear en VHDL un registro de desplazamiento de 4 bits a derecha con
	--    entrada serie y salida serie utilizando el flip-flop anterior. Simularlo.

entity reg4bits is
	port (
		clk_i : in  std_logic;
		rst_i : in  std_logic;
		ena_i : in  std_logic;
		d_i   : in  std_logic;
		q_o   : out std_logic
	);
end entity;

architecture reg4bits_arq of reg4bits is
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

	-- Este valor intermedio se utiliza para concatenar los FFD y el valor inicial
	signal valor : std_logic_vector(3 downto 0) := (others => '0');

begin
	-- Parte descriptiva
	valor(0) <= d_i;

	ffd0_inst: ffd
		port map (
			clk_i => clk_i,
			rst_i => rst_i,
			ena_i => ena_i,
			d_i   => valor(0),
			q_o   => valor(1)
		);

	ffd1_inst: ffd
		port map (
			clk_i => clk_i,
			rst_i => rst_i,
			ena_i => ena_i,
			d_i   => valor(1),
			q_o   => valor(2)
		);
	ffd2_inst: ffd
		port map (
			clk_i => clk_i,
			rst_i => rst_i,
			ena_i => ena_i,
			d_i   => valor(2),
			q_o   => valor(3)
		);
	ffd3_inst: ffd
		port map (
			clk_i => clk_i,
			rst_i => rst_i,
			ena_i => ena_i,
			d_i   => valor(3),
			q_o   => q_o
		);

end architecture;


