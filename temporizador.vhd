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

entity temporizador is
    Port ( clk       : in STD_LOGIC;
           SUP       : in STD_LOGIC;
           ESQ       : in STD_LOGIC;
           DTO       : in STD_LOGIC;
           state_ME  : in STD_LOGIC_VECTOR (15 downto 0);
           TEMP      : out STD_LOGIC_VECTOR (3 downto 0);
		   TOUT      : out STD_LOGIC);
end temporizador;

architecture Behavioral of temporizador is
--componentes  

    component ctr_16 
        Port ( clk   : in STD_LOGIC;
               reset : in STD_LOGIC;
               ce    : in STD_LOGIC;
               ld    : in STD_LOGIC;
               d     : in STD_LOGIC_VECTOR (3 downto 0);
               q     : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
   
    -- sinais
	
    -- contador
    signal en, rst, ld     : STD_LOGIC;
    signal ld_i, ctr_state : STD_LOGIC_VECTOR (3 downto 0);
    signal ttt            : STD_LOGIC;
 
begin
    --  N�O MODIFICAR!!! contador 4 bits que conta os v�rios timeouts - N�O MODIFICAR
    CNTR : ctr_16 port map (
        clk => clk, reset => rst, 
        ce => en, ld => ld,
        d => ld_i, q => ctr_state
    );
        
    -- A MODIFICAR!!! Defini��o do timeout (TOUT = ttt), reset (rst), enable (en), load (ld) e dados de load (ld_i) do contador - REDEFINIR 


     ttt <=((state_ME(1) or state_ME(3) or state_ME(2) or state_ME(5) or state_ME(6)) and (not(ctr_state(0)) and (not(ctr_state(1)) and (ctr_state(2) and (not(ctr_state(3))))))) ; -- ATEN��O - ttt � a vari�vel auxiliar correspondente ao TOUT (ver �ltima linha)
     rst <= SUP;
     en <= (state_ME(1) or state_ME(2) or state_ME(3) or state_ME(5) or state_ME(6));
     ld <= (not en) or ttt;
     ld_i <= "0000";
                            
    TEMP <= ctr_state;
    TOUT <= ttt;
 
end Behavioral;
