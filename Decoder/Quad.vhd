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
	signal spd : integer range -2500 to 2500 := 0;
	signal timer : integer range 0 to 250000 := 0;
	type arry is array (0 to 9) of integer range -2500 to 2500;
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
				spd_array <= (to_integer(cnt) - to_integer(prevCnt)) & spd_array(0 to 8);
			
				for n in spd_array'range loop
					spd_sum <= spd_sum + spd_array(n);  -- sum previous 10 ivervals (i.e. 50 ms)                       
				end loop;
				
				-- spd in mm/seconds
				if (wheel_type = '0') then
					spd <= (spd_sum * 226) / 256;		-- target mult factor = 0.8828, actual = 0.8835
				else
					spd <= (spd_sum * 13) / 128;		-- target mult factor = 0.1021, actual = 0.1016
				end if;
				
				-- calculation details for wheel encoders : 
				-- sum = steps per 50 ms
				-- * 20 => steps / seconds
				-- / 4096 => wheel turns / seconds
				-- * (57.6 * pi) => mm / seconds
				-- = 0.8835

				-- calculation details for motor encoders : 
				-- sum = steps per 50 ms
				-- * 20 => steps / seconds
				-- / 2000 => motor turns / seconds
				-- / 20 => wheel turns / seconds
				-- * (65 * pi) => mm / seconds
				-- = 0.1021
				
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