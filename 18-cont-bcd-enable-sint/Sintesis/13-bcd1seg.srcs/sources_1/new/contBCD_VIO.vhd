----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2024 04:13:59 PM
-- Design Name: 
-- Module Name: contBCD_VIO - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
	use IEEE.STD_LOGIC_1164.all;

	-- Uncomment the following library declaration if using
	-- arithmetic functions with Signed or Unsigned values
	--use IEEE.NUMERIC_STD.ALL;
	-- Uncomment the following library declaration if instantiating
	-- any Xilinx leaf cells in this code.
	--library UNISIM;
	--use UNISIM.VComponents.all;

entity contBCD_VIO is
	port (
		clk_i     : in  std_logic;
		cuenta_o  : out STD_LOGIC_VECTOR(3 downto 0);
		gen_ena_i : in  std_logic
	);
end entity;

architecture contBCD_ena_top of contBCD_VIO is
	-- Parte delcarativa
	component vio_0
		port (
			clk        : in  STD_LOGIC;
			probe_in0  : in  STD_LOGIC_VECTOR(3 downto 0);
			probe_in1  : in  STD_LOGIC_VECTOR(0 downto 0);
			probe_out0 : out STD_LOGIC_VECTOR(0 downto 0);
			probe_out1 : out STD_LOGIC_VECTOR(0 downto 0)
		);
	end component;

	signal probe_ena    : std_logic_vector(0 downto 0);
	signal probe_rst    : std_logic_vector(0 downto 0);
	signal probe_cuenta : std_logic_vector(3 downto 0);
	signal probe_co     : std_logic_vector(0 downto 0);

begin
	-- Parte descriptiva
	cont_vio_inst: vio_0
		port map (
			clk        => clk_i,
			probe_in0  => probe_cuenta,
			probe_in1  => probe_co,
			probe_out0 => open,
			probe_out1 => probe_rst
		);

	cont_ena_inst: entity work.contBCD_Lento
		generic map (
			N => 125000000
		)
		port map (
			clk_i    => clk_i,
			rst_i    => probe_rst(0),
			ena_i    => probe_ena(0),
			cuenta_o => probe_cuenta,
			co_o     => probe_co(0)
		);
	probe_ena(0) <= gen_ena_i;
	cuenta_o     <= probe_cuenta;

end architecture;
