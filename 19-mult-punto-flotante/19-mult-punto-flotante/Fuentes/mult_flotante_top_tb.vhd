library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;
	-- Paquete con funciones de conversión. Para poder utilizarlo en las simulaciones es
	-- necesario pasar el argumento "--std=08" a GHDL
	use IEEE.float_pkg.all;

	use work.tipo_punto_flotante_pkg.all;

entity mult_flotante_top_tb is
end entity;

architecture mult_flotante_tb_arq of mult_flotante_top_tb is

	component mult_flotante_top is
		port (
			clk_i       : in  std_logic;
			rst_i       : in  std_logic;
			iniciar_i   : in  std_logic;
			op1_i       : in  std_logic_vector(msb_completo downto 0);
			op2_i       : in  std_logic_vector(msb_completo downto 0);
			resultado_o : out std_logic_vector(msb_completo downto 0);
			listo_o     : out std_logic
		);
	end component;

	signal clk_tb      : std_logic := '0';
	signal rst_tb      : std_logic := '1';
	signal ini_tb      : std_logic := '0';
	signal listo_tb    : std_logic;
	signal flotante1   : std_logic_vector(msb_completo downto 0);
	signal flotante2   : std_logic_vector(msb_completo downto 0);
	signal f1, f2, f3  : float32;
	signal resultado32 : std_logic_vector(msb_completo downto 0);

begin

	clk_tb <= not clk_tb after 4 ns;
	rst_tb <= '0' after 120 ns, '1' after 520 ns;
	ini_tb <= '1' after 150 ns,
	'0' after 200 ns, 
	'1' after 210 ns, 
	'0' after 250 ns, 
	'1' after 260 ns, 
	'0' after 300 ns,
	'1' after 310 ns;
	f1     <= to_float(+ 25.15) after 150 ns, 
	to_float(+ 1525.15) after 190 ns, 
	to_float(- 105.15) after 230 ns, to_float(+ 0.0) after 270 ns;
	f2     <= to_float(+ 6.5) after 150 ns, to_float(+ 3.15) after 190 ns, to_float(+ 25.15) after 230 ns, to_float(+ 25.15) after 270 ns;
	-- La señal f3 se utiliza para comprobar que la salida se la misma que el multiplicador
	-- sintetizable (DUT_orig.resultado_o).
	f3        <= f1 * f2;
	flotante1 <= to_std_logic_vector(f1);
	flotante2 <= to_std_logic_vector(f2);

	-- Declarar el DUT de esta manera evita tener que incluir los compoenentes manualmente
	DUT_orig: entity work.mult_flotante_top
		port map (
			clk_i       => clk_tb,
			rst_i       => rst_tb,
			iniciar_i   => ini_tb,
			op1_i       => flotante1,
			op2_i       => flotante2,
			resultado_o => resultado32,
			listo_o     => listo_tb

		);

end architecture;
