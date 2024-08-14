package main

import "core:fmt"
import "core:os"
import "core:strconv"

TokenType :: enum{
	NUM,
	REG,
	LOAD,
	ADD,
	JMP,
}
Token :: struct{
	off:  u32,
	val:  i32,
	type: TokenType,
}

isChar :: proc(char: byte) -> bool{return char >= 'a' && char <= 'z'}
isNum :: proc(char: byte) -> bool{return char >= '0' && char <= '9'}
getLineAndOff :: proc(offset: u32, fileCont: []byte) -> (u32, u32){
	line: u32 = 0
	off: u32 = 0
	x : u32 = 0
	for(x != offset){
		x += 1
		if(fileCont[x] == '\n'){line += 1}
	}
	for(fileCont[x] != '\n' && x > 0){
		x -= 1;
		off += 1;
	}
	return line, off
}
tokenize :: proc(fileName: string, fileCont: []byte) -> ([dynamic]Token, bool){
	eatUnwantedChars :: proc(off: u32, cont: []byte) -> u32{
		x := off
		for(x<u32(len(cont))){
			switch(cont[x]){
			case '\n': fallthrough
			case ' ': fallthrough
			case '\t': fallthrough
			case '\r': x += 1
			case: return x
			}
		}
		return x
	}
	tokenTypeMap := map[string]TokenType{
		"load" = .LOAD,
		"add"  = .ADD,
		"jmp"  = .JMP,
	}
	defer delete(tokenTypeMap)
	toks: [dynamic]Token
	x: u32 = 0
	for(x < u32(len(fileCont))){
		tok: Token
		x = eatUnwantedChars(x, fileCont);
		if(fileCont[x] == '#'){
			for(fileCont[x] != '\n'){x += 1}
			x += 1;
			continue
		}else if(isChar(fileCont[x])){
			start := x
			for(isChar(fileCont[x])){x += 1}
			tokenName := string(fileCont[start:x])
			tokType, ok := tokenTypeMap[tokenName]
			if !ok{
				fmt.printf("%s(%d:%d): Invalid instruction %s\n", fileName, getLineAndOff(x, fileCont), tokenName);
				return toks, false
			}
			tok.type = tokType
			tok.off = start
		}else if(isNum(fileCont[x]) || fileCont[x] == '%'){
			start := x
			tok.type = TokenType.NUM
			if(fileCont[x] == '%'){
				tok.type = TokenType.REG
				x += 1
				start += 1
			}
			for(isNum(fileCont[x])){x += 1}
			numStr := string(fileCont[start:x])
			num, ok := strconv.parse_int(numStr, 10)
			if !ok{
				fmt.printf("%s(%d:%d): Invalid integer %s\n", fileName, getLineAndOff(x, fileCont), numStr);
				return toks, false
			}
			tok.off = (tok.type==TokenType.REG)?start-1:start
			tok.val = i32(num)
		}else{
			fmt.printf("%s(%d:%d): Invalid char %d(%c)\n", fileName, getLineAndOff(x, fileCont), fileCont[x], fileCont[x]);
			return toks, false
		}
		append(&toks, tok)
		x = eatUnwantedChars(x, fileCont);
	}
	return toks, true
}
main :: proc(){
	if len(os.args) < 2{
		fmt.println("No input file :(")
		return
	};
	outputFile := "a.out"
	if(len(os.args) > 2){outputFile = os.args[2]}
	fileName := os.args[1]
	fileCont, fileReadStat := os.read_entire_file(fileName)
	if !fileReadStat{
		fmt.println("Could not read file", fileName)
		return
	};
	defer delete(fileCont)
	tokens, ok := tokenize(fileName, fileCont)
	defer delete(tokens)
	if !ok{return}
};
