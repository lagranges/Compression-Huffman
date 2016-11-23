-- Ce fichier a pour objectif de réaliser des lectures/écritures
-- en texteul et en binaire dans des fichier
with Ada.Text_IO, Ada.Integer_Text_Io, Ada.Streams.Stream_IO;
use Ada.Text_IO, Ada.Integer_Text_Io, Ada.Streams.Stream_IO; 

procedure Exemple_IO is 
   

    -- Lecture textuel d'un fichier dont le nom est S 
    procedure Lecture_Textuel(S : String) is 
        Fichier: Ada.Streams.Stream_IO.File_Type;
        Flux: Ada.Streams.Stream_IO.Stream_Access;
        C: Character;
    begin
        begin
            Open(Fichier, In_File, S);
        exception when others 
                => Put_Line("Fichier n'exist pas");
                return;
        end;
        Flux := Stream(Fichier);

        Put("Lecture textuel de fichier ");
        Put(S);
        Put_Line(":");

        while not End_Of_File(Fichier) loop
           Character'Read(Flux,C);
           Put(C); 
        end loop;
        
        Close(Fichier);

    end Lecture_Textuel;

    type Octet is new Integer range 0..255;
    for Octet'Size use 8;

    -- Lecture textuel d'un fichier dont le nom est S 
    procedure Lecture_Binaire(S : String) is 
        Fichier: Ada.Streams.Stream_IO.File_Type;
        Flux: Ada.Streams.Stream_IO.Stream_Access;
        B: Octet;
        procedure Put_Octet(B: in Octet) is
           Tmp : Integer:= Integer(B);
           J: Integer; 
        begin
            -- Afficher petit à petit de bit
            for i in 0..7 loop
                j := Tmp / (2**(7-i));
                Tmp := Tmp mod (2**(7-i));
                Put(j,0);
            end loop;
        end Put_Octet;

    begin
        begin
            Open(Fichier, In_File, S);
        exception when others 
                => Put_Line("Fichier n'exist pas");
                return;
        end;
        Flux := Stream(Fichier);

        Put("Lecture binaire de fichier ");
        Put(S);
        Put_Line(":");

        while not End_Of_File(Fichier) loop
           Octet'Read(Flux,B);
           Put_Octet(B);
        end loop;

        Close(Fichier);

    end Lecture_Binaire;
begin
    Lecture_Textuel("Test_Exemple_IO.txt");
    Lecture_Binaire("Test_Exemple_IO.txt");
end Exemple_IO;

