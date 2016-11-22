with Ada.Text_IO, Ada.Unchecked_Deallocation; use Ada.Text_IO;
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with file_priorite; use file_priorite;
package body Huffman is
    
    type Noeud is record
        Val: Element; -- égale null si ce n'est pas une feuille
        Fg, Fd: Arbre;  -- Fils gauche, Fils droit
    end record;

    
    procedure Liberer is new Ada.Uncheck_Deallocation(Noeud,Arbre);
    
    procedure Libere_Arbre(A: in out Arbre) is 
        Tmp: Arbre;
    begin
        while Tmp /= null loop
            Tmp := A;
            A := A.Suiv;
            Liberer(Tmp);
        end loop;
    end Libere_Arbre; 

    
    function Arbre_Vide return Arbre is
    begin
        return null;
    end Arbre_Vide;


    function Creer_Feuille(E: Element ) return Arbre is
    begin
        return new Noeud'(Val => E,
                            Fg => null,
                            Fd => null);
    end Creer_Feuille;


    function Creer_Arbre (A,B: Arbre) return Arbre is 
    begin 
        return new Noeud'(Val => null,
                            Fg => A,
                            Fd => B);
    end Creer_Arbre;


    function Creer_Arbre (F: in File) return Arbre is 
       Tmp1, Tmp2, Tmp : Arbre ;
       P1,P2: Priorite;
    begin
       if F = null then
          raise Erreur_File_Vide;
       else if Longeur_File(F) = 1 then
          Sortir(F,Tmp1);
          return new Cellule'(Val => null, Fg => null, Fd => Tmp1);
       else 
          P1 := F.all.P;
          P2 := F.all.Suiv.all.P;
          Tmp1 := Sortir(F,Tmp1);
          Tmp2 := Sortir(F,Tmp2);
          Tmp := Creer_Arbre(Tmp1,Tmp2);
          if Longeur_File(F) = 2 then
            return Creer_Arbre(Tmp1,Tmp2);
          else 
            Entrer(F,Tmp,P1+P2);
            return Creer_Arbre(F);
          end if;
       end if;
       end if;
    end Creer_Arbre;


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
