
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
                return Creer_Code(Tmp.C);
            end if;
                Tmp := Tmp.Suiv;
        end loop;
        return Creer_Code; 
    end Traduire;

      
    function Traduire(D: in Dictionnaire; C:in Code) return Character is
        Tmp: Dictionnaire := D;
    begin
        while Tmp /= null loop
            if Compare_Code(Tmp.C,C) then
                return Tmp.Char;
            end if;
            Tmp := Tmp.Suiv;
        end loop;
        return Character'Val(16#00#); 
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

    function Ajouter(D: in Dictionnaire; B: Bit) return Dictionnaire is 
        Tmp1: Dictionnaire:= D;
        Tmp : Dictionnaire:= Tmp1;
    begin
        while Tmp /= null loop
            Inserer_Tete(Tmp.C,B);
            Tmp := Tmp.Suiv;
        end loop;
        return Tmp1;
    end Ajouter;

    function Ajouter(D: in Dictionnaire; E: in Dictionnaire) return Dictionnaire is
        Tmp: Dictionnaire := D;
        F: Dictionnaire := Creer_Dictionnaire ;
    begin
        while Tmp /= null loop
            Ajouter(F, Tmp.Char, Tmp.C);
            Tmp := Tmp.Suiv;
        end loop;
        Tmp := E;
        while Tmp /= null loop
            Ajouter(F, Tmp.Char, Tmp.C);
            Tmp := Tmp.Suiv;
        end loop;
        return F; 
    end Ajouter; 


end Dico;  
   
     
