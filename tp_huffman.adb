-- Contient deux procedure Compression et decompression
with Ada.Command_line; use Ada.Command_Line;
with Ada.Text_IO, Ada.Integer_Text_Io , Code_binaire , huffman, dico, Ada.Streams.Stream_IO, Ada.IO_Exceptions;
use Ada.Text_IO, Ada.Integer_Text_Io ,Code_binaire , huffman, dico, Ada.Streams.Stream_IO;

procedure TP_Huffman is

    procedure Open_Fichier(Fichier :out Ada.Streams.Stream_IO.File_Type; Flux: out Stream_Access; Nom_Fichier: in String ) is
    begin
        Open(Fichier,In_File,Nom_Fichier);
        Flux := Stream(Fichier);
    end Open_fichier;

    procedure Compression(Nom_Fichier :in String; Nom_Fichier_Compresse : in String) is

        -- écrire à la tete de fichier compressé fini par nb total de caractere
        -- pram : Tableau de caractere et le nombre d'apparition
        procedure Debut_Compression(Tab : in Tableau_Character; Flux_Sorti: in out Stream_Access) is

            Nb_Character : Integer := 0; -- Variable pour compter le nb des characters
        begin
            for j in Tab'Range loop
                if Tab(j) /= 0 then
                    -- mettre à jour Nb_Char
                    Nb_Character := Nb_Character + Tab(j);
                    -- ecrire le nb d'apparaition
                    Integer'Write(Flux_Sorti, Tab(j));
                    -- ecrire le Caratere correspondante
                    Character'Write(Flux_Sorti, j);
                end if;
            end loop;
                -- ecrire 0 pour infomer la fini la tete
                Integer'Write(FLux_Sorti,0);
                -- ecrire Nb de caractere dans le fichier
                -- pour le cas Nb bits % 8 /= 0 , décomp va lire exactement
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
        Tab_Dic: Tab_Dictionnaire;
    begin

        Create(Fichier_Sorti,Out_File,Nom_Fichier_Compresse);
        Flux_Sorti := Stream(Fichier_Sorti);

        -- Traiduire la text
        Creer_Dictionnaire_Text(D,Nom_Fichier, Tab);

        Tab_Dic := Creer_Tab_Dictionnaire(D);

        -- Ecire list des caractere et ses nombres d'apparition
        Debut_Compression(Tab,Flux_Sorti);

        Open_Fichier(Fichier_Entre,Flux_Entre,Nom_Fichier);

        while not End_Of_File(Fichier_Entre) loop
            Character'Read(Flux_Entre,Char);
            -- Mettre à jour C
            Inserer_Code_Queue(C,Tab_Dic(Char));
            -- Ecrire une code C sur flux
            -- Voir Code.adb
            Ecrire_Binaire(C, Flux_Sorti);
        end loop;
        -- pour ecrire dans le cas longeur de C /= 0
        for j in Integer range 1..7 loop
            Inserer_Queue(C,0);
        end loop;
            Ecrire_Binaire(C,Flux_Sorti);
        Close(Fichier_Entre);
        Close(Fichier_Sorti);


    end Compression;

    -- La fonction décompresse d'un fichier compressé à un fichier textuel
    procedure Decompression(Nom_Fichier: in String; Nom_Fichier_Decompresse : in String) is

        -- Traduire de code à text et ecrire
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
                    -- Metre à jour Nb Caractere
                    Nb_Character := Nb_Character - 1;
                    if Nb_Character = 0 then return; end if;
                    Tmp := Creer_Code;
                end if;
            end loop;
            C := Tmp;
        end Ecrire_Text;

        D: Dictionnaire ;
        Fichier_Sorti: Ada.Streams.Stream_IO.File_Type;
        Fichier: Ada.Streams.Stream_IO.File_Type;
        Flux_Sorti: Stream_Access;
        Flux: Stream_Access;
        Nb_Character: Integer;
        C: Code := Creer_Code;
        O: Octet;
    begin
        Create(Fichier_Sorti, Out_File, Nom_Fichier_Decompresse);        Flux_Sorti := Stream(Fichier_Sorti);
        Open_Fichier(Fichier, Flux, Nom_Fichier);
        -- Lire tete et creer la dictionnaire
        Creer_Dictionnaire_Binaire(D,Flux);
        -- Lire NB caractere
        Integer'Read(Flux,Nb_Character);
        -- Commencer de decompresser
        while not End_Of_File(Fichier) loop
            Octet'Read(Flux,O);
            -- Mettre à jour C
            Inserer_Octet_Queue(C,O);
            Ecrire_Text(C,D,Flux_Sorti,Nb_Character);
        end loop;
        Close(Fichier);
        Close(Fichier_Sorti);
    end Decompression;

begin


        if(Argument_Count = 3) then
            if Argument(1)= "-c" then
                Compression(Argument(2),Argument(3));
            elsif Argument(1) = "-d" then
                Decompression(Argument(2),Argument(3));
            else
                Put("1er arguement invalide c'est soit -c pour compresser soit -d pour decompresser");
            end if;
        else
            Put("Nombre d'arguments insuffisant, il en faut 3 exactement");
        end if;
        exception
            -- Si le fichier n'est pas exist
            when Ada.IO_Exceptions.Name_Error =>
            Put_Line("Le fichier de text n'est pas exist");
            return;
            -- Si le fichier qu'on a besoin de compresser n'est pas un fichier compressé
            -- ou si le fichier que on a bessoin de décompresser n'est pas en textuel
            when others =>
            Put_Line("Ne peux pas compressier/decompresser ce fichier");
            return;
end TP_Huffman;
