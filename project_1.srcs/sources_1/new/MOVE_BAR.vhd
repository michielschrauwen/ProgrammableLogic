----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.12.2016 20:40:00
-- Design Name: 
-- Module Name: MOVE_BAR - Behavioral
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

entity MOVE_BAR is
    Port ( CLK : in STD_LOGIC;
       RESET : in STD_LOGIC;
       CE : in STD_LOGIC;
       X_POSITION_BAR : out integer range -240 to 240;
       BAR_MIN : in STD_LOGIC;
       BAR_PLUS : in STD_LOGIC);
end MOVE_BAR;

architecture Behavioral of MOVE_BAR is

begin
process(CLK, RESET, CE, BAR_MIN, BAR_PLUS)
variable position: integer range -240 to 240 :=0 ;
begin
if(CLK'event and CLK='1') then
    if(RESET = '1') then
    position := 0;
    X_POSITION_BAR <= 0;
    else
        if(CE ='1') then
            if(BAR_PLUS = '1') then
                if(position < 200) then
                    position := position + 4;
                else
                    position := position;
                end if;
            elsif(BAR_MIN = '1') then
                if (position > -200) then
                    position := position -4;
                else
                    position := position;
                end if;
            end if;
            X_POSITION_BAR <= position;
        end if;
    end if;
end if;
end process;
            


end Behavioral;
