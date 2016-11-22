
with Ada.Text_IO, Ada.Integer_Text_IO,code_binaire; use Ada.Text_IO, Ada.Integer_Text_IO,code_binaire;
with Ada.Unchecked_Deallocation;

package body Dico is
    
    procedure Liberer is new Ada.Unchecked_Deallocation(Cellule, Dictionnaire);


    function Creer_Dictionnaire return Dictionnaire is 
    begin 
        return null;
    end Creer_Dictionnaire;

    
    procedure Liberer_Dictionnaire(D: in out Dictionnaire) is
        Tmp: Dictionnaire;
    begin
        while Tmp /= null loop
            Tmp := D;
            D := D.Suiv;
            Liberer(Tmp);
        end loop;
    end Liberer_Dictionnaire;


    procedure Ajouter(D:in out Dictionnaire; Char:in Character; C:in Code) is
    begin
        D := new Cellule'(Char,C,D);
    end Ajouter;

    function Traduire(D:in Dictionnaire; Char:in Character) return Code is
        Tmp: Dictionnaire := D;
    begin
        while Tmp /= null loop
            if Tmp.Char = Char then 
                return Tmp.C;
            end if;
                Tmp := Tmp.Suiv;
        end loop;
        raise Erreur_Sans_Existe; 
    end Traduire;

      
    function Traduire(D:in Dictionnaire; C: Code) return Character is
        Tmp: Dictionnaire := D;
    begin
        while Tmp /= null loop
            if Compare_Code(Tmp.C,C) then 
                return Tmp.Char;
            end if;
            Tmp := Tmp.Suiv;
        end loop;
        raise Erreur_Sans_Existe; 
    end Traduire; 

   procedure Afficher(D: in Dictionnaire) is 
        Tmp: Dictionnaire := D;
    begin
        while Tmp /= null loop
           Put(Tmp.Char);
           Put(":");
           Afficher(Tmp.C);
           Put("          ");   
           Tmp := Tmp.Suiv;
        end loop;
        New_Line;
    end Afficher; 
end Dico; 
   
     
