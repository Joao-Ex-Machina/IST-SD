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

entity phone_mgr is
    Port ( clk       : in STD_LOGIC;
           SUP       : in STD_LOGIC;
           ESQ       : in STD_LOGIC;
           DTO       : in STD_LOGIC;
           EstadoInit: in STD_LOGIC_VECTOR (15 downto 0);
           state_ME  : out STD_LOGIC_VECTOR (15 downto 0);
           st2       : out STD_LOGIC_VECTOR (3 downto 0);
           TEMP      : out STD_LOGIC_VECTOR (3 downto 0));
end phone_mgr;

architecture Behavioral of phone_mgr is
-- componentes  
    component maq_estado 
Port ( clk : in STD_LOGIC;
   SUP  : in STD_LOGIC;
   ESQ : in STD_LOGIC;
   DTO : in STD_LOGIC;
   TOUT : in STD_LOGIC;
   estadoInit : in STD_LOGIC_VECTOR (15 downto 0);
   state_ME : out STD_LOGIC_VECTOR (15 downto 0));
end component;

   component temporizador 
   Port ( clk   : in STD_LOGIC;
   SUP  : in STD_LOGIC;
   ESQ : in STD_LOGIC;
   DTO : in STD_LOGIC;
   state_ME : in STD_LOGIC_VECTOR (15 downto 0);
   TEMP : out STD_LOGIC_VECTOR (3 downto 0);
   TOUT : out STD_LOGIC);
   end component;
   
   signal sss : STD_LOGIC_VECTOR (15 downto 0);
   signal tmp : STD_LOGIC_VECTOR (3 downto 0);
   signal ttt : STD_LOGIC;
    
begin

    --  N�O MODIFICAR!!! 
	
    ME : maq_estado port map (
        clk => clk, SUP => SUP, ESQ => ESQ, 
        DTO => DTO, TOUT => ttt, estadoInit => estadoInit,
        state_ME => sss
    );
    
	
    --  N�O MODIFICAR!!! 
    
    tempor : temporizador port map (
        clk => clk, SUP => SUP, ESQ => ESQ, 
        DTO => DTO, state_ME => sss,
		TEMP => TEMP, TOUT => ttt
    );
    
    --- Saidas - N�O MODIFICAR 
 
    st2(3) <= sss(15) or sss(14) or sss(13) or sss(12) or
                  sss(11) or sss(10) or sss(9) or sss(8);
    st2(2) <= sss(15) or sss(14) or sss(13) or sss(12) or
                  sss(7) or sss(6) or sss(5) or sss(4);
    st2(1) <= sss(15) or sss(14) or sss(11) or sss(10) or
                  sss(7) or sss(6) or sss(3) or sss(2);
    st2(0) <= sss(15) or sss(13) or sss(11) or sss(9) or
                  sss(7) or sss(5) or sss(3) or sss(1);
 
 state_ME <= sss;
end Behavioral;
