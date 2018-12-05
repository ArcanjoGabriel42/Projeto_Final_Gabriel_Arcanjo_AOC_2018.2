LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY memoria_ROM2 is 
PORT(
	clk: IN STD_LOGIC;
	entrada: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	op : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	rd : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	rt : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	rs : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	funct : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	tipoi : OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
	jump : out STD_LOGIC_VECTOR(11 DOWNTO 0)
);
END memoria_ROM2;

ARCHITECTURE behavior OF memoria_ROM2 IS

TYPE matriz IS ARRAY(0 TO 65535) OF STD_LOGIC_VECTOR(15 downto 0);
SHARED VARIABLE ROM : matriz:= (others => "0000000000000000");
procedure carregando_ROM (variable listaInstrucoes :inout matriz) is
BEGIN
	listaInstrucoes(0) := "0010000001000000";-- STORE S0 S1 000000
	listaInstrucoes(1) := "0000011010101001";-- SUB  R4 - R3 =>R5
	listaInstrucoes(2) := "0000101010110010";-- MULT R5 * R2 =>R6
	listaInstrucoes(3) := "0000101100110011";-- and $s5,$s4,$6
	listaInstrucoes(4) := "0001100000000001";-- lw $s0,1($s4);	
	listaInstrucoes(6) := "1111000000000000";-- add.d $s2,$s3,$s4
	listaInstrucoes(7) := "1111000000000001";-- sub.d $s5,$s1,$s4
END PROCEDURE;

BEGIN
	carregando_ROM(ROM);
	PROCESS (clk,entrada)
	BEGIN
	op <= (others => '0');
	rs <= (others => '0');
	rt <= (others => '0');
	rd <= (others => '0');
	funct <= (others => '0');
	tipoi <= (others => '0');
	jump <= (others => '0');
	
		IF (clk = '1') THEN
			IF (ROM(conv_integer(entrada))(15 DOWNTO 12) = "0000") THEN
				op <= ROM(conv_integer(entrada))(15 DOWNTO 12);
				rs <= ROM(conv_integer(entrada))(11 DOWNTO 9);
				rt <= ROM(conv_integer(entrada))(8  DOWNTO 6);
				rd <= ROM(conv_integer(entrada))(5  DOWNTO 3);
				funct <= ROM(conv_integer(entrada))(2 DOWNTO 0);
				
			ELSIF (ROM(conv_integer(entrada))(15 DOWNTO 12) = "0001") THEN
				op <= ROM(conv_integer(entrada))(15 DOWNTO 12);
				rs <= ROM(conv_integer(entrada))(11 DOWNTO 9);
				rt <= ROM(conv_integer(entrada))(8 DOWNTO 6);
				tipoi <= ROM(conv_integer(entrada))(5 DOWNTO 0);
			
			ELSIF (ROM(conv_integer(entrada))(15 DOWNTO 12) = "0010") THEN
				op <= ROM(conv_integer(entrada))(15 DOWNTO 12);
				rs <= ROM(conv_integer(entrada))(11 DOWNTO 9);
				rt <= ROM(conv_integer(entrada))(8 DOWNTO 6);
				tipoi <= ROM(conv_integer(entrada))(5 DOWNTO 0);
			
			ELSIF (ROM(conv_integer(entrada))(15 DOWNTO 12) = "0011") THEN
				op <= ROM(conv_integer(entrada))(15 DOWNTO 12);
				rs <= ROM(conv_integer(entrada))(11 DOWNTO 9);
				rt <= ROM(conv_integer(entrada))(8 DOWNTO 6);
				tipoi <= ROM(conv_integer(entrada))(5 DOWNTO 0);
				
			ELSIF (ROM(conv_integer(entrada))(15 DOWNTO 12) = "0100") THEN
				op <= ROM(conv_integer(entrada))(15 DOWNTO 12);
				rs <= ROM(conv_integer(entrada))(11 DOWNTO 9);
				rt <= ROM(conv_integer(entrada))(8 DOWNTO 6);
				tipoi <= ROM(conv_integer(entrada))(5 DOWNTO 0);
			
			ELSIF (ROM(conv_integer(entrada))(15 DOWNTO 12) = "0101") THEN
				op <= ROM(conv_integer(entrada))(15 DOWNTO 12);
				jump <= ROM(conv_integer(entrada))(11 DOWNTO 0);
				
			ELSIF (ROM(conv_integer(entrada))(15 DOWNTO 12) = "0110") THEN
				op <= ROM(conv_integer(entrada))(15 DOWNTO 12);
				jump <= ROM(conv_integer(entrada))(11 DOWNTO 0);
				
			ELSIF (ROM(conv_integer(entrada))(15 DOWNTO 12) = "0111") THEN
				op <= ROM(conv_integer(entrada))(15 DOWNTO 12);
				jump <= ROM(conv_integer(entrada))(11 DOWNTO 0);
			
			END IF;
		END IF;
	END PROCESS;
END behavior;