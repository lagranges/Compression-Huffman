with Ada.Text_IO, Ada.Integer_Text_IO, Code_Binaire, Dico;
use  Ada.Text_IO, Ada.Integer_Text_IO, Code_Binaire, Dico;

procedure Test_Dico is
    D: Dictionnaire;
    Char: Character;
    C,C1: Code;
    B: Bit;
begin
    D := Creer_Dictionnaire;
    Put("D : ");
    Afficher(D);

    C := Creer_Code;
    Inserer_Queue(C,1);
    Inserer_Queue(C,0);
    Inserer_Queue(C,0);
    Inserer_Queue(C,1);
    Inserer_Queue(C,0);

    Ajouter(D,'a',C);
    Put("D : ");
    Afficher(D);
    
    Char := 'b';
    begin
        C := Traduire(D,Char);
    exception
            when Erreur_Sans_Existe =>
                Put("Ne trouve pas le caractere c dans le Dictionnaire");
                New_Line;
    end;

    C := Creer_Code;
    Inserer_Tete(C,0);
    Inserer_Tete(C,0);
    Inserer_Tete(C,0);
    Inserer_Tete(C,0);
    Inserer_Tete(C,0);
    Inserer_Tete(C,0);

    C1 := Creer_Code;
    
    Inserer_Tete(C1,0);
    Inserer_Tete(C1,0);
    Inserer_Tete(C1,0);
    Inserer_Tete(C1,0);
    Inserer_Tete(C1,0);
    Supprimer_Tete(C1,B);
    Inserer_Tete(C1,0);
    Inserer_Queue(C1,0);

    Ajouter(D,Char,C);
    Put("D : ");
    Afficher(D);

    Char := Traduire(D,C);
    Put("Traduire 000000 :");
    Put(Char);
    New_Line;

    Char := Traduire(D,C1);
    Put("Traduire 000000 :");
    Put(Char);
    New_Line;

    C := Traduire(D,'a');
    Put("Traduire 'a':");
    Afficher(C);    
end Test_Dico;


