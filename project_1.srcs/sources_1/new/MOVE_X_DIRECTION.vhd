----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.12.2016 11:27:25
-- Design Name: 
-- Module Name: MOVE_X_DIRECTION - Behavioral
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

entity MOVE_X_DIRECTION is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           CE : in STD_LOGIC;
           X_POSITION_OUT : out integer range -240 to 240;
           MOVE_2 : in STD_LOGIC;
           X_MIN : in STD_LOGIC;
           X_PLUS : in STD_LOGIC);
end MOVE_X_DIRECTION;

architecture Behavioral of MOVE_X_DIRECTION is

begin
process(CLK, RESET, CE, MOVE_2, X_MIN, X_PLUS)
variable position: integer range -240 to 240 :=0 ;
begin
if(CLK'event and CLK='1') then
    if(RESET = '1') then
        position := 0;
        X_POSITION_OUT <= 0;
    else
        if(CE ='1') then
            if(X_PLUS = '1') then
                if(position < 239) then
                    if(MOVE_2 = '0') then
                        position := position + 1;
                    elsif(MOVE_2 = '1') then
                        position := position +2;
                    end if;
                end if;
            elsif(X_MIN = '1') then
                if (position > -239) then
                    if(MOVE_2 = '0') then
                        position := position -1;
                    elsif(MOVE_2 = '1') then
                        position := position -2;
                    end if;
                end if;
            end if;
            X_POSITION_OUT <= position;
        end if;
    end if;
end if;
end process;
                


end Behavioral;
