with Ada.Integer_Text.IO,Ada.Text_IO; use Ada.Integer_Text.IO,Ada.Text_IO;
with Ada.Unchecked_Deallocation;

package body code is 
    
    procedure Liberer is new Ada.Unchecked_Deallocation(Cellule,Code);    

    
    function Creer_Code return Code is
    begin
        return null;
    end Creer_Code;
    

    procedure Liberer_Code(C: in out Code) is
        Tmp: Code;
    begin
        while C /= null loop
            Tmp := C;
            C := C.Suiv;
            Liberer(Tmp);  
    end Creer_Code;

    
    function Longeur_Code(C: in Code) return Integer is 
        L: Integer := 0;
        Tmp: Code := C;
    begin
        while Tmp /= null loop
            L := L +1;
            Tmp := Tmp.Suiv;
        end loop;
        return L;
    end Longeur_Code;


    procedure Afficher(C: in Code) is 
        Tmp: Code := C;
    begin
        while Tmp/=null loop
            Put(Tmp.Val);
            Put(" ");
            Tmp := Tmp.Suiv;
        end loop;
        New_Line;
    end Afficher;


    procedure Inserer_Tete(C: in out Code,B: in Bit) is
    begin
        C := new Cellule'(B,C);
    end Inserer_Tete;


    procedure Inserer_Queue(C: in out Code, B: in Bit) is
        Tmp: Code := C;
    begin
        while Tmp /=null loop
            Tmp := Tmp.Suiv;
        end loop;
        Tmp := new Cellule'(B,null);
    end Inserer_Queue;

    
    procedure Inserer_Code_Queue(C: in out Code, D: in Code) is
        Tmp: Code := C;
    begin
        while Tmp /= null loop
            Tmp := Tmp.Suiv;
        end loop;
        Tmp := D;
    end Inserer_Code_Queue;


    procedure Supprimer_Tete(C: in out Code, B: out Bit) is
        Tmp: Code:= C;
    begin
        if C = null then
            raise Erreur_Code_Vide;
        else 
            C := C.Suiv;
            return Tmp.Val;
        end if;
    end Supprimer_Tete; 


    procedure Supprimer_nTete(C: in out Code, n: in Integer, D: out Code) is
        B: Bit;
        Tmp: Code := Creer_Code;
    begin
        if Longeur(C)<n then
            raise Erreur_Code_Court;
        else
            for i in 1..n loop
                Supprimer_Tete(C,B);
                Inserer_Tete(Tmp,B);
            end loop;
        end if;
        D := Tmp;
    end Supprimer_nTete;

    
end Code;
     
