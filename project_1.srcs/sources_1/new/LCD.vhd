----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.12.2016 16:20:39
-- Design Name: 
-- Module Name: LCD - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LCD is
    Port ( RESET : in STD_LOGIC;
           CLK : in STD_LOGIC;
           H_SYNC : out STD_LOGIC;
           V_SYNC : out STD_LOGIC;
           DISP_EN : out STD_LOGIC;
           DCLK: out STD_LOGIC;
           PLUS : in STD_LOGIC;
           MIN : in STD_LOGIC;
           START : in STD_LOGIC;
           MOSI: out STD_LOGIC;
           MISO: in STD_LOGIC;
           sck : out STD_LOGIC;
           ssel: out STD_LOGIC;
           BUSY : in STD_LOGIC;
           SELECT_X_Y : in STD_LOGIC;
           X_Y_VALUE_TOUCH : out STD_LOGIC_VECTOR(3 downto 0);
           RED : out STD_LOGIC_VECTOR(7 downto 0);
           GREEN : out STD_LOGIC_VECTOR (5 downto 0);
           BLUE : out STD_LOGIC_VECTOR (3 downto 0);
           PWM: out STD_LOGIC;
           GND : out STD_LOGIC);
end LCD;

architecture Behavioral of LCD is

--Virtical sync of the display
component V_SYNC_1 is                       
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           VS_EN : in STD_LOGIC;
           V_SYNC : out STD_LOGIC;
           Y_POS : out integer range 0 to 287;
           draw : out STD_LOGIC;
           DISP_Y : out STD_LOGIC);
end component;

--Horizontal sync of the display
component H_SYNC_1 is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           X_POS : out integer range 0 to 531;
           DISP_X : out STD_LOGIC;
           H_SYNC : out STD_LOGIC;
           H_CE : in STD_LOGIC;
           VS_EN : out STD_LOGIC);
end component;

--clock delay for the display
component CLK_DELAY is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           CLK_OUT : out STD_LOGIC;
           CE_FIX : out STD_LOGIC);
end component;

--get the red blocks positions
component Block_1 is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           X_POSITION : in integer range 0 to 531;
           Y_POSITION : in integer range 0 to 287;
           B_EN : out STD_LOGIC);
end component;

--get the blue blocks positions
component BLOCK_2 is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           B2_EN : out STD_LOGIC;
           X_POSITION : in integer range 0 to 531;
           Y_POSITION : in integer range 0 to 287);
end component;

--get the ball position
component BALL is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           X_POSITION : in integer range 0 to 531;
           NEW_X : in integer range -240 to 240;
           NEW_Y : in integer range -136 to 136;
           Y_POSITION : in integer range 0 to 287;
           BALL_EN : out STD_LOGIC);
end component;

--get the defense bar position
component DEFENSE is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           X_POSITION : in integer range 0 to 531;
           NEW_X : in integer range -240 to 240;
           Y_POSITION : in integer range 0 to 287;
           DEFENSE_EN : out STD_LOGIC);
end component;

--move the ball in the X direction
component MOVE_X_DIRECTION is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           CE : in STD_LOGIC;
           X_POSITION_OUT : out integer range -240 to 240;
           MOVE_2 : in STD_LOGIC;
           X_MIN : in STD_LOGIC;
           X_PLUS : in STD_LOGIC);
end component;

--Delay the movement of the ball
component move_delay is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           MOVE_CLK : out STD_LOGIC);
end component;

--move the ball in the Y direction
component MOVE_Y_DIRECTION is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           CE : in STD_LOGIC;
           Y_POSITION_OUT : out integer range -136 to 136;
           Y_MIN : in STD_LOGIC;
           Y_PLUS : in STD_LOGIC);
end component;

--check if the ball bounces against the top of the screen or the bottom or top of the blocks or the top of the defense bar
component Y_BOUNCE_CHECK is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           START : in STD_LOGIC;
           Y_POSITION_IN : in integer range -136 to 136;  
           BOUNCE_UP : in STD_LOGIC;
           BOUNCE_UP2: in STD_LOGIC;
           BOUNCE_DOWN : in STD_LOGIC;
           FINISH : out STD_LOGIC;
           MOVE_DOWN : out STD_LOGIC;         
           MOVE_UP: out STD_LOGIC);
end component;


--check if the ball bounces against the sides of the screen or the sides of the blocks or on what position on the defense bar
component X_BOUNCE_CHECK is
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
end component;

--move the defense bar
component MOVE_BAR is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           CE : in STD_LOGIC;
           X_POSITION_BAR : out integer range -240 to 240;
           BAR_MIN : in STD_LOGIC;
           BAR_PLUS : in STD_LOGIC);
