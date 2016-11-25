-- Contient deux procedure Compression et decompression

with Ada.Text_IO, Ada.Integer_Text_Io , Code_binaire , huffman, dico, Ada.Streams.Stream_IO, Ada.IO_Exceptions;
use Ada.Text_IO, Ada.Integer_Text_Io ,Code_binaire , huffman, dico, Ada.Streams.Stream_IO;

procedure TP_Huffman is

        procedure Open_Fichier(Fichier :out Ada.Streams.Stream_IO.File_Type; Flux: out Stream_Access; Nom_Fichier: in String ) is 
        begin
                Open(Fichier,In_File,Nom_Fichier);
                Flux := Stream(Fichier);
        end Open_fichier;

    procedure Compression(Nom_Fichier :in String) is
    
    
    
        procedure Debut_Compression(Tab : in Tableau_Character; Flux_Sorti: in out Stream_Access) is
      
            Nb_Character : Integer := 0; -- Variable pour compter le nb des characters
        begin 
            for j in Tab'Range loop
                if Tab(j) /= 0 then
                    Nb_Character := Nb_Character + Tab(j); 
                    Integer'Write(Flux_Sorti, Tab(j));
                    Character'Write(Flux_Sorti, j);
                end if;
            end loop;
                Integer'Write(FLux_Sorti,0);
                Integer'Write(Flux_Sorti, Nb_Character);
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
        Tab: Tableau_Character;
    begin  
    
        Create(Fichier_Sorti,Out_File,"compression.huffman");
        Flux_Sorti := Stream(Fichier_Sorti);
        
        -- Traiduire la text
        Creer_Dictionnaire_Text(D,Nom_Fichier, Tab);
        
        -- Ecire list des caractere et ses nombres d'apparition
        Debut_Compression(Tab,Flux_Sorti);
        
        Open_Fichier(Fichier_Entre,Flux_Entre,Nom_Fichier);
        while not End_Of_File(Fichier_Entre) loop
            Character'Read(Flux_Entre,Char);
            Inserer_Code_Queue(C,Traduire(D,Char));
            Ecrire_Binaire(C, Flux_Sorti);
        end loop;
        for j in Integer range 1..7 loop
            Inserer_Queue(C,0);
        end loop;
            Ecrire_Binaire(C,Flux_Sorti); 
        Close(Fichier_Entre);
        Close(Fichier_Sorti);
    
    
    end Compression;    


    procedure Decompression(Nom_Fichier: in String) is 

        procedure Ecrire_Text(C: in out Code; D: in Dictionnaire; 
                              Flux: in out Stream_Access; Nb_Character : in out Integer ) is 
            Tmp : Code := Creer_Code;
            B: Bit;
            L: Integer :=  Longeur_Code(C);
            Char: Character;
        begin
            for i in Integer range 1..L loop
                Supprimer_Tete(C,B);
                Inserer_Queue(Tmp,B);
                Char := Traduire(D,Tmp);
                if Char /= Character'Val(16#00#) then
                    Character'Write(Flux,Char);
                    Nb_Character := Nb_Character - 1;
                    if Nb_Character = 0 then return; end if;
                    Tmp := Creer_Code;
                end if;
            end loop;
            C := Tmp;
        end Ecrire_Text;
    
        D: Dictionnaire := Creer_Dictionnaire_Binaire(Nom_Fichier);
        Fichier_Sorti: Ada.Streams.Stream_IO.File_Type;
        Fichier: Ada.Streams.Stream_IO.File_Type;
        Flux_Sorti: Stream_Access; 
        Flux: Stream_Access; 
        I, Nb_Character: Integer;
        Char: Character;
        C: Code := Creer_Code;
        O: Octet;
    begin

        Put("Ok");
        Create(Fichier_Sorti, Out_File, "decommpression.huffman" ); 
        Flux_Sorti := Stream(Fichier_Sorti);  
        Open_Fichier(Fichier, Flux, Nom_Fichier);
        Integer'Read(Flux,I);
        while I /= 0 loop
            Character'Read(Flux, Char);
            Integer'Read(Flux,I);
        end loop;
        Integer'Read(Flux,Nb_Character);
        while not End_Of_File(Fichier) loop
            Octet'Read(Flux,O);
            Inserer_Octet_Queue(C,O);
            Ecrire_Text(C,D,Flux_Sorti,Nb_Character); 
        end loop;
        Close(Fichier);
        Close(Fichier_Sorti);
    end Decompression;

begin 

    begin    
        Compression("Tests/iliadAndOdyssey.txt");
    exception
        when Ada.IO_Exceptions.Name_Error =>
            Put_Line("Le fichier de text n'est pas exist");
            return;
        when others =>
            Put_Line("Ne peux pas compressier ce fichier");
            return;
    end;
    
    begin    
        Decompression("compression.huffman");
    exception
        when Ada.IO_Exceptions.Name_Error =>
            Put_Line("Le fichier de compression n'est pas exist");
            return;
        when others =>
            Put_Line("Ne peux pas decompressier ce fichier");
            return;
    end;
    Put_Line("          Fini!");
    New_Line;
end TP_Huffman;

