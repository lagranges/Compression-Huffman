with Ada.Text_IO,Ada.Integer_Text_Io, Ada.Unchecked_Deallocation; use Ada.Text_IO,Ada.Integer_Text_IO;
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO; 
with file_priorite; 

package body Huffman is
    
    type Noeud is record
        Val: Element; -- égale null si ce n'est pas une feuille
        Fg, Fd: Arbre;  -- Fils gauche, Fils droit
    end record;
    
    procedure Afficher_Integer(I: Integer) is 
    begin
        Put(I,1);
    end Afficher_Integer;

    package File_priorite_Character is new File_priorite(Arbre, Integer,Afficher,Afficher_Integer,"<","+");
    use File_priorite_Character;

    procedure Liberer is new Ada.Unchecked_Deallocation(Noeud,Arbre);
    
    procedure Liberer_Arbre(A: in out Arbre) is 
        Tmp1: Arbre;
        Tmp2: Arbre;
    begin
            Tmp1 := A.Fd;
            Tmp2 := A.Fg;
            Liberer(A);
            if Tmp1 /= null then
                Liberer(Tmp1);
            end if;
            if Tmp2 /= null then
                Liberer(Tmp2);
            end if; 
    end Liberer_Arbre; 

    
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
        return new Noeud'(Val => Element_Null,
                            Fg => A,
                            Fd => B);
    end Creer_Arbre;

    procedure Afficher (A: Arbre) is 
    begin
        if A = null then return; 
        end if; 
        if A.Fd = null and A.Fg = null then Afficher(A.Val); 
        else
           Afficher(A.Fg);
           Afficher(A.Fd);
        end if;
    end Afficher;
    

    procedure Creer_Arbre (F: in out File;A : out Arbre) is 
       Tmp1, Tmp2, Tmp : Arbre ;
       P1,P2: Integer;
    begin
       if Longeur_File(F) = 0 then
          raise Erreur_File_Vide;
       else if Longeur_File(F) = 1 then
          Sortir(F,Tmp1,P1);
          A :=  new Noeud'(Val => Element_Null, Fg => null, Fd => Tmp1);
          return;
       else 
          Sortir(F,Tmp1,P1);
          Sortir(F,Tmp2,P2);
          Tmp := Creer_Arbre(Tmp1,Tmp2);
          if Longeur_File(F) = 2 then
             A := Creer_Arbre(Tmp1,Tmp2);
             return;
          else 
            Entrer(F,Tmp,P1+P2);
            Creer_Arbre(F,A);
          end if;
       end if;
       end if;
    end Creer_Arbre;


--    function Creer_Arbre(Nom_Fichier : String) return Arbre is 
--       
--        type Tableau_Character is array(Character range <>) of Integer;
--        Fichier : Ada.Streams.Stream_IO.File_Type;
--        Flux : Ada.Streams.Stream_IO.Stream_Access;
--        C : Character;
--        F : File;
--        Tab : Tableau_Character(Character'First..Character'Last) := (others => 0);
--   
--    begin
--
--        F := Creer_File ;
--        -- Overture d'un fichier texte
--        begin
--            Open(Fichier, In_File, Nom_Fichier);
--        exception 
--            when others =>
--            Put("Erreur en lecture: ");  Put(Nom_Fichier); Put_Line(" n'exist pas"); 
--            return null;
--        end;
--     
--        Flux := Stream(Fichier);
--        
--        -- Lecture de caractère
--        while not End_Of_File(Fichier) loop
--            C := Character'Input(Flux);
--            Tab(C) := Tab(C)+1;
--        end loop;
--
--        -- Creer File_priorite à partir de Tab
--        for I in Tab'Range loop
--            if Tab(I)/=0 
--            then
--                Entrer(F, Creer_Feuille(I), Tab(I));
--            end if;
--        end loop; 
--
--        -- Creer Arbre à partir de File_priorite F
--        Creer_Arbre(F);
--
--    end Creer_Arbre;

end Huffman;
