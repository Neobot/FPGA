library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity Quad is
	port (
		clk : in std_logic;
		chA : in std_logic;
		chB : in std_logic;
		invert : in std_logic;
		wheel_type : in std_logic;
		count : out std_logic_vector (23 downto 0);
		speed : out std_logic_vector (23 downto 0)
	);
end entity Quad;

architecture QuadArch of Quad is
	signal Ar : std_logic_vector (1 downto 0) := "00";
	signal Br : std_logic_vector (1 downto 0) := "00";
	signal cnt : unsigned (23 downto 0) := "100000000000000000000000";
	signal prevCnt : unsigned (23 downto 0) := "100000000000000000000000";
	signal spd : integer range -25000000 to 25000000 := 0;
	signal timer : integer range 0 to 250000 := 0;
	type arry is array (0 to 9) of integer range -10000 to 10000;
	signal spd_array : arry;
	signal spd_sum : integer range -25000 to 25000;
begin
	process (clk)
	begin
		if rising_edge(clk) then
			Ar(1) <= Ar(0);
			Ar(0) <= chA;
			Br(1) <= Br(0);
			Br(0) <= chB;
			
			if (invert = '1') then
				if (Ar = "01") then		-- rising edge of A
					if (Br(0) = '0') then 
						cnt <= cnt - 1;
					else 
						cnt <= cnt + 1;
					end if;
				elsif (Ar = "10") then		-- falling edge of A
					if (Br(0) = '1') then 
						cnt <= cnt - 1;
					else 
						cnt <= cnt + 1;
					end if;
				elsif (Br = "01") then		-- rising edge of B
					if (Ar(0) = '1') then 
						cnt <= cnt - 1;
					else 
						cnt <= cnt + 1;
					end if;
				elsif (Br = "10") then		-- falling edge of B
					if (Ar(0) = '0') then 
						cnt <= cnt - 1;
					else 
						cnt <= cnt + 1;
					end if;
				end if;
			else
				if (Ar = "01") then		-- rising edge of A
					if (Br(0) = '0') then 
						cnt <= cnt + 1;
					else 
						cnt <= cnt - 1;
					end if;
				elsif (Ar = "10") then		-- falling edge of A
					if (Br(0) = '1') then 
						cnt <= cnt + 1;
					else 
						cnt <= cnt - 1;
					end if;
				elsif (Br = "01") then		-- rising edge of B
					if (Ar(0) = '1') then 
						cnt <= cnt + 1;
					else 
						cnt <= cnt - 1;
					end if;
				elsif (Br = "10") then		-- falling edge of B
					if (Ar(0) = '0') then 
						cnt <= cnt + 1;
					else 
						cnt <= cnt - 1;
					end if;
				end if;
			end if;
			
			if (timer = 250000) then		-- 5ms interval
				spd_array(9) <= spd_array(8);
				spd_array(8) <= spd_array(7);
				spd_array(7) <= spd_array(6);
				spd_array(6) <= spd_array(5);
				spd_array(5) <= spd_array(4);
				spd_array(4) <= spd_array(3);
				spd_array(3) <= spd_array(2);
				spd_array(2) <= spd_array(1);
				spd_array(1) <= spd_array(0);
				spd_array(0) <= to_integer(cnt) - to_integer(prevCnt);
			
				spd_sum <= spd_array(0) + spd_array(1) + spd_array(2) + spd_array(3) + spd_array(4) + 
						spd_array(5) + spd_array(6) + spd_array(7) + spd_array(8) + spd_array(9);
				
				if (wheel_type = '0') then
					spd <= spd_sum;	-- in mm/seconds
				else
					spd <= spd_sum / 10;
				end if;
				
				-- calculation details for wheel encoders : 
				-- sum = steps per 50 ms
				-- * 20 => steps / seconds
				-- / 4048 => wheel turns / seconds
				-- * (65 * pi) => mm / seconds

				-- calculation details for motor encoders : 
				-- sum = steps per 50 ms
				-- * 20 => steps / seconds
				-- / 2000 => motor turns / seconds
				-- / 20 => wheel turns / seconds
				-- * (65 * pi) => mm / seconds
				
				prevCnt <= cnt;
				timer <= 0;
			else
				timer <= timer + 1;
			end if;
			
		end if;
	end process;

	count <= std_logic_vector(cnt);
	speed <= std_logic_vector(to_unsigned(spd+8388608, 24));		-- offset speed so its always positive
			
end architecture QuadArch;