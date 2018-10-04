----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.12.2016 17:04:50
-- Design Name: 
-- Module Name: BALL - Behavioral
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

entity BALL is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           X_POSITION : in integer range 0 to 531;
           NEW_X : in integer range -240 to 240;
           NEW_Y : in integer range -32 to 240;
           Y_POSITION : in integer range 0 to 287;
           BALL_EN : out STD_LOGIC);
end BALL;

architecture Behavioral of BALL is

begin

process(CLK, RESET, X_POSITION, NEW_X, NEW_Y, Y_POSITION)
begin

if(CLK'event and CLK='1') then
    if(RESET = '1') then
    BALL_EN <= '0';
    else
        if((X_POSITION - 282 + NEW_X)**2 + (Y_POSITION - 250 + NEW_Y)**2)<=49 then 
            BALL_EN <= '1';            
        else 
            BALL_EN <= '0';
        end if;
    end if;
end if;

end process;

end Behavioral;
