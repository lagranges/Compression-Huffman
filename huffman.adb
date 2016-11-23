with Ada.Text_IO,Ada.Integer_Text_Io, Ada.Unchecked_Deallocation; use Ada.Text_IO,Ada.Integer_Text_IO;
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO; 
with file_priorite; 
with Code_Binaire, Dico; use Code_Binaire, Dico;

package body Huffman is
    
    type Noeud is record
        Val: Character; -- égale null si ce n'est pas une feuille
        Fg, Fd: Arbre;  -- Fils gauche, Fils droit
    end record;
    
    procedure Afficher_Integer(I: Integer) is 
    begin
        Put("Afficher Priorite :");
        Put(I,1);
        Put("  ");
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


    function Creer_Feuille(E: Character ) return Arbre is
    begin
        return new Noeud'(Val => E,
                            Fg => null,
                            Fd => null);
    end Creer_Feuille;


    function Creer_Arbre (A,B: in Arbre) return Arbre is 
    begin 
        return new Noeud'(Val => Character'Val(16#00#),
                            Fg => A,
                            Fd => B);
    end Creer_Arbre;


    procedure Afficher (A: Arbre) is
             
        -- Afficher la suite des feuille, cette procedure sert à la procedure Afficher
        procedure Afficher_Tmp(A: Arbre) is 
        begin
            if A = null then return; 
            end if; 
            if A.Fd = null and A.Fg = null then Put(A.Val); Put("  ");
            else
            Afficher_Tmp(A.Fg);
            Afficher_Tmp(A.Fd);
        end if;
        end Afficher_Tmp;

    begin
        Put("Afficher Arbre: ");
        Afficher_Tmp(A);
        New_Line;
    end Afficher;

    function Creer_Arbre (Fi: in File) return Arbre is 
       Tmp1, Tmp2, Tmp : Arbre ;
       P1,P2: Integer;
       F : File := Fi;

    begin
       if Longeur_File(Fi) = 0 then
          raise Erreur_File_Vide;
       else if Longeur_File(Fi) = 1 then
          Sortir(F,Tmp1,P1);
          return  new Noeud'(Character'Val(16#00#), Fg => null, Fd => Tmp1);
       else 
          Sortir(F,Tmp1,P1);
          Sortir(F,Tmp2,P2);
          Tmp := Creer_Arbre(Tmp1,Tmp2);
          if Longeur_File(Fi) = 2 then
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

        F := Creer_File ;
        -- Overture d'un fichier texte
        begin
            Open(Fichier, In_File, Nom_Fichier);
        exception 
            when others =>
            Put("Erreur en lecture: ");  Put(Nom_Fichier); Put_Line(" n'exist pas"); 
            return null;
        end;
     
        Flux := Stream(Fichier);
        
        -- Lecture de caractère
        while not End_Of_File(Fichier) loop
            C := Character'Input(Flux);
            Tab(C) := Tab(C)+1;
        end loop;

        -- Creer File_priorite à partir de Tab
        for I in Tab'Range loop
            if Tab(I)/=0 
            then
                Entrer(F, Creer_Feuille(I), Tab(I));
            end if;
        end loop; 
        Afficher(F);
        Close(Fichier);
        -- Creer Arbre à partir de File_priorite F
        return Creer_Arbre(F);
    end Creer_Arbre;




    function Creer_Dictionnaire_Text (A : Arbre ) return Dictionnaire is
        D : Dictionnaire := Creer_Dictionnaire;
        C : Code := Creer_Code;    
    begin
        if A = null then return D; end if;
        if A.Val /= Character'Val(16#00#) then
            Ajouter(D,A.Val,C);
            return D;
        end if; 
        return Ajouter(Ajouter(Creer_Dictionnaire_Text(A.Fg),0),
                       Ajouter(Creer_Dictionnaire_Text(A.Fd),1));
    end Creer_Dictionnaire_Text;   




    function Creer_Dictionnaire_Text (Nom_Fichier: String ) return Dictionnaire is
    begin
        return Creer_Dictionnaire_Text(Creer_Arbre(Nom_Fichier));
    end Creer_Dictionnaire_Text;    
end Huffman;
