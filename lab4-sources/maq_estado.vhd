----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.11.2016 10:47:20
-- Design Name: 
-- Module Name: float_add - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity maq_estado is
    Port ( clk       : in STD_LOGIC;
           SUP       : in STD_LOGIC;
           ESQ       : in STD_LOGIC;
           DTO       : in STD_LOGIC;
           TOUT      : in STD_LOGIC;
           EstadoInit: in STD_LOGIC_VECTOR (15 downto 0);
           state_ME  : out STD_LOGIC_VECTOR (15 downto 0));
end maq_estado;

architecture Behavioral of maq_estado is

--componentes  

    component ff_de 
    Port ( din : in STD_LOGIC;
    clk : in STD_LOGIC;
    ce  : in STD_LOGIC;
    reset : in STD_LOGIC;
    set : in STD_LOGIC;
    dout : out STD_LOGIC);
    end component;
   
    -- sinais
    
    signal E, D, T, nE, nD, nT : STD_LOGIC; 
    signal Dme, Qme        : STD_LOGIC_VECTOR (15 downto 0);
    signal Dff, nDff  : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
 
begin
     
    -- N�O MODIFICAR!!! instanciacao de 7 FF_DE para a m�quina de estados - N�O MODIFICAR
    
        one_hot: for i in 0 to 6 generate
    Dff(i) <= EstadoInit(i) and SUP;
    nDff(i) <= not(EstadoInit(i)) and SUP;
    FFD: ff_de port map (
        din => Dme(i), dout => Qme(i), 
        clk => clk,  reset => nDff(i), set => Dff(i), ce => '1'
    );
end generate;
    
    Qme(15 downto 7) <= "000000000";   -- N�O MODIFICAR
    
    -- A MODIFICAR!!! Defini��o de estados one-hot REDEFINIR EM FUN��O DE Qme(i), DTO, ESQ E TOUT
	
     Dme(0) <= (Qme(0) and (not(DTO xor ESQ))) or (Qme(4) and DTO and (not(ESQ))) or (Qme(5) and (DTO or TOUT)) or (Qme(6) and (DTO or TOUT)); 
     Dme(1) <= (Qme (0) and DTO and (not(ESQ))) or (Qme(1) and (not ((DTO)) xor (TOUT)));
     Dme(2) <= (Qme (0) and ESQ and (not(DTO))) or (Qme(2) and (not(TOUT))); 
     Dme(3) <= (Qme(2) and TOUT) or (Qme (3) and (not(DTO)) and (not(TOUT))); 
     Dme(4) <= (Qme (1) and DTO and (not(TOUT))) or (DTO and (Qme(3))) or (Qme(4) and ((not(DTO xor ESQ)))) or (Qme(4) and (not(DTO) and ESQ)); 
 Dme(5) <= (Qme(1) and TOUT) or (Qme(5) and (not(TOUT)) and (not(DTO)));
Dme(6) <= (Qme(3) and TOUT) or (Qme(6) and (not(TOUT)) and (not(DTO))) ;
                                   
    --- Saidas - N�O MODIFICAR 
	
    State_ME <= Qme;
 
end Behavioral;
