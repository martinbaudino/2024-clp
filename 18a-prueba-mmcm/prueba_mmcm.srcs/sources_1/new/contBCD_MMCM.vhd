library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

	-- 15. Crear en VHDL un contador BCD de un dígito por comportamiento (describiendo cómo
	-- funciona, utilizando un process). Simularlo.

entity contBCD_MMCM is
	port (
		clk_i    : in  std_logic;
		rst_i    : in  std_logic;
		ena_i    : in  std_logic;
		cuenta_o : out std_logic_vector(3 downto 0);
		co_o     : out std_logic
	);
end entity;

architecture contBCD_MMCM_arq of contBCD_MMCM is
	-- Parte delcarativa
	component clk_wiz_0
    port
     (-- Clock in ports
      -- Clock out ports
      clk_out1          : out    std_logic;
      -- Status and control signals
      locked            : out    std_logic;
      clk_in1           : in     std_logic
     );
    end component;
	signal clk_gen: std_logic;
	signal locked: std_logic;
	
begin
	-- Parte descriptiva
contBCD_inst: entity work.contBCDBeh
        port map(
            clk_i => clk_gen,
            rst_i => rst_i,
            ena_i  => ena_i,
            cuenta_o => cuenta_o,
            co_o     => co_o
        );
        
    -- 1. Agregar IP Core de MMCM al proyecto con "Clocking Wizard"
    -- 2. Agregar instancia IP Sources ->  instance_name -> Instantiation Template -> Copiar plantilla al VHD top del proyecto (ac� la instancia)
    mmcm_inst : clk_wiz_0
       port map ( 
      -- Clock out ports  
       clk_out1 => clk_gen,
      -- Status and control signals                
       locked => locked,
       -- Clock in ports
       clk_in1 => clk_i
     );

end architecture;
