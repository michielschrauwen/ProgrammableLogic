----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.12.2016 20:22:30
-- Design Name: 
-- Module Name: MOVE_Y_DIRECTION - Behavioral
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

entity MOVE_Y_DIRECTION is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           CE : in STD_LOGIC;
           Y_POSITION_OUT : out integer range -32 to 240;
           Y_MIN : in STD_LOGIC;
           Y_PLUS : in STD_LOGIC);
end MOVE_Y_DIRECTION;

architecture Behavioral of MOVE_Y_DIRECTION is

begin
process(CLK, RESET, CE, Y_MIN, Y_PLUS)
variable position: integer range -32 to 240:= 0;
begin
if(CLK'event and CLK='1') then
    if(RESET = '1') then
        position := 0;
        Y_POSITION_OUT <= 0;
    else
        if(CE ='1') then
            if(Y_PLUS = '1') then
                if(position <= 230) then
                    position := position + 1;
                else
                    position := position;
                end if;
            elsif(Y_MIN = '1') then
                if (position > -32) then
                    position := position -1;
                else
                    position := position;
                end if;
            end if;
            Y_POSITION_OUT <= position;
        end if;
    end if;
end if;
end process;


end Behavioral;
