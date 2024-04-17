library IEEE;
	use IEEE.std_logic_1164.all;

entity sumrest4b_tb is
end entity;

architecture sumrest4b_tb_arq of sumrest4b_tb is
	-- Parte declarativa
	component sumrest4b is
		port (
			a_i  : in  std_logic_vector(3 downto 0);
			b_i  : in  std_logic_vector(3 downto 0);
			sr_i : in  std_logic;
			s_o  : out std_logic_vector(3 downto 0);
			co_o : out std_logic
		);
	end component;

	signal a_tb  : std_logic_vector(3 downto 0) := "0000";
	signal b_tb  : std_logic_vector(3 downto 0) := "0000";
	signal sr_tb : std_logic                    := '0';
	signal s_tb  : std_logic_vector(3 downto 0);
	signal co_tb : std_logic;

begin
	-- Parte descriptiva
	sr_tb <= not sr_tb after 20 ns;
	a_tb  <= "0110" after 10 ns, "0111" after 30 ns, "1111" after 50 ns;
	b_tb  <= "0010" after 10 ns, "0111" after 30 ns, "0111" after 50 ns;

	DUT: sumrest4b
		port map (
			a_i  => a_tb,
			b_i  => b_tb,
			sr_i => sr_tb,
			s_o  => s_tb,
			co_o => co_tb
		);
end architecture;


