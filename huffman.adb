with Ada.Text_IO, Ada.Unchecked_Deallocation; use Ada.Text_IO;
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package body Huffman is
    
    type Noeud is record
        Val: Element; -- égale null si ce n'est pas une feuille
        Fd, Fg: Arbre;  -- Fils gauche, Fils droit
    end record;

    
    procedure Libere_Noeud is new Ada.Uncheck_Deallocation(Noeud,Arbre);

    function Creer_Feuille(E: Element ) return Arbre is
    begin
        return new Noeud'(Val => E,
                            Fg => null,
                            Fd => null);
    end Creer_Feuille;


    function Creer_Arbre(Nom_Fichier : String) return Arbre is 
       
        type Tableau_Character is array(Character range <>) of Integer;
        Fichier : Ada.Streams.Stream_IO.File_Type;
        Flux : Ada.Streams.Stream_IO.Stream_Access;
        C : Character;
        F : File;
        Tab : Tableau_Character(Character'First..Character'Last) := (others => 0);
   
    begin

        F := CreeFile ;
        -- Overture d'un fichier texte
        begin
            Open(Fichier, In_File, Nom_Fichier);
        exception 
            when others =>
            Put("Erreur en lecture: ");  Put(Nom_Fichier); Put_Line(" n'exist pas"); 
            return;
        end;
     
        Flux := Stream(Fichier);
        
        -- Lecture de caractère
        while not End_Of_File(Fichier) loop
            C := Character'Input(Flux);
            Tab(C) := Tab(C)+1;
        end loop;

        -- Creer File_priorite à partir de Tab
        for I in Tab'Range loop
            if not Tab(I)=0 
            then
                Entrer(F, Creer_Feuille(I), Tab(I));
            end if;
        end loop; 

        -- Creer Arbre à partir de File_priorite F
        Creer_Arbre(F);

    end Creer_Arbre;

end Huffman;
