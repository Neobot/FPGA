library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;


entity decoder is
	port (
		clk, ch1A, ch1B, ch2A, ch2B, ch3A, ch3B, ch4A, ch4B : in std_logic;
		sel : in std_logic_vector(2 downto 0);
		count_out : out unsigned(7 downto 0);

		led1 : out std_logic;

		led2 : out std_logic
	);
end entity decoder;

architecture decoderArch of decoder is
	signal count1, count2, count3, count4 : unsigned (31 downto 0) := "01000000000000000000000000000000";

	component Quad
		port (
			clk : in std_logic;
			chA : in std_logic;
			chB : in std_logic;
			count : out unsigned (31 downto 0)
		);
	end component Quad;
	
begin
	leftWheelEncoder : Quad
		port map (
			clk => clk,
			chA => ch1A,
			chB => ch1B,
			count => count1
		);

	rightWheelEncoder : Quad
		port map (
			clk => clk,
			chA => ch2A,
			chB => ch2B,
			count => count2
		);

	leftMotorEncoder : Quad
		port map (
			clk => clk,
			chA => ch3A,
			chB => ch3B,
			count => count3
		);

	rightMotorEncoder : Quad
		port map (
			clk => clk,
			chA => ch4A,
			chB => ch4B,
			count => count4
		);
	
	count_out <= count1(7 downto 0) when sel = "000" else
				    count1(15 downto 8) when sel = "001" else
					 count1(23 downto 16) when sel = "010" else
					 count1(31 downto 24) when sel = "011" else
				    count2(7 downto 0) when sel = "100" else
				    count2(15 downto 8) when sel = "101" else
					 count2(23 downto 16) when sel = "110" else
					 count2(31 downto 24);

	led1 <= ch1A;
	led2 <= ch1B;
					 
end architecture decoderArch;