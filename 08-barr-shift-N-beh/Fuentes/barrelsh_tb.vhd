library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

entity barrelsh_tb is
end entity;

architecture barrelsh_tb_arq of barrelsh_tb is
	-- Parte declarativa
	component barrelsh is
		generic (
			M : natural;
			N : natural
		);
		port (
			a_i   : in  std_logic_vector(N - 1 downto 0);
			des_i : in  std_logic_vector(M - 1 downto 0);
			s_o   : out std_logic_vector(N - 1 downto 0)
		);
	end component;

	constant M_tb : natural := 3;
	constant N_tb : natural := 2 ** M_tb;
	signal a_i_tb   : std_logic_vector(N_tb - 1 downto 0) := std_logic_vector(to_unsigned(0, N_tb)); -- valor inicial en 0 con el tamaño correcto
	signal des_i_tb : std_logic_vector(M_tb - 1 downto 0);
	signal s_o_tb   : std_logic_vector(N_tb - 1 downto 0);

begin
	-- Parte descriptiva
	a_i_tb   <= "11110001" after 100 ns, "10100010" after 200 ns, "11000100" after 300 ns, "00111000" after 400 ns;
	des_i_tb <= "001" after 150 ns, "010" after 250 ns, "100" after 350 ns, "111" after 450 ns;

	DUT: barrelsh
		generic map (
			N => N_tb,
			M => M_tb
		)
		port map (
			a_i   => a_i_tb,
			des_i => des_i_tb,
			s_o   => s_o_tb
		);
end architecture;


