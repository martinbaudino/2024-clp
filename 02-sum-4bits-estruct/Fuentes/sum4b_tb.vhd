library IEEE;
	use IEEE.std_logic_1164.all;

	-- 2. Crear en VHDL un sumador de 4 bits de manera estructural. Simularlo.

entity sum4b_tb is
end entity;

architecture sum4b_tb_arq of sum4b_tb is
	-- Parte declarativa
	component sum4b is
		port (
			-- La interfaz cambia de 1 a 4 bits
			a_i  : in  std_logic_vector(3 downto 0);
			b_i  : in  std_logic_vector(3 downto 0);
			ci_i : in  std_logic;
			s_o  : out std_logic_vector(3 downto 0);
			co_o : out std_logic
		);
	end component;

	signal a_tb  : std_logic_vector(3 downto 0) := "0000";
	signal b_tb  : std_logic_vector(3 downto 0) := "0001";
	signal ci_tb : std_logic                    := '0';
	signal s_tb  : std_logic_vector(3 downto 0);
	signal co_tb : std_logic;

begin
	-- Parte descriptiva
	-- Acá se complica hacer clocks con los vectores
	a_tb  <= "0011" after 100 ns, "0111" after 400 ns;
	b_tb  <= "1000" after 250 ns;
	ci_tb <= '1' after 500 ns;

	DUT: sum4b
		port map (
			a_i  => a_tb,
			b_i  => b_tb,
			ci_i => ci_tb,
			s_o  => s_tb,
			co_o => co_tb
		);
end architecture;


