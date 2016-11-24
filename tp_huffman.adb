-- Contient deux procedure Compression et decompression

with Ada.Text_IO, Ada.Integer_Text_Io, File_priorite, huffman, dico, Ada.Streams.Stream_IO;
use Ada.Text_IO, Ada.Integer_Text_Io, File_priorite, huffman, dico, Ada.Streams.Stream_IO;

procedure Compression(Nom_Fichier : String) is

    procedure Debut_Compression(Fichier: in File_Type; Flux: in  Stream; in
out Flux_Sorti: Stream) is
       type Tab is array (Character Character'First..Character'Last) of
Integer := (other => 0);
        Fichier_Tmp := Fichier;
        Flux_Tmp := Flux; 
        C := Character;
    begin 
        while not End_Of_File(Ficier_Tmp) loop
            Character'Read(Flux,C);
            Tab(C) := Tab(C) + 1;
        end loop;
        for i in Tab'Rang loop
            if Tab(i) /= 0 then 
            Integer(Flux_Sorti, Tab(i));
            Character(Flux_Sorti, i);
        end loop;
            Integer(FLux_Sorti,0);
    end Debut_Compression;    
 
    D: Dictionnaire := Creer_Dictionnaire_Text(Nom_Fichier);
    Fichier_Sorti: File_Type := Create(Fichier,Out_File,Nom_Fichier+".huffman");
    Flux_Sorti: Stream_Access := Stream(Fichier);
    Fichier_Entre: File_Type;
    Flux_Entre: Stream_Access;
    -- la suite 0 1 qu'on doit afficher
    C: Code:= Creer_Code;
    Char: Character;
begin    
    begin
        Fichier_Entre := Open(Fichier,In_File,Nom_Fichier);
        Flux_Entre := Stream(Fichier);
    exception
        when other => Put_Line("Erreur en lecture");
    end;

    Debut_Compression(Fichier_Entre,Flux_Entre,Flux_Sorti);    
    
    while not End_Of_File(Fichier_Entre) loop
        Character'Read(Flux_Entre, Char);
        
    end loop; 

    while End_Of_File(Fichier_Entre) loop 
        
    end loop;
end Compression;    