end component;

--get the positions of where the player touches the screen
component TOUCH_POSITIONS is
      Port (CLK : in std_logic;
            RESET : in std_logic;
            INT : in std_logic;
            DCLK : out std_logic;
            BUSY : in std_logic;
            CS : out std_logic;
            mosi : out std_logic;
            miso : in std_logic;
            OUTPUT_X : out std_logic_vector(7 downto 0);
            OUTPUT_Y : out std_logic_vector(7 downto 0)); 
end component;

--see what movement the bar has to make according to where the player touched the screen
component MOVE_TOUCHES is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           X_IN : in STD_LOGIC_VECTOR(7 downto 0);
           Y_IN : in STD_LOGIC_VECTOR(7 downto 0);
           LEFT : out STD_LOGIC;
           RIGHT : out STD_LOGIC);
end component;


signal Y_P : integer range 0 to 287;
signal X_P : integer range 0 to 531;
signal Y_DISP : STD_LOGIC;
signal X_DISP : STD_LOGIC;
signal VS_EN : STD_LOGIC;
signal CE_F : STD_LOGIC;
signal Vs_CE: STD_LOGIC;
signal interrupt: STD_LOGIC;
signal draw_block : STD_LOGIC;
signal draw_block2 : STD_LOGIC;
signal draw_ball : STD_LOGIC;
signal draw_defense: STD_LOGIC;
signal X_POSITION_OUT : integer range -240 to 240;
signal Y_POSITION_OUT : integer range -32 to 240;
signal X_P_NEW : integer range 0 to 531;
signal CE_ENABLE_MOVE : STD_LOGIC;
signal CE_MOVE : STD_LOGIC;
signal MOVE_UP : STD_LOGIC;
signal MOVE_DOWN : STD_LOGIC;
signal MOVE_LEFT : STD_LOGIC;
signal MOVE_RIGHT : STD_LOGIC;
signal X_POSITION_BAR : integer range -240 to 240;
signal BAR_POSITION_MIN : integer range 0 to 531;
signal BAR_POSITION_MAX : integer range 0 to 531;
signal X_POSITION_MIN: integer range 0 to 531;
signal Y_POSITION_MID: integer range 0 to 287;
signal BOUNCE_UP : STD_LOGIC;
signal BOUNCE_UP2: STD_LOGIC;
signal BOUNCE_DOWN : STD_LOGIC;
signal UP_MOVE : STD_LOGIC;
signal FINISH : STD_LOGIC;
signal ANGLE_1 : STD_LOGIC;
signal ANGLE_2 : STD_LOGIC;
signal CE_JUMP : STD_LOGIC;
signal X_PLUS_2 : STD_LOGIC;
signal X_MIN_2 : STD_LOGIC;
signal MOVE_2: STD_LOGIC;
signal Y_READ : std_logic_vector(7 downto 0);
signal X_READ : std_logic_vector(7 downto 0);
signal MOVE_BAR_LEFT : STD_LOGIC;
signal MOVE_BAR_RIGHT : STD_LOGIC;
signal MOVE_BAR_PLUS : STD_LOGIC;
signal MOVE_BAR_MIN : STD_LOGIC;
signal CHANGE_DIRECTION_X1 : STD_LOGIC;
signal CHANGE_DIRECTION_X2 : STD_LOGIC;
signal gameover : STD_LOGIC_VECTOR(15 downto 0);
signal romaddr : STD_LOGIC_VECTOR(15 downto 0);

begin

MOVE_BAR_PLUS <= MOVE_BAR_LEFT or MIN;
MOVE_BAR_MIN <= MOVE_BAR_RIGHT or PLUS;

