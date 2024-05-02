----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2024 10:06:31 PM
-- Design Name: 
-- Module Name: mult_flot_vio - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;
use work.tipo_punto_flotante_pkg.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mult_flot_vio is
    Port ( clk_i : in STD_LOGIC
        );
end mult_flot_vio;

architecture Behavioral of mult_flot_vio is
    -- Parte declarativa
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
    
    COMPONENT vio_0
      PORT (
        clk : IN STD_LOGIC;
        probe_in0 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        probe_in1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        probe_out0 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        probe_out1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        probe_out2 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
        probe_out3 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
      );
    END COMPONENT;
    
    signal rst_sig, iniciar_sig, listo_sig: std_logic_vector(0 downto 0);
    signal op1_sig, op2_sig, resultado_sig: std_logic_vector(msb_completo downto 0);
    
begin
    -- Parte descriptiva
    vio_inst : vio_0
      PORT MAP (
        clk => clk_i,
        probe_in0 => listo_sig,
        probe_in1 => resultado_sig,
        probe_out0 => op1_sig,
        probe_out1 => op2_sig,
        probe_out2 => iniciar_sig,
        probe_out3 => rst_sig
      );
      
      mult_flotante_inst : mult_flotante_top
            PORT MAP (
              clk_i => clk_i,
              rst_i => rst_sig(0),
              iniciar_i => iniciar_sig(0),
              op1_i => op1_sig,
              op2_i => op2_sig,
              resultado_o => resultado_sig,
              listo_o => listo_sig(0)
            );
    
end Behavioral;
