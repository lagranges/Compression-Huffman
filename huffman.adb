--huffman.adb
with Ada.Text_IO,Ada.Integer_Text_Io, Ada.Unchecked_Deallocation; use Ada.Text_IO,Ada.Integer_Text_IO;
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO; 
with file_priorite; 
with Code_Binaire, Dico; use Code_Binaire, Dico;

package body Huffman is
    
    type Noeud is record
        Val: Character; -- égale null si ce n'est pas une feuille
        Fg, Fd: Arbre;  -- Fils gauche, Fils droit
    end record;
    
    -- La fonction affichier pour la Priorité 
    procedure Afficher_Integer(I: Integer) is 
    begin
        Put("Afficher Priorite :");
        Put(I,1);
        Put("  ");
    end Afficher_Integer;
    
    -- Utiliser une file priorité avec Donnée comme une arbre et le priorité comme Integer 
    package File_priorite_Character is new File_priorite(Arbre, Integer,Afficher,Afficher_Integer,"<","+");
    use File_priorite_Character;

    procedure Liberer is new Ada.Unchecked_Deallocation(Noeud,Arbre);
   
    -- Liberer une arbre 
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

    -- Ce fonction Creer une feille contenant le Caractere E
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
            if A.Fd = null and A.Fg = null then Put(A.Val); Put("|");
            end if;
            Afficher_Tmp(A.Fg);
            Afficher_Tmp(A.Fd);
        end Afficher_Tmp;

    begin
        Put("Afficher Arbre: ");
        Afficher_Tmp(A);
        New_Line;
    end Afficher;


    -- Contruire une Arbre à partir d'un File priorité.
    function Creer_Arbre (Fi: in File) return Arbre is 
       Tmp1, Tmp2, Tmp : Arbre ;
       P1,P2: Integer;
       F : File := Fi;

    begin
       if Longeur_File(Fi) = 0 then
          return Arbre_Vide;
       end if;
       if Longeur_File(Fi) = 1 then
          Sortir(F,Tmp1,P1);
          return  Tmp1;
       end if; 
       -- retirer deux éléments les plus prioritaires de la file
       Sortir(F,Tmp1,P1);
       Sortir(F,Tmp2,P2);
       Tmp := Creer_Arbre(Tmp2,Tmp1);
       if Longeur_File(Fi) = 2 then
          return Creer_Arbre(Tmp2,Tmp1);
       end if; 
       -- ajouter une arbre avec le priorité comme P1 + P2
       Entrer(F,Tmp,P1+P2);
       return Creer_Arbre(F);
    end Creer_Arbre;

    -- Contruire un arbre d'une fichier textuel et renvoyer aussi la tab_character
    procedure Creer_Arbre(A: out Arbre; Nom_Fichier : in String;
                         Tab: out Tableau_Character ) is
 
        procedure Creer_File(F:out File; Nom_Fichier: in String; 
                            Tab: out Tableau_Character) is 
           
            Fichier : Ada.Streams.Stream_IO.File_Type;
            Flux : Ada.Streams.Stream_IO.Stream_Access;
            C : Character;
        begin

            Tab := (others => 0);
            F := Creer_File ;
            -- Overture d'un fichier texte
            Open(Fichier, In_File, Nom_Fichier);
         
            Flux := Stream(Fichier);
            
            -- Lecture de caractère
            while not End_Of_File(Fichier) loop
                Character'Read(Flux,C);
                Tab(C) := Tab(C)+1;
            end loop;

            -- Creer File_priorite à partir de Tab
            for I in Tab'Range loop
                if Tab(I)/=0 
                then
                    Entrer(F, Creer_Feuille(I), Tab(I));
                end if;
            end loop; 

            Close(Fichier);
            New_Line;
            -- Creer Arbre à partir de File_priorite F
        end Creer_File;
       
        F: File;
    begin    
        Creer_File(F,Nom_Fichier,Tab);
        -- Creer Arbre à partir de File_priorite F
        A:= Creer_Arbre(F);
    end Creer_Arbre;
    
    -- Creer une dictionnaire à partir une arbre
    function Creer_Dictionnaire (A : Arbre ) return Dictionnaire is
         D : Dictionnaire := Creer_Dictionnaire;
         C : Code := Creer_Code;    
    begin
         if A = null then return D; end if;
         -- Si Arbre Courante (A) n'est pas une feuille on l'ajouter à la dictionnaire
         if A.Val /= Character'Val(16#00#) then
                Ajouter(D,A.Val,C);
                return D;
         end if; 
         -- On combiner les deux dictionnaire ( une de grache et l'autre de droite)
         return Ajouter(Ajouter(Creer_Dictionnaire(A.Fg),0),
                       Ajouter(Creer_Dictionnaire(A.Fd),1));
    end Creer_Dictionnaire; 

    procedure Creer_Dictionnaire_Text (D: out Dictionnaire; Nom_Fichier: in String;
                                 Tab:out Tableau_Character) is 
        Tmp: Arbre ;
    begin
        Creer_Arbre(Tmp,Nom_Fichier,Tab);
        D := Creer_Dictionnaire(Tmp);
    end Creer_Dictionnaire_Text;   

    -- Créer une arbre à partir d'une fichier Binaire
    procedure Creer_Dictionnaire_Binaire(D: out Dictionnaire;
        Flux_Tmp : in out Ada.Streams.Stream_IO.Stream_Access
)  is
            
        C : Character ;
        I : Integer;
        F : File := Creer_File;
        Tab : Tableau_Character := (others => 0);
    begin
        -- D'abord, on lire le nb_occurence d'une caractere
        Integer'Read(Flux_Tmp , I );
        -- on fini si le valeur que on lit égale 0
        while I /= 0  loop
            -- on lire le caractere correspondant 
            Character'Read(Flux_Tmp,C);
            Tab(C):= I;
            -- on continue 
            Integer'Read(Flux_Tmp, I);
        end loop;
        -- Creer File_priorite à partir de Tab
        for J in Tab'Range loop
            if Tab(J)/=0 
            then
                -- Si le caractere exist dans le fichier on l'ajouter à file priorité
                Entrer(F, Creer_Feuille(J), Tab(J));
            end if;
        end loop; 
        D := Creer_Dictionnaire(Creer_Arbre(F));
    end Creer_Dictionnaire_Binaire;

end Huffman;
