#include<conio.h>
#include<stdio.h>
#include<stdlib.h>
#include<process.h>
#include<dos.h>

int makedir(char fname[30]);
void delete_dir(char fname[30]);
void create_file(char fname[30]);
void delete_file(char fname[30]);
void copy();

void main()
{
	int ch,res;
	char filename[30],dir[30],fname[30];

	clrscr();
	do
	  {
		printf(" \n***** MENU *****");
		printf("\n1.Create Directory\n2.Delete Directory ");
		printf("\n3.Create File\n4.Delete File");
		printf("\n5.Copy File");
		printf("\n6.Exit\nEnter Your Choice: ");
		scanf("%d",&ch);
	label:
		switch(ch)
		  {
			case 1:
				printf("\nEnter Directory Name: ");
				scanf(" %s",dir);
				res= makedir(dir);
				if(res!=0)
				   printf("\n----Directory Created Successfully----");
				else
				   printf("\n----Error In Creating Directory----");
				break;
			case 2:	printf("\nEnter Directory Name: ");
				scanf("%s",filename);
				delete_dir(filename);
				break;
			case 3: 
				printf("\nEnter File Name: ");
				scanf("%s",fname);
				create_file(fname);
				break;
			case 4:
				 printf("\nEnter File Name: ");
				scanf("%s",fname);
				delete_file(fname);
				break;
			case 5:
				copy();
				break;
			case 6:
				exit(0);
			default:
				printf("\nWrong Choice..! Enter Correct Choice: ");
				scanf("%d",&ch);
				goto label;
		   }
	} while(ch<=7);
	getch();
}

int makedir(char fname[30])
{
	union REGS regs;
	struct SREGS sregs;
	int result;
	regs.h.ah=0x39;
	regs.x.dx=FP_OFF(fname);
	sregs.ds=FP_SEG(fname);
	result=intdosx(&regs,&regs,&sregs);
	if(regs.x.flags==0)
		return 0;
	else
		 return result;
}

void delete_dir(char fname[30])
{
	union REGS inreg;
	union REGS outreg;
	struct SREGS segreg;
	int result;
	inreg.h.ah=0x3a;
	inreg.x.dx=FP_OFF(fname);
	segreg.ds=FP_SEG(fname);

	int86x(0X21,&inreg,&outreg,&segreg);
	if(outreg.x.cflag)
		printf("\n----Error In Deleting Directory----");
		else
		printf("\n----Directory Deleted  Successfully----");
}

void create_file(char fname[30])
{

	union REGS inreg;
	union REGS outreg;
	struct SREGS segreg;


	inreg.h.ah=0x3c;
	inreg.x.dx=FP_OFF(fname);
	segreg.ds=FP_SEG(fname);

	int86x(0X21,&inreg,&outreg,&segreg);
	if(outreg.x.cflag)
		printf("\n----Error In Creating File----");
	else
		printf("\n----File Created  Successfully----");

}

void delete_file(char fname[30])
{

	union REGS inreg;
	union REGS outreg;

	inreg.h.ah=0x41;	//del file
	inreg.x.dx=FP_OFF(fname);

	int86(0x21,&inreg,&outreg);
	if(outreg.x.cflag)
		printf("\n----Error In Deleting File----");
	else
		printf("\n----File Deleted  Successfully----");
}


void copy()
{
	union REGS inreg;
	union REGS outreg;
	struct SREGS segreg;
	char fname1[128];
	char fname2[128];
	char buffer[256];
	int h1,h2;
	clrscr();

	//Opening File_1 For Reading Contents

	printf("\nEnter File_1 Name Which Is To Be Copied: ");
	scanf("%s",fname1);
	inreg.h.ah=0X3D;
	inreg.x.dx=FP_OFF(fname1);
	segreg.ds=FP_SEG(fname1);
	inreg.h.al=0X00;
	intdosx(&inreg,&outreg,&segreg);
	h1=outreg.x.ax;
	if(outreg.x.cflag)
		printf("\n----Error In Reading File_1----");
	else
		printf("\n----File_1 Reading Successfully----");

	//Creating File_2

	printf("\nEnter File_2 Which Is To Be Created: ");
	scanf("%s",fname2);
	inreg.h.ah=0X3C;
	inreg.x.dx=FP_OFF(fname2);
	segreg.ds=FP_SEG(fname2);
	intdosx(&inreg,&outreg,&segreg);
	if(outreg.x.cflag)
		printf("\n----Error In Creating File_2----");
	else
		printf("\n----File_2 Created Successfully----");

	//Opening File_2 In Write Mode

	inreg.h.ah=0X3D;
	inreg.x.dx=FP_OFF(fname2);
	segreg.ds=FP_SEG(fname2);
	inreg.h.al=0X01;
	intdosx(&inreg,&outreg,&segreg);
	h2=outreg.x.ax;
	if(outreg.x.cflag==0)
	{
		printf("\n----%s File_2 Has Opened In Write Mode----",fname2);
	}
	//Reading Data From File_1
	inreg.h.ah=0X3F;
	inreg.x.bx=h1;
	inreg.x.cx=256;
	inreg.x.dx=FP_OFF(buffer);
	segreg.ds=FP_SEG(buffer);
	intdosx(&inreg,&outreg,&segreg);
	if(outreg.x.cflag==0)
	{
		printf("\n----%s File_1 Is Now Reading Contents----",fname1);
	}

	//Writing Data Into File_2

	inreg.h.ah=0X40;
	inreg.x.bx=h2;
	inreg.x.cx=0XFF;
	inreg.x.dx=FP_OFF(buffer);
	segreg.ds=FP_SEG(buffer);
	intdosx(&inreg,&outreg,&segreg);
	if(outreg.x.cflag==0)
	{
		printf("\n----%s File_2 Is Now Writing Contents----",fname1);
	}
	inreg.h.ah=0X3E;
	inreg.x.bx=h1;
	intdos(&inreg,&outreg);
	inreg.h.ah=0X3E;
	inreg.x.bx=h2;
	intdos(&inreg,&outreg);
	printf("\n--****--FILE COPIED SUCCESSFULLY--****--");
	getch();
}

