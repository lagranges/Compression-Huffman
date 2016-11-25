with Ada.Integer_Text_IO,Ada.Text_IO; use Ada.Integer_Text_IO,Ada.Text_IO;
with Ada.Unchecked_Deallocation;
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
package body Code_Binaire is 
    
    procedure Liberer is new Ada.Unchecked_Deallocation(Cellule,Code);    

    
    function Creer_Code return Code is
    begin
        return null;
    end Creer_Code;
    
    function Creer_Code(C : in Code) return Code is
        Tmp1: Code := Creer_Code;
        Tmp: Code := C;
    begin
        while Tmp /= null loop
            Inserer_Queue(Tmp1, Tmp.Val);
            Tmp := Tmp.Suiv;
        end loop;
        return Tmp1;
    end Creer_Code;

    procedure Liberer_Code(C: in out Code) is
        Tmp: Code;
    begin
        while C /= null loop
            Tmp := C;
            C := C.Suiv;
            Liberer(Tmp); 
        end loop; 
    end Liberer_Code;

    
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
            Put(Tmp.Val,3);
            Tmp := Tmp.Suiv;
        end loop;
        New_Line;
    end Afficher;


    procedure Inserer_Tete(C: in out Code; B: in Bit) is
    begin
        C := new Cellule'(B,C);
    end Inserer_Tete;


    procedure Inserer_Queue(C: in out Code; B: in Bit) is
        Tmp: Code := C;
    begin
        if C = null then 
            C:= new Cellule'(B,null);
        else 
            while Tmp.Suiv /=null loop
                Tmp := Tmp.Suiv;
                end loop;
            Tmp.Suiv := new Cellule'(B,null);
        end if;
    end Inserer_Queue;

    
    procedure Inserer_Code_Queue(C: in out Code; D: in Code) is
        Tmp: Code := C;
    begin
        if C = null then C := Creer_Code(D);
        else
            while Tmp.Suiv /= null loop
                Tmp := Tmp.Suiv;
            end loop;
            Tmp.Suiv := Creer_Code(D);
        end if;
    end Inserer_Code_Queue;


    procedure Supprimer_Tete(C: in out Code; B: out Bit) is
        Tmp: Code:= C;
    begin
        if C = null then
            raise Erreur_Code_Vide;
        else 
            C := C.Suiv;
            B := Tmp.Val;
        end if;
    end Supprimer_Tete; 


    procedure Supprimer_nTete(C: in out Code; n: in Integer; D: out Code) is
        B: Bit;
    begin
        D := Creer_Code;
        if Longeur_Code(C)<n then return; end if;
        for i in 1..n loop
                Supprimer_Tete(C,B);
                Inserer_Queue(D,B);
        end loop;
    end Supprimer_nTete;

   function Compare_Code(C: in Code; D: in Code) return boolean is 
   begin
       if C = null and D = null then return true; end if;
       if C = null and D /= null then return false; end if;
       if C /= null and D = null then return false; end if;
       if C.Val = D.Val then return (Compare_Code(C.Suiv,D.Suiv));
        else return false; end if;
   end ;

    function Convertir_En_Octet(C: in Code) return Octet is
        Tmp : Code := C;
        O: Octet := 0;
    begin
        for i in Integer range 0..7 loop
            O := O + Octet(Tmp.Val*(2**(7-i)));
            Tmp := Tmp.Suiv;
        end loop;
        return O; 
    end;

    function Convertir_En_Code(O: in Octet) return Code is
        Tmp : Integer := Integer(O);
        C : Code := Creer_Code;
    begin
        for i in Integer range 0..7 loop
            Inserer_Tete(C,Bit(Integer(Tmp-Integer(Tmp/2)*2)));
            Tmp := Integer(Tmp/2);
        end loop;
        return C; 
    end Convertir_En_Code;

    procedure Inserer_Octet_Queue(C: in out Code; O: in Octet) is
    begin
        Inserer_Code_Queue(C,Convertir_En_Code(O));
    end Inserer_Octet_Queue;    

    procedure Ecrire_Binaire(C: in out Code; Flux : in out Stream_Access) is
       Tmp : Code := Creer_Code;
    begin
       while Longeur_Code(C)>=8 loop
        Supprimer_nTete(C,8,Tmp);
        Octet'Write(Flux,Convertir_En_Octet(Tmp));
       end loop;
       return;
    end Ecrire_Binaire; 
   
end Code_Binaire;
     
