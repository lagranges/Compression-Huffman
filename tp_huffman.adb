-- Contient deux procedure Compression et decompression

with Ada.Text_IO, Ada.Integer_Text_Io , Code_binaire , huffman, dico, Ada.Streams.Stream_IO, Ada.IO_Exceptions;
use Ada.Text_IO, Ada.Integer_Text_Io ,Code_binaire , huffman, dico, Ada.Streams.Stream_IO;

procedure TP_Huffman is

    procedure Compression(Nom_Fichier :in String) is
    
    
        procedure Open_fichier(Fichier :out Ada.Streams.Stream_IO.File_Type; Flux: out Stream_Access; Nom_Fichier: in String ) is 
        begin
                Open(Fichier,In_File,Nom_Fichier);
                Flux := Stream(Fichier);
        end Open_fichier;
    
        procedure Debut_Compression(Nom_Fichier : in String; Flux_Sorti: in out Stream_Access) is
      
            type Tab_Character is array (Character range  Character'First..Character'Last) of Integer;
            Tab : Tab_Character := (others => 0);
            Fichier_Tmp : Ada.Streams.Stream_IO.File_Type ;
            Flux_Tmp : Stream_Access ; 
            C : Character ;
        begin 
            Open_fichier(Fichier_Tmp,Flux_Tmp,Nom_Fichier);
            while not End_Of_File(Fichier_Tmp) loop
                Character'Read(Flux_Tmp,C);
                Tab(C) := Tab(C) + 1;
            end loop;
            for i in Tab'Range loop
                if Tab(i) /= 0 then 
                    Integer'Write(Flux_Sorti, Tab(i));
                    Put(Tab(i),0);
                    Character'Write(Flux_Sorti, i);
                    Put(i);
                end if;
            end loop;
                Integer'Write(FLux_Sorti,0);
                Put(0,0);
            Close(Fichier_Tmp);
        end Debut_Compression;   
    
        Fichier_Sorti : Ada.Streams.Stream_IO.File_Type; 
        D: Dictionnaire; 
        Flux_Sorti: Stream_Access;
        Fichier_Entre: Ada.Streams.Stream_IO.File_Type;
        Flux_Entre: Stream_Access;
        -- la suite 0 1 qu'on doit afficher
        C: Code:= Creer_Code;
        Char: Character;
        i: Integer:= 0;
    begin  
    
        Create(Fichier_Sorti,Out_File,"compression.huffman");
        Flux_Sorti := Stream(Fichier_Sorti);
        Put_Line("Compression d'un fichier, Ecrire au début de fichier");
        
        -- Ecire list des caractere et ses nombres d'apparition
        Debut_Compression(Nom_Fichier,Flux_Sorti);
        
        -- Traiduire la text
        D := Creer_Dictionnaire_Text(Nom_Fichier);
        Afficher(D);
        Open_Fichier(Fichier_Entre,Flux_Entre,Nom_Fichier);
        while not End_Of_File(Fichier_Entre) loop
            Character'Read(Flux_Entre,Char);
            Inserer_Code_Queue(C,Traduire(D,Char));
            Ecrire(C, Flux_Sorti);
        end loop;
       
        Close(Fichier_Entre);
        Close(Fichier_Sorti);
    
    
    end Compression;    


    procedure Decompression(Nom_Fichier: in String; Flux_Sorti : Stream_Access) is 
        D: Dictionnaire := Creer_Dictionnaire_Binaire(Nom_Fichier);
        Fichier: Ada.Streams.Stream_IO.File_Type;
        Flux: Stream_Access; 
        I: Integer;
        Char: Character;
        C: Code;
        O: Octet;
    begin   
        Open_Fichier(Fichier, Flux, Nom_Fichier);
        Integer'Read(Flux,I);
        while I /= 0 loop
            Character'Read(Flux, Char);
            Integer'Read(Flux,I);
        end loop;

        while not End_Of_File(Fichier) loop
            Octet'Read(Flux,O); 
        end loop;

    end Decompression;

begin 
    begin    
        Compression("a.txt");
    exception
        when Ada.IO_Exceptions.Name_Error =>
            Put_Line("Le fichier n'est pas exist");
            return;
        when others =>
            Put_Line("Ne peux pas compressier ce fichier");
            return;
    end;
end TP_Huffman;

