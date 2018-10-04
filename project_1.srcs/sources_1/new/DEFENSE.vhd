----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.12.2016 10:12:48
-- Design Name: 
-- Module Name: DEFENSE - Behavioral
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

entity DEFENSE is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           X_POSITION : in integer range 0 to 531;
           NEW_X : in integer range -240 to 240;
           Y_POSITION : in integer range 0 to 287;
           DEFENSE_EN : out STD_LOGIC);
end DEFENSE;

architecture Behavioral of DEFENSE is

begin

u1: process(CLK, RESET, X_POSITION, NEW_X, Y_POSITION)

begin
if(CLK'event and CLK='1') then
    if(RESET = '1') then
    DEFENSE_EN <= '0';
    else
        if((((X_POSITION + NEW_X) >= 243) and ((X_POSITION + NEW_X) <=323)) and  ((Y_POSITION >= 258) and (Y_POSITION <= 268))) then
            DEFENSE_EN <= '1';
        else
            DEFENSE_EN <= '0';
        end if;
    end if;
end if;
end process;


end Behavioral;
