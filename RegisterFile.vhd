Library ieee;
use ieee.std_logic_1164.all;

entity regist is 
GENERIC ( n : integer := 32);
port(
Rst : in std_logic;
clk : in std_logic;
WriteData : in std_logic_vector(31 downto 0);
ReadData1 : out std_logic_vector(31 downto 0);
ReadData2 : out std_logic_vector(31 downto 0);
ReadReg1 : in std_logic_vector(2 downto 0);
ReadReg2 : in std_logic_vector(2 downto 0);
WriteReg : in std_logic_vector(2 downto 0);
enable_write : in std_logic);
end entity;

ARCHITECTURE registA OF regist IS

COMPONENT my_decoder is 
port(
enable : in std_logic;
inADDR : in std_logic_vector(2 downto 0);
S : out std_logic_vector(7 downto 0));
end COMPONENT;

COMPONENT my_nDFF IS
GENERIC ( n : integer := 32);
PORT( Clk,Rst,enable : IN std_logic;
d : IN std_logic_vector(n-1 DOWNTO 0);
q : OUT std_logic_vector(n-1 DOWNTO 0));
END COMPONENT;

COMPONENT tristate is 
GENERIC ( n : integer := 32);
port(
enable : in std_logic;
A : in std_logic_vector(n-1 downto 0);
F : out std_logic_vector(n-1 downto 0));
end COMPONENT;

SIGNAL registers_enable_write,registers_enable_read_1,registers_enable_read_2 : std_logic_vector(7 DOWNTO 0);
SIGNAL regA,regB,regC,regD,regE,regF,regG,regH : std_logic_vector(n-1 DOWNTO 0);
BEGIN
d0: my_decoder PORT MAP (enable_write,WriteReg,registers_enable_write );
d1: my_decoder PORT MAP ('1',ReadReg1,registers_enable_read_1 );
d2: my_decoder PORT MAP ('1',ReadReg2,registers_enable_read_2 );

ts0:tristate GENERIC MAP (n) PORT MAP(registers_enable_read_1(0),regA,ReadData1);
ts1:tristate GENERIC MAP (n) PORT MAP(registers_enable_read_1(1),regB,ReadData1);
ts2:tristate GENERIC MAP (n) PORT MAP(registers_enable_read_1(2),regC,ReadData1);
ts3:tristate GENERIC MAP (n) PORT MAP(registers_enable_read_1(3),regD,ReadData1);
ts4:tristate GENERIC MAP (n) PORT MAP(registers_enable_read_1(4),regE,ReadData1);
ts5:tristate GENERIC MAP (n) PORT MAP(registers_enable_read_1(5),regF,ReadData1);
ts6:tristate GENERIC MAP (n) PORT MAP(registers_enable_read_1(6),regG,ReadData1);
ts7:tristate GENERIC MAP (n) PORT MAP(registers_enable_read_1(7),regH,ReadData1);

ts8:tristate GENERIC MAP (n) PORT MAP(registers_enable_read_2(0),regA,ReadData2);
ts9:tristate GENERIC MAP (n) PORT MAP(registers_enable_read_2(1),regB,ReadData2);
ts10:tristate GENERIC MAP (n) PORT MAP(registers_enable_read_2(2),regC,ReadData2);
ts11:tristate GENERIC MAP (n) PORT MAP(registers_enable_read_2(3),regD,ReadData2);
ts12:tristate GENERIC MAP (n) PORT MAP(registers_enable_read_2(4),regE,ReadData2);
ts13:tristate GENERIC MAP (n) PORT MAP(registers_enable_read_2(5),regF,ReadData2);
ts14:tristate GENERIC MAP (n) PORT MAP(registers_enable_read_2(6),regG,ReadData2);
ts15:tristate GENERIC MAP (n) PORT MAP(registers_enable_read_2(7),regH,ReadData2);

rg0: my_nDFF GENERIC MAP (n) PORT MAP(Clk,Rst,registers_enable_write(0),WriteData,regA);
rg1: my_nDFF GENERIC MAP (n) PORT MAP(Clk,Rst,registers_enable_write(1),WriteData,regB);
rg2: my_nDFF GENERIC MAP (n) PORT MAP(Clk,Rst,registers_enable_write(2),WriteData,regC);
rg3: my_nDFF GENERIC MAP (n) PORT MAP(Clk,Rst,registers_enable_write(3),WriteData,regD);
rg4: my_nDFF GENERIC MAP (n) PORT MAP(Clk,Rst,registers_enable_write(4),WriteData,regE);
rg5: my_nDFF GENERIC MAP (n) PORT MAP(Clk,Rst,registers_enable_write(5),WriteData,regF);
rg6: my_nDFF GENERIC MAP (n) PORT MAP(Clk,Rst,registers_enable_write(6),WriteData,regG);
rg7: my_nDFF GENERIC MAP (n) PORT MAP(Clk,Rst,registers_enable_write(7),WriteData,regH);


END Architecture;

