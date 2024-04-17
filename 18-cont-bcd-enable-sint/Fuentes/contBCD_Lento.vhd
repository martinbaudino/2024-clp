library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

	-- 18. Crear en VHDL un contador BCD de 1 dígito con un generador de habilitación para que la
	--     cuenta avance cada 1 segundo (crear además una habilitación general). Implementarlo y
	--     probarlo en el kit de desarrollo usando como salida los 4 leds. Uno de los switches 
	--     puede utilizarse para controlar la habilitación general.

entity contBCD_Lento is
	generic (
		N : natural := 4 -- Cantidad de ciclos a contar
	);
	port (
		clk_i    : in  std_logic;
		rst_i    : in  std_logic;
		-- Aparte de la habilitación periódica de genEna, hay una habilitación general
		ena_i    : in  std_logic;
		cuenta_o : out std_logic_vector(3 downto 0);
		co_o     : out std_logic
	);
end entity;

architecture contBCD_Lento_arq of contBCD_Lento is

	component contBCDBeh is
		port (
			clk_i    : in  std_logic;
			rst_i    : in  std_logic;
			ena_i    : in  std_logic;
			cuenta_o : out std_logic_vector(3 downto 0);
			co_o     : out std_logic

		);
	end component;

	component genEna is
		generic (
			N : natural := 5
		);
		port (
			clk_i : in  std_logic;
			rst_i : in  std_logic;
			ena_i : in  std_logic;
			q_o   : out std_logic
		);
	end component;

	signal ena_pulse : std_logic;
	signal ena_aux   : std_logic;

begin

	-- Habilitación general debe estar activa cuando se produce el pulso periódico
	ena_aux <= ena_i and ena_pulse;

	inst_contBCD: contBCDBeh
		port map (
			clk_i    => clk_i,
			rst_i    => rst_i,
			ena_i    => ena_aux,
			cuenta_o => cuenta_o,
			co_o     => co_o
		);

	inst_gen_ena: genEna
		generic map (
			N => N
		)
		port map (
			clk_i => clk_i,
			rst_i => rst_i,
			ena_i => '1',
			q_o   => ena_pulse
		);

end architecture;
