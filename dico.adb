with Ada.Text_IO, code;
use Ada.Text_IO, code; 
with Ada.Unchecked_Deallocation;

package body Dico is
    
    procedure Liberer is new Ada.Uncheked_Deallocation.Liberer(Cellule, Dictionnaire);


    function Creer_Dictionnaire is 
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

    procedure Traduire(D:in Dictionnaire; Char:in Character) returnCode is
        Tmp: Dictionnaire := D;
    begin
        while Tmp /= null loop
            if Tmp.Char = Char then 
                return Tmp.C;
            end if;
        end loop;
        raise Errer_Sans_Existe; 
    end Traduire;

      
    procedure Traduire(D:in Dictionnaire; Char:in Character) returnCode is
        Tmp: Dictionnaire := D;
    begin
        while Tmp /= null loop
            if Tmp.Char = Char then 
                return Tmp.C;
            end if;
        end loop;
        raise Errer_Sans_Existe; 
    end Traduire; 

     
end Dico; 
   
     
