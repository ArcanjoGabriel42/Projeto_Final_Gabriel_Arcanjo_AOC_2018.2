library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


Entity memram is port
	(Endereco: in std_logic_vector (15 downto 0);
	 EscData: in std_logic_vector (15 downto 0);	 
	 SaiData: out std_logic_vector (15 downto 0);
	 Clock, EscMem, LeMem: in std_logic
	);
End memram;

Architecture behavior of memram is

type RAMMem is array (0 to 1000) of std_logic_vector (15 downto 0);

signal RAM : RAMMem := (others => "0000000000000000");

begin
	process(Clock)
		begin
			if(rising_edge(Clock)) then
				if(EscMem = '1') then
					RAM(to_integer(unsigned(Endereco))) <= EscData;
				elsif (LeMem = '1') then
					SaiData <= RAM(to_integer(unsigned(Endereco)));
				else
					SaiData <= "XXXXXXXXXXXXXXXX";
				end if;
			end if;
	end process;
end behavior;
