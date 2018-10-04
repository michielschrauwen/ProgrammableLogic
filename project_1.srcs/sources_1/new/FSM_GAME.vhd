----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.12.2016 20:51:40
-- Design Name: 
-- Module Name: Y_BOUNCE_CHECK - Behavioral
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

entity Y_BOUNCE_CHECK is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           START : in STD_LOGIC;
           Y_POSITION_IN : in integer range -32 to 240;
           BOUNCE_UP : in STD_LOGIC; 
           BOUNCE_UP2 : in STD_LOGIC;
           BOUNCE_DOWN: in STD_LOGIC;
           FINISH : out STD_LOGIC;
           MOVE_DOWN: out STD_LOGIC;          
           MOVE_UP: out STD_LOGIC);
end Y_BOUNCE_CHECK;

architecture Behavioral of Y_BOUNCE_CHECK is
type state is (state0, state1, state2, state3);
signal old_state : state;
signal new_state : state;

begin

process(RESET, START, Y_POSITION_IN, BOUNCE_UP, BOUNCE_DOWN)
begin

case old_state is
    when state0 => if(START = '1') then
                        new_state <= state1;
                   else
                        new_state <= state0;
                   end if;
    when state1 => if((Y_POSITION_IN >= 230) or (BOUNCE_DOWN = '1')) then
                        new_state <= state2;
                   else
                        new_state <= state1;
                   end if;
    when state2 => if((BOUNCE_UP = '1') or (BOUNCE_UP2 = '1')) then
                        new_state <= state1;
                   elsif(Y_POSITION_IN <= -31) then
                        new_state <= state3;
                   else
                        new_state <= state2;
                   end if;
    when state3 => if(RESET = '1') then 
                        new_state <= state0;
                   else
                        new_state <= state3;
                   end if;                    
    when others => new_state  <= state0;
end case;
end process;

process(CLK, RESET)
begin
if(CLK'event and CLK='1') then
    if(RESET = '1') then
    old_state <= state0;
    else
    old_state <= new_state;
    end if;
end if;
end process;

process(old_state)
begin
case old_state is
    when state0 => MOVE_UP<= '0';
                   MOVE_DOWN <= '0';
                   FINISH <= '0';
    when state1 => MOVE_UP <= '1';
                   MOVE_DOWN <= '0';
                   FINISH <= '0';
    when state2 => MOVE_UP <= '0';
                   MOVE_DOWN <= '1';
                   FINISH <= '0';
    when state3 => MOVE_UP <= '0';
                   MOVE_DOWN <= '0';
                   FINISH <= '1';
end case;
end process;


end Behavioral;
