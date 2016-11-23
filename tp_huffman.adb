-- Contient deux procedure Compression et decompression

with Ada.Text_IO, Ada.Integer_Text_Io, File_priorite, huffman, dico, Ada.Streams.Stream_IO;
use Ada.Text_IO, Ada.Integer_Text_Io, File_priorite, huffman, dico, Ada.Streams.Stream_IO;

procedure Compression(Nom_Fichier : String) is
   
    D: Dictionnaire := Creer_Dictionnaire_Text(Nom_Fichier);
    Fichier_Sorti: File_Type := Create(Fichier,Out_File,Nom_Fichier+".huffman");
    Flux_Sorti: Stream_Access := Stream(Fichier);
    Fichier_Entre: File_Type;
    Flux_Entre: Stream_Access;
    -- la suite 0 1 qu'on doit afficher
    C: Code:= Creer_Code;

begin    
    begin
        Fichier_Entre := Open(Fichier,In_File,Nom_Fichier);
        Flux_Entre := Stream(Fichier);
    exception
        when other => Put_Line("Erreur en lecture");
    end;
    
    

    while End_Of_File(Fichier_Entre) loop 
        
    end loop;
end Compression;    

