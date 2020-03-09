
%{
	#include <stdio.h>
	void yyerror(const char *s){//called by yyparse on error
		printf("%s\n", s);
	}
%}

%token tOPEN tCOURSE tCLOSE tEND tCODE tCLASS  tNAME tTYPE tSTRING tNUM tSECTION  tINSTRUCTOR tCRN  tCAPACITY tMEETING tSELF tDAY tSTART tTIME  tEND_A tMON  tTUE  tWED  tTHU  tFRI tCONSTRAINT tITEM 

%%
prog :  elementList | ;
elementList :  element | element elementList;
element : beginCourse classList endCourse | beginConstraint itemList endConstraint;
beginCourse : tOPEN tCOURSE  courseAttrList tCLOSE;
endCourse : tEND tCOURSE tCLOSE;
courseAttrList :  courseAttr |  courseAttr  courseAttrList;
courseAttr : tCODE tSTRING | tNAME tSTRING |tTYPE tSTRING;
classList : class | class classList;
class :  beginClass classAttrList endClass meetingList closeClass;
beginClass  : tOPEN tCLASS;
endClass :  tCLOSE;
closeClass : tEND tCLASS tCLOSE;
classAttrList :  classAttr | classAttr classAttrList;
classAttr : tSECTION tSTRING | tINSTRUCTOR tSTRING |tCRN tNUM | tCAPACITY tNUM;
meetingList : meeting |meeting  meetingList;
meeting : beginMeeting meetingAttrList endMeeting;
beginMeeting :  tOPEN tMEETING ;
endMeeting :tSELF ;
meetingAttrList : meetingAttr | meetingAttr meetingAttrList;
meetingAttr : tDAY day | tSTART tTIME | tEND_A tTIME;
day : tMON | tTUE | tWED | tTHU | tFRI;
beginConstraint : tOPEN tCONSTRAINT tCLOSE;
endConstraint : tEND tCONSTRAINT  tCLOSE;
itemList :  item | item itemList;
item :  beginItem itemAttr endItem;
beginItem : tOPEN tITEM;
endItem : tSELF;
itemAttr: tCODE tSTRING | tCRN tNUM;

%%
int main(){
	if(yyparse()){
		printf("ERROR\n");
		return 1;		
	}else{
		printf("OK\n");
		return 0;
	}	
} 