u1:V_SYNC_1 port map(CLK=>CLK, DISP_Y=>Y_DISP, Y_POS=>Y_P, V_SYNC=>V_SYNC, VS_EN=>VS_CE, RESET=>RESET);
u2:H_SYNC_1 port map(CLK=>CLK, DISP_X=>X_DISP, X_POS=>X_P, H_SYNC=>H_SYNC, H_CE=>CE_F, VS_EN => VS_CE, RESET=>RESET);
u3:CLK_DELAY port map(CLK=>CLK, CLK_OUT=>DCLK, CE_FIX=>CE_F, RESET=>RESET);
u4:Block_1 port map(CLK => CLK, RESET => RESET, X_POSITION => X_P, Y_POSITION => Y_P, B_EN => draw_block);
u5:BLOCK_2 port map(CLK => CLK, RESET => RESET, X_POSITION => X_P, Y_POSITION => Y_P, B2_EN => draw_block2);
u6:BALL port map(CLK => CLK, RESET => RESET, X_POSITION => X_P, NEW_X => X_POSITION_OUT,NEW_Y => Y_POSITION_OUT, Y_POSITION => Y_P, BALL_EN => draw_ball);
u7:DEFENSE port map(CLK => CLK, RESET => RESET, NEW_X => X_POSITION_BAR, X_POSITION => X_P, Y_POSITION => Y_P, DEFENSE_EN => draw_defense);
u8:MOVE_X_DIRECTION port map(CLK => CLK, RESET => RESET, CE => CE_MOVE , X_POSITION_OUT =>  X_POSITION_OUT, X_PLUS => MOVE_RIGHT, X_MIN => MOVE_LEFT, MOVE_2 => MOVE_2); 
u9:move_delay port map(CLK => CLK, RESET => RESET, MOVE_CLK => CE_MOVE);
u10:MOVE_Y_DIRECTION port map(CLK => CLK, RESET => RESET, CE => CE_MOVE , Y_POSITION_OUT =>  Y_POSITION_OUT, Y_PLUS => MOVE_UP, Y_MIN => MOVE_DOWN);
u11:Y_BOUNCE_CHECK port map(CLK => CLK, RESET => RESET, START => START, Y_POSITION_IN => Y_POSITION_OUT, BOUNCE_UP => BOUNCE_UP, BOUNCE_UP2 => BOUNCE_UP2, BOUNCE_DOWN => BOUNCE_DOWN, FINISH => FINISH, MOVE_UP => MOVE_UP, MOVE_DOWN => MOVE_DOWN);
u12:X_BOUNCE_CHECK port map(CLK => CLK, RESET => RESET, START => START, X_POSITION_IN => X_POSITION_OUT, ANGLE_1 => ANGLE_1, ANGLE_2 => ANGLE_2,X_MIN_2 => X_MIN_2, X_PLUS_2 => X_PLUS_2, MOVE_2 => MOVE_2, CHANGE_DIRECTION_X1 => CHANGE_DIRECTION_X1,CHANGE_DIRECTION_X2 => CHANGE_DIRECTION_X2, FINISH => FINISH, MOVE_RIGHT => MOVE_RIGHT, MOVE_LEFT => MOVE_LEFT);
u13:MOVE_BAR port map(CLK => CLK, RESET => RESET, CE => CE_MOVE, X_POSITION_BAR => X_POSITION_BAR, BAR_PLUS=> MOVE_BAR_PLUS, BAR_MIN => MOVE_BAR_MIN);
u14:TOUCH_POSITIONS port map(CLK => CLK, RESET => RESET, INT => interrupt, DCLK => sck, BUSY => BUSY, CS => ssel, MOSI => MOSI, MISO => MISO, OUTPUT_X => X_READ, OUTPUT_Y => Y_READ);
u15:MOVE_TOUCHES port map(CLK => CLK, RESET => RESET,X_IN => X_READ ,Y_IN => Y_READ , LEFT => MOVE_BAR_LEFT , RIGHT => MOVE_BAR_RIGHT);

PWM <='1';
GND <='0';
DISP_EN <=(Y_DISP and X_DISP);

--draw the blocks with the correct colors. Also display the touch position on the led's
process(draw_block, draw_block2, draw_ball, draw_defense, FINISH, SELECT_X_Y)
begin

if(FINISH ='1') then
        Red <= "11111111";
        blue <= "0000";
        green <= "000000"; 
end if;
if(FINISH = '0') then
    if(draw_defense = '1') then
        Red <= "11111111";
        blue <= "1111";
        green <= "111111";    
    elsif(draw_ball = '1') then
        Red <= "00000000";
        blue <= "0000";
        green <= "111111";
    elsif(draw_block = '1') then
        Red <= "11111111";
        blue <= "0000";
        green <= "000000";
    elsif(draw_block2 = '1') then
        Red <= "00000000";
        blue <= "1111";
        green <= "000000";
    else
        Red <= "00000000";
        blue <= "0000";
        green <= "000000";
    end if;
end if;

if(SELECT_X_Y = '1') then
    X_Y_VALUE_TOUCH <= X_READ(7 downto 4);
else
    X_Y_VALUE_TOUCH <= Y_READ(7 downto 4);
end if;
    
end process;

