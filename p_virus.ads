with sequential_IO; with p_esiut; use p_esiut;

package p_virus is

--------------- Types pour representer les pieces et la grille de jeu

	subtype T_Col is character range 'A'..'G';
	subtype T_Lig is integer range 1..7;
	type T_Piece is (rouge, turquoise, orange, rose, marron, bleu, violet, vert, jaune, blanc, vide);

	type TR_Piece is record
		colonne	:	T_Col;
		ligne	:	T_Lig;
		piece	:	T_Piece range rouge..blanc;
	end record;
	
	type TR_Score is record
		Nom:	string(1..15);
		Score:	natural;
		Niveau: integer range 1..20;
	end record;
	
	type TV_Score is array (integer range 1..10) of TR_Score; 
	
	---- Instanciation de sequential_IO pour le fichier de description de la grille
	package p_Piece_IO is new sequential_IO (TR_Piece); use p_Piece_IO;
	
	---- Instanciation de sequential_IO pour le fichier de score
	package p_Score_IO is new sequential_IO (TR_Score); use p_Score_IO;

	---- type pour le vecteur representant la grille
	type TV_Virus is array (T_lig,T_col) of T_Piece;

	---- type pour la direction des deplacements des pieces
	type T_Direction is (bg, hg, bd, hd);
	package p_Direction_IO is new p_enum(T_Direction); 

	VIRUSVIDE : CONSTANT TV_Virus := ( OTHERS=>(OTHERS=>vide));
	
--------------- Creation et Affichage de la grille

procedure CreeVectVirus (f : in out p_Piece_IO.file_type; nb : in integer; V :out TV_Virus);
-- {f (ouvert) contient des configurations initiales,
-- toutes les configurations se terminent par la position du virus rouge}
-- => {initialise le vecteur V avec la partie numero nb lue dans le fichier}

procedure AfficheVectVirus (V : in TV_Virus);
-- {} => {Affiche les valeurs du vecteur V}

procedure AfficheGrille (V : in TV_Virus);
-- {} => {Affiche le vecteur V sous forme de grille comme indique dans le sujet
-- avec les numeros de lignes et de colonne.
-- Dans chaque case : 	. = case vide
--			nombre = numero de piece presente dans la case
--			B = piece blanche fixe
-- 			rien = pas une case}

--------------- Fonctions et procedures pour le jeu

function Gueri (V : in TV_Virus) return Boolean;
-- {} => {resultat = la piece rouge est prete a sortir (coin haut gauche)}

function Presente (V : in TV_Virus; NumP : in integer) return Boolean;
-- {} => {resultat =  la piece de numero NumP appartient a la grille V}

function Possible (V : in TV_Virus; P : in T_Piece; Dir : in T_Direction) return Boolean;
-- {P appartient a la grille V} => {resultat = on peut deplacer P dans la direction Dir}


procedure Deplacement(V : in out TV_Virus; P : in T_Piece; Dir :in T_Direction);
-- {on peut deplacer P dans la direction Dir} => {V a etemise a jour suite au deplacement}

procedure CreeVectScore (f : in out p_Score_IO.file_type; niv : in integer; V : out TV_Score);

procedure TriScore(S: in out TV_Score);

procedure SaveScore(S: in TV_Score; F: in out p_Score_IO.file_type; niv: in integer);

--------------- A rajouter dans l'ads pour la partie graphique
--function CaseGrille (i : in T_lig; j : in T_col) return boolean;
-- {} => {resultat = les indices (i,j) correspondent a une case du jeu}

end p_virus;

