library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity decoder is
	port (
		clk, ch1A, ch1B, ch2A, ch2B, ch3A, ch3B, ch4A, ch4B : in std_logic;
		sel : in std_logic_vector(3 downto 0);
		count_out : out std_logic_vector(11 downto 0);
		led1, led2 : out std_logic
	);
end entity decoder;

architecture decoderArch of decoder is

	signal count1, count2, count3, count4 : std_logic_vector (23 downto 0);
	signal speed1, speed2, speed3, speed4 : std_logic_vector (23 downto 0);

	component Quad
		port (
			clk : in std_logic;
			chA : in std_logic;
			chB : in std_logic;
			invert : in std_logic;		-- 0=left, 1=right
			wheel_type : in std_logic;	-- 0=wheel, 1=motor
			count : out std_logic_vector (23 downto 0);
			speed : out std_logic_vector (23 downto 0)
		);
	end component Quad;
	
begin
	leftWheelEncoder : Quad
		port map (
			clk => clk,
			chA => ch1A,
			chB => ch1B,
			invert => '0',
			wheel_type => '0',
			count => count1,
			speed => speed1
		);

	rightWheelEncoder : Quad
		port map (
			clk => clk,
			chA => ch2A,
			chB => ch2B,
			invert => '1',
			wheel_type => '0',
			count => count2,
			speed => speed2
		);

	leftMotorEncoder : Quad
		port map (
			clk => clk,
			chA => ch3A,
			chB => ch3B,
			invert => '0',
			wheel_type => '1',
			count => count3,
			speed => speed3
		);

	rightMotorEncoder : Quad
		port map (
			clk => clk,
			chA => ch4A,
			chB => ch4B,
			invert => '1',
			wheel_type => '1',
			count => count4,
			speed => speed4
		);

	count_out <= count1(11 downto 0) when sel = "0000" else
				    count1(23 downto 12) when sel = "0001" else
				    count2(11 downto 0) when sel = "0010" else
				    count2(23 downto 12) when sel = "0011" else
					 count3(11 downto 0) when sel = "0100" else
				    count3(23 downto 12) when sel = "0101" else
				    count4(11 downto 0) when sel = "0110" else
					 count4(23 downto 12) when sel = "0111" else
					 speed1(11 downto 0) when sel = "1000" else
				    speed1(23 downto 12) when sel = "1001" else
				    speed2(11 downto 0) when sel = "1010" else
				    speed2(23 downto 12) when sel = "1011" else
					 speed3(11 downto 0) when sel = "1100" else
				    speed3(23 downto 12) when sel = "1101" else
				    speed4(11 downto 0) when sel = "1110" else
					 speed4(23 downto 12);

	led1 <= ch4A;
	led2 <= ch4B;

end architecture decoderArch;