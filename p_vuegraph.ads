with p_virus, p_fenbase;
use p_virus, p_fenbase;

package p_vuegraph is

procedure ActuLvl (F: in out TR_Fenetre; niv: in integer);

procedure CreerFenMenu (F: in out TR_Fenetre);
--{interface graphique initialisée}=>{fenêtre de menu créée}

function Couleur (V : in TV_Virus; l,c : in integer) return T_couleur;
--{V rempli, 1<=l<=7, 0<=c<=6}=>{retourne la couleur de la case V(l,c)}

procedure CreerFenGrille (F: in out TR_Fenetre; niveau, nbcoups, nberreur : in integer);
--{interface graphique initialisée}=>{fenêtre de jeu principale créée}

procedure Actualiser (F: in out TR_Fenetre; V : in TV_Virus; niveau, nbcoups, nberreur : in integer);
--{Fenêtre déjà créée avec CreerFenGrille}=>{Fenêtre mise à jour avec le nouveau V}

procedure SelectionnerPiece(F : in out TR_Fenetre; V: in TV_Virus; P: in T_Piece);
--{Fenêtre déjà créée avec CreerFenGrille}=>{Fenêtre mise à jour avec la pièce en subrillance}

procedure CreerFenScore (F: in out TR_Fenetre);
--{interface graphique initialisée}=>{fenêtre de score créée}

function EntrerNom return string;
--{}=>{Renvoie un pseudo de 15 caractères}

procedure CreerFenRegle (F : in out TR_Fenetre);
--{interface graphique initialisée}=>{Fenêtre expliquant les règles créée}

end p_vuegraph;
