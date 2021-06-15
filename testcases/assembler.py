# -*- coding: utf-8 -*-
"""
Created on Tue Jun 15 03:07:06 2021

@author: Administrator
"""
def getRegCode(register):
    if register[1] == '0':
        return "00000"
    elif register[1] == '1':
        return "00001"
    elif register[1] == '2':
        return "00010"
    elif register[1] == '3':
        return "00011"
    elif register[1] == '4':
        return "00100"
    elif register[1] == '5':
        return "00101"
    elif register[1] == '6':
        return "00110"
    elif register[1] == '7':
        return "00111"


        
                          
 
address_counter=0;
flag_reset=0;          
     

def writeLines(code):
    global address_counter
    with open('MachineCode.mem', 'a') as the_file:
            code1=hex(address_counter).split('x')[-1]+": "+code[0:16]
            print("code1",code1)
            the_file.write(code1+"\n")
            address_counter=address_counter+1;
            code2=hex(address_counter).split('x')[-1]+": "+code[16:]
            print("code2", code2)
            the_file.write(code2+"\n")
            address_counter=address_counter+1;

                

with open("sample3.txt", "r") as a_file:
  with open('MachineCode.mem', 'w') as the_file:
       string2="// memory data file (do not edit the following line - required for mem load use)\n// instance=/processor/ftch/IM/ram\n// format=mti addressradix=h dataradix=b version=1.0 wordsperline=1"
       the_file.write(string2+"\n")
      
  for line in a_file:
    if(line== "\n"):
        continue;
    #print(line+ "\n")
        
    if(flag_reset==1): 
        #reading .org value
        with open('Ram.mem', 'w') as the_file1:
            string="// memory data file (do not edit the following line - required for mem load use)\n// instance=/processor/Mem/IM/ram\n// format=mti addressradix=h dataradix=b version=1.0 wordsperline=1"
            the_file1.write(string+"\n")
            hex_as_int = int(line, 16)
            hex_as_binary = bin(hex_as_int)
            padded_binary = hex_as_binary[2:].zfill(32)
            code1="0:  "+padded_binary[0:16]
            the_file1.write(code1+"\n")
            code2="1:  "+padded_binary[16:]
            the_file1.write(code2+"\n")
            flag_reset=0;
            
    
        
    
    else:  
        instruction = line.upper().strip()
        instruction_splited = instruction.split()
        
        
        
        
        
        if instruction_splited[0] == ".ORG":
             flag_reset=0;
             if(instruction_splited[1]=="0") :
                 flag_reset=1;
             address_counter=int(instruction_splited[1],16)   #hex(int(instruction_splited[1])).split('x')[-1]
             
           
                 
        
        
        
        if instruction_splited[0] == "ADD":
            opcode = "000100"
            registers = instruction_splited[1].split(",")
            Reg_src = getRegCode(registers[0])
            Reg_dst = getRegCode(registers[1])
            code =opcode+Reg_dst+Reg_src+"0000000000000000"
            writeLines(code)
            
            
              
        elif instruction_splited[0] == "SUB":
            opcode = "000101"
            registers = instruction_splited[1].split(",")
            Reg_src = getRegCode(registers[0])
            Reg_dst = getRegCode(registers[1])
            code = opcode+Reg_dst+Reg_src+"0000000000000000"
            writeLines(code)
            
                
                
                
                
                
        elif instruction_splited[0] == "MOV":
            opcode = "000011"
            registers = instruction_splited[1].split(",")
            Reg_src = getRegCode(registers[0])
            Reg_dst = getRegCode(registers[1])
            code = opcode+Reg_dst+Reg_src+"0000000000000000"
            writeLines(code)
           
                
        elif instruction_splited[0] == "AND":
            opcode = "000110"
            registers = instruction_splited[1].split(",")
            Reg_src = getRegCode(registers[0])
            Reg_dst = getRegCode(registers[1])
            code = opcode+Reg_dst+Reg_src+"0000000000000000"
            writeLines(code)
            
        elif instruction_splited[0] == "OR":
            opcode = "000111"
            registers = instruction_splited[1].split(",")
            Reg_src = getRegCode(registers[0])
            Reg_dst = getRegCode(registers[1])
            code = opcode+Reg_dst+Reg_src+"0000000000000000"
            writeLines(code)
           
            
        elif instruction_splited[0] == "NOT":
            opcode = "000000"
            Reg_dst = getRegCode(instruction_splited[1])
            code = opcode+Reg_dst+"000000000000000000000"
            writeLines(code)
           
            
        elif instruction_splited[0] == "INC":
            print("INC")
            opcode = "000001"
            Reg_dst = getRegCode(instruction_splited[1])
            code = opcode+Reg_dst+"000000000000000000000"
            writeLines(code)
            print(code)
            print("ana hena aaaaaaaaaaaaaa")
         
            
        elif instruction_splited[0] == "DEC":
            opcode = "000010"
            Reg_dst = getRegCode(instruction_splited[1])
            code = opcode+Reg_dst+"000000000000000000000"
            writeLines(code)
         
            
        elif instruction_splited[0] == "PUSH":
            opcode = "110000"
            Reg_dst = getRegCode(instruction_splited[1])
            code = opcode+Reg_dst+"000000000000000000000"
            writeLines(code)
           
            
        elif instruction_splited[0] == "POP":
            opcode = "110010"
            Reg_dst = getRegCode(instruction_splited[1])
            code = opcode+Reg_dst+"000000000000000000000"
            writeLines(code)
        
        
        elif instruction_splited[0] == "CALL":
            opcode = "110001"
            Reg_dst = getRegCode(instruction_splited[1])
            code = opcode+Reg_dst+"000000000000000000000"
            writeLines(code)
         
            
        elif instruction_splited[0] == "JZ":
            opcode = "111100"
            Reg_dst = getRegCode(instruction_splited[1])
            code = opcode+Reg_dst+"000000000000000000000"
            writeLines(code)
           
            
        elif instruction_splited[0] == "JN":
            opcode = "111101"
            Reg_dst = getRegCode(instruction_splited[1])
            code = opcode+Reg_dst+"00000000000000000000"
            writeLines(code)
          
            
        elif instruction_splited[0] == "JC":
            opcode = "111110"
            Reg_dst = getRegCode(instruction_splited[1])
            code = opcode+Reg_dst+"000000000000000000000"
            writeLines(code)
           
            
        elif instruction_splited[0] == "JMP":
            opcode = "111111"
            Reg_dst = getRegCode(instruction_splited[1])
            code = opcode+Reg_dst+"000000000000000000000"
            writeLines(code)
          
            
        elif instruction_splited[0] == "IN":
            opcode = "001010"
            Reg_dst = getRegCode(instruction_splited[1])
            code = opcode+Reg_dst+"000000000000000000000"
            writeLines(code)
          
            
        elif instruction_splited[0] == "OUT":
            opcode = "100110"
            Reg_dst = getRegCode(instruction_splited[1])
            code = opcode+Reg_dst+"000000000000000000000"
            writeLines(code)
           
            
        elif instruction_splited[0] == "NOP":
            opcode = "101111"
            code = opcode+"00000000000000000000000000"
            writeLines(code)
           
            
        elif instruction_splited[0] == "RET":
            opcode = "110011"
            code = opcode+"00000000000000000000000000"
            writeLines(code)
            
            
        elif instruction_splited[0] == "Reset":
            opcode = "100000"
            code = opcode+"00000000000000000000000000"
            writeLines(code)
        
        elif instruction_splited[0] == "SETC":
            opcode = "111000"
            code = opcode+"00000000000000000000000000"
            writeLines(code)
            
            
        elif instruction_splited[0] == "CLC":
            opcode = "111011"
            code = opcode+"00000000000000000000000000"
            writeLines(code)
          
            
        elif instruction_splited[0] == "SHL":
            opcode = "011000"
            registers = instruction_splited[1].split(",")
            Reg_src = getRegCode(registers[0])
            hex_as_int = int(registers[1], 16)
            hex_as_binary = bin(hex_as_int)
            padded_binary = hex_as_binary[2:].zfill(16)
            code = opcode+"00000"+Reg_src+padded_binary
            writeLines(code)
        
            
        elif instruction_splited[0] == "SHR":
            opcode = "011001"
            registers = instruction_splited[1].split(",")
            Reg_src = getRegCode(registers[0])
            hex_as_int = int(registers[1], 16)
            hex_as_binary = bin(hex_as_int)
            padded_binary = hex_as_binary[2:].zfill(16)
            code = opcode+"00000"+Reg_src+padded_binary
            writeLines(code)
            
            
        elif instruction_splited[0] == "IADD":
            opcode = "010100"
            registers = instruction_splited[1].split(",")
            Reg_src = getRegCode(registers[0])
            hex_as_int = int(registers[1], 16)
            hex_as_binary = bin(hex_as_int)
            padded_binary = hex_as_binary[2:].zfill(16)
            code = opcode+"00000"+Reg_src+padded_binary
            writeLines(code)
           
        elif instruction_splited[0] == "LDM":
            opcode = "011011"
            registers = instruction_splited[1].split(",")
            Reg_src = getRegCode(registers[0])
            hex_as_int = int(registers[1], 16)
            hex_as_binary = bin(hex_as_int)
            padded_binary = hex_as_binary[2:].zfill(16)
            code = opcode+"00000"+Reg_src+padded_binary
            writeLines(code)
         
        elif instruction_splited[0] == "LDD":
            opcode = "110100"
            registers = instruction_splited[1].split(",")
            Reg_dst = getRegCode(registers[0])
            temp = registers[1].split("(")
            Reg_src = getRegCode(temp[1])
            hex_as_int = int(temp[0], 16)
            hex_as_binary = bin(hex_as_int)
            padded_binary = hex_as_binary[2:].zfill(16)
            code = code = opcode+Reg_dst+Reg_src+padded_binary
            writeLines(code)
           
            
        elif instruction_splited[0] == "STD":
            opcode = "110101"
            registers = instruction_splited[1].split(",")
            Reg_dst = getRegCode(registers[0])
            temp = registers[1].split("(")
            Reg_src = getRegCode(temp[1])
            hex_as_int = int(temp[0], 16)
            hex_as_binary = bin(hex_as_int)
            padded_binary = hex_as_binary[2:].zfill(16)
            code = code = opcode+Reg_dst+Reg_src+padded_binary
            writeLines(code)
            
                
                
