library IEEE;
	use IEEE.std_logic_1164.all;

	-- 16. Crear en VHDL un contador BCD de 4 dígitos con entrada de habilitación. Simularlo.

entity contBCD4dig is
	port (
		clk_i  : in  std_logic;
		rst_i  : in  std_logic;
		ena_i  : in  std_logic;
		co_o   : out std_logic;
		bcd0_o : out std_logic_vector(3 downto 0);
		bcd1_o : out std_logic_vector(3 downto 0);
		bcd2_o : out std_logic_vector(3 downto 0);
		bcd3_o : out std_logic_vector(3 downto 0)
	);
end entity;

architecture contBCD4dig_arq of contBCD4dig is
	-- Parte delcarativa
	component contBCDBeh is
		port (
			clk_i    : in  std_logic;
			rst_i    : in  std_logic;
			ena_i    : in  std_logic;
			cuenta_o : out std_logic_vector(3 downto 0);
			co_o     : out std_logic
		);
	end component;

	-- Este valor intermedio se utiliza para concatenar los contBCDBeh
	signal enable_intermedio : std_logic_vector(3 downto 0) := (others => '0');
	signal carry_intermedio  : std_logic_vector(3 downto 0) := (others => '0');

begin
	-- Parte descriptiva
	enable_intermedio(0) <= ena_i;
	enable_intermedio(1) <= ena_i and carry_intermedio(0);
	enable_intermedio(2) <= enable_intermedio(1) and carry_intermedio(1);
	enable_intermedio(3) <= enable_intermedio(2) and carry_intermedio(2);
	co_o                 <= carry_intermedio(3);

	contBCDBeh0_inst: contBCDBeh
		port map (
			clk_i    => clk_i,
			rst_i    => rst_i,
			ena_i    => enable_intermedio(0),
			cuenta_o => bcd0_o,
			co_o     => carry_intermedio(0)

		);

	contBCDBeh1_inst: contBCDBeh
		port map (
			clk_i    => clk_i,
			rst_i    => rst_i,
			ena_i    => enable_intermedio(1),
			cuenta_o => bcd1_o,
			co_o     => carry_intermedio(1)
		);
	contBCDBeh2_inst: contBCDBeh
		port map (
			clk_i    => clk_i,
			rst_i    => rst_i,
			ena_i    => enable_intermedio(2),
			cuenta_o => bcd2_o,
			co_o     => carry_intermedio(2)
		);
	contBCDBeh3_inst: contBCDBeh
		port map (
			clk_i    => clk_i,
			rst_i    => rst_i,
			ena_i    => enable_intermedio(3),
			cuenta_o => bcd3_o,
			co_o     => carry_intermedio(3)
		);

end architecture;