--ball touches bar: 2 possible directions and 2 angles
process(X_POSITION_OUT, BAR_POSITION_MIN, X_POSITION_OUT, BAR_POSITION_MAX, Y_POSITION_OUT)
begin
if(CLK'event and CLK='1') then
    if((X_POSITION_OUT >= (X_POSITION_BAR -45)) and (X_POSITION_OUT <= (X_POSITION_BAR + 45))) then
        if(Y_POSITION_OUT = 0) then
            BOUNCE_UP <= '1';
            if((X_POSITION_OUT >= (X_POSITION_BAR -45)) and (X_POSITION_OUT <= X_POSITION_BAR)) then
                ANGLE_1 <= '1';
                if((X_POSITION_OUT >= (X_POSITION_BAR -45)) and (X_POSITION_OUT <= (X_POSITION_BAR-20))) then
                   X_MIN_2 <= '1';
                else
                   X_MIN_2 <= '0';
                end if;
            else
                ANGLE_1 <= '0';
            end if;
            if((X_POSITION_OUT > X_POSITION_BAR) and (X_POSITION_OUT <= (X_POSITION_BAR + 45))) then
                ANGLE_2 <= '1';
                if((X_POSITION_OUT >= (X_POSITION_BAR+20)) and (X_POSITION_OUT <= (X_POSITION_BAR + 45))) then
                    X_PLUS_2 <= '1';
                else
                    X_PLUS_2 <= '0';
                end if;
            else
                ANGLE_2 <= '0';
            end if;
        else
            BOUNCE_UP <= '0';
            ANGLE_1 <= '0';
            ANGLE_2 <= '0';
        end if;
    end if;
end if;
end process;

--ball touches bottom and top bricks
process(CLK, X_POSITION_OUT, Y_POSITION_OUT)
begin
if(CLK'event and CLK='1') then
    if(((X_POSITION_OUT >= -212) and (X_POSITION_OUT <= -173)) or ((X_POSITION_OUT >= -137) and (X_POSITION_OUT <=-98)) or ((X_POSITION_OUT >= -62) and (X_POSITION_OUT <= -23)) or ((X_POSITION_OUT >= 13) and (X_POSITION_OUT <= 52)) or ((X_POSITION_OUT >= 88) and (X_POSITION_OUT <= 127)) or ((X_POSITION_OUT >= 163) and (X_POSITION_OUT <= 202))) then
        if((Y_POSITION_OUT = 119) or (Y_POSITION_OUT = 169)) then -- normally 126 but -7 because of the radius of the circle, the same for 176
            BOUNCE_DOWN <= '1';
        elsif((Y_POSITION_OUT = 158) or (Y_POSITION_OUT = 208)) then
            BOUNCE_UP2 <= '1';
        else
            BOUNCE_UP2 <= '0';
            BOUNCE_DOWN <= '0';
        end if;
    end if;
end if;
end process;

--ball touches sides of bricks
process(CLK, X_POSITION_OUT, Y_POSITION_OUT)
begin
if(CLK'event and CLK='1') then
CHANGE_DIRECTION_X1 <= '0';
CHANGE_DIRECTION_X2 <= '0';

    if(((Y_POSITION_OUT >= 119) and (Y_POSITION_OUT <= 158)) or ((Y_POSITION_OUT >= 169) and (Y_POSITION_OUT <=208))) then    
        
        if((X_POSITION_OUT = -212) or (X_POSITION_OUT = -211) or (X_POSITION_OUT = -137)or (X_POSITION_OUT = -136) or (X_POSITION_OUT = -62)or (X_POSITION_OUT = -61) or (X_POSITION_OUT = 13)or (X_POSITION_OUT = 14) or (X_POSITION_OUT = 88)or (X_POSITION_OUT = 89) or (X_POSITION_OUT = 163)or (X_POSITION_OUT = 164)) then    
            CHANGE_DIRECTION_X1 <= '1';
        elsif((X_POSITION_OUT = -173)or (X_POSITION_OUT = -172) or (X_POSITION_OUT = -98)or (X_POSITION_OUT = -97) or (X_POSITION_OUT = -23)or (X_POSITION_OUT = -22) or (X_POSITION_OUT = 52)or (X_POSITION_OUT = 53) or (X_POSITION_OUT = 127)or (X_POSITION_OUT = 128) or (X_POSITION_OUT = 202)or (X_POSITION_OUT = 203)) then
            CHANGE_DIRECTION_X2 <= '1';
    
        else
            CHANGE_DIRECTION_X1 <= '0';
            CHANGE_DIRECTION_X2 <= '0';
    
        end if;
    end if;
end if;
end process;

--generate an interrupt for the touches
process(CLK)
variable i : integer := 0;
begin
if(CLK'event and CLK = '1') then
    if(i<200) then
        i:= i+1;
        interrupt <= '0';
    elsif(i=200) then
        interrupt <= '1';
    else
        i := 0;
        interrupt <= '0';
    end if;
end if;
end process;  


end Behavioral;
