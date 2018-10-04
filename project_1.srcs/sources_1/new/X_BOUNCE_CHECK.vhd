----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.12.2016 17:30:41
-- Design Name: 
-- Module Name: X_BOUNCE_CHECK - Behavioral
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

entity X_BOUNCE_CHECK is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           START : in STD_LOGIC;
           X_POSITION_IN : in integer range -240 to 240;
           FINISH : in STD_LOGIC;
           ANGLE_1 : in STD_LOGIC;
           ANGLE_2 : in STD_LOGIC;
           X_MIN_2 : in STD_LOGIC;
           X_PLUS_2 : in STD_LOGIC;
           MOVE_2 : out STD_LOGIC;
           CHANGE_DIRECTION_X1 : in STD_LOGIC;
           CHANGE_DIRECTION_X2 : in STD_LOGIC;
           MOVE_LEFT : out STD_LOGIC;
           MOVE_RIGHT: out STD_LOGIC);
end X_BOUNCE_CHECK;

architecture Behavioral of X_BOUNCE_CHECK is
type state is (state0, state1, state2, state3, state4, state5);
signal old_state : state;
signal new_state : state;
begin

process(RESET, START, X_POSITION_IN, FINISH, ANGLE_1, ANGLE_2, X_MIN_2, X_PLUS_2, CHANGE_DIRECTION_X1, CHANGE_DIRECTION_X2)
begin

case old_state is
    when state0 => if(START = '1') then
                        new_state <= state1;
                   else
                        new_state <= state0;
                   end if;
    when state1 => 
                   if(X_POSITION_IN >= 230) then
                        new_state <= state3;
                   elsif((CHANGE_DIRECTION_X1 = '1')) then
                        new_state <= state3;
                   elsif((X_MIN_2 = '1') and (ANGLE_1 = '1')) then
                        new_state <= state4;
                   elsif((ANGLE_1 = '1') and (X_MIN_2 = '0')) then
                        new_state <= state3;
                   elsif((X_PLUS_2 = '1') and (ANGLE_2 = '1')) then
                        new_state <= state2;
                   elsif((ANGLE_2 = '1') and (X_PLUS_2 = '0')) then
                        new_state <= state1;
                   elsif(FINISH ='1') then
                        new_state <= state5;
                   else
                        new_state <= state1;
                   end if;
    when state2 => 
                   if(X_POSITION_IN >= 230) then
                       new_state <= state4;
                   elsif((CHANGE_DIRECTION_X1 = '1')) then
                       new_state <= state4;
                   elsif((X_MIN_2 = '1') and (ANGLE_1 = '1')) then
                       new_state <= state4; 
                   elsif((ANGLE_1 = '1') and (X_MIN_2 = '0')) then
                       new_state <= state3;
                   elsif((X_PLUS_2 = '1') and (ANGLE_2 = '1')) then
                       new_state <= state2;
                   elsif((ANGLE_2 = '1') and (X_PLUS_2 = '0')) then
                       new_state <= state1;
                   elsif(FINISH ='1') then
                       new_state <= state5;
                   else
                       new_state <= state2;
                   end if;
    when state3 => if(X_POSITION_IN <= -230) then
                        new_state <= state1;
                   elsif((CHANGE_DIRECTION_X2 = '1')) then
                        new_state <= state1;
                   elsif(FINISH ='1') then
                        new_state <= state5;
                   elsif((X_PLUS_2 = '1') and (ANGLE_2 ='1')) then
                        new_state <= state2;
                   elsif((ANGLE_2 = '1') and (X_PLUS_2 = '0')) then
                        new_state <= state1;
                   elsif((X_MIN_2 = '1') and (ANGLE_1 = '1')) then
                        new_state <= state4;
                   elsif((ANGLE_1 = '1') and (X_MIN_2 = '0')) then
                        new_state <= state3; 
                   else
                        new_state <= state3;
                   end if;
    when state4 => if(X_POSITION_IN <= -230) then
                        new_state <= state2;
                   elsif((CHANGE_DIRECTION_X2 = '1')) then
                        new_state <= state2;
                   elsif(FINISH ='1') then
                        new_state <= state5;
                   elsif((X_PLUS_2 = '1') and (ANGLE_2 = '1')) then
                        new_state <= state2;
                   elsif((ANGLE_2 = '1') and (X_PLUS_2 = '0')) then
                        new_state <= state1;
                   elsif((X_MIN_2 = '1') and (ANGLE_1 = '1')) then
                        new_state <= state4;
                   elsif((ANGLE_1 = '1') and (X_MIN_2 = '0')) then
                        new_state <= state3;
                   else
                        new_state <= state4;
                   end if;
    when state5 => if(RESET = '1') then
                        new_state <= state0;
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
    when state0 => MOVE_RIGHT<= '0';
                   MOVE_LEFT <= '0';
                   MOVE_2 <= '0';
    when state1 => MOVE_RIGHT <= '1';
                   MOVE_LEFT <= '0';
                   MOVE_2 <= '0';
    when state2 => MOVE_RIGHT <= '1';
                   MOVE_LEFT <= '0';
                   MOVE_2 <= '1';
    when state3 => MOVE_RIGHT <= '0';
                   MOVE_LEFT <= '1';  
                   MOVE_2 <= '0';   
    when state4 => MOVE_RIGHT <= '0';
                   MOVE_LEFT <= '1';  
                   MOVE_2 <= '1';
    when state5 => MOVE_RIGHT <= '0';
                   MOVE_LEFT <= '0';
                   MOVE_2 <= '0';
end case;
end process;




end Behavioral;
