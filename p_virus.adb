with p_esiut;
use p_esiut;

package body p_virus is

procedure CreeVectVirus (f : in out p_Piece_IO.file_type; nb : in integer; V : out TV_Virus) is
	-- {f (ouvert) contient des configurations initiales,
	-- toutes les configurations se terminent par la position du virus rouge}
	-- => {initialise le vecteur V avec la partie numM-CM-)ro nb lue dans le fichier}
	a : TR_Piece;
	nbtemp:integer:=1;
	FichVide:Exception;
	estrouge:boolean:=false;
	lire:boolean:=true;
begin
	V:=VIRUSVIDE;
	reset(f,in_file);
	
	while not end_of_file(f) AND nbtemp/=nb loop
		read(f, a);
		if a.piece=rouge then estrouge:=true; end if;
		if a.piece/=rouge AND estrouge=true then
			nbtemp:=nbtemp+1;
			estrouge:=false;
		end if;
	end loop;
	
	if nb=1 then read(f, a); end if;
	
	while not end_of_file(f) and not (a.piece/=rouge AND estrouge=true) loop
		V(a.ligne, a.colonne):=a.piece;
		read(f,a);
		if a.piece=rouge then estrouge:=true; end if;
	end loop;
	
	if end_of_file(f) then V(a.ligne, a.colonne):=a.piece; end if;
	
end CreeVectVirus;

procedure AfficheVectVirus (V : in TV_Virus) is
	-- {} => {Affiche les valeurs du vecteur V}
begin
	for l in 1..7 loop
		for c in Character'Pos('A')..Character'Pos('G') loop
			ecrire(T_piece'image(V(l,Character'Val(c))) & " || ");
		end loop;
		a_la_ligne;
	end loop;
end AfficheVectVirus;

procedure AfficheGrille (V : in TV_Virus) is
	-- {} => {Affiche le vecteur V sous forme de grille comme indique dans le sujet
	-- avec les numeros de lignes et de colonne.
	-- Dans chaque case :	. = case vide
	--						nombre = numero de piece presente dans la case
	--						B = piece blanche fixe
	--						rien = pas une case}
	lire:boolean:=true;
begin
	ecrire_ligne("     A B C D E F G");
	ecrire_ligne("   ┌───────────────┐");
	for l in 1..7 loop
		ecrire(image(l) & " │");
		for c in Character'Pos('A')..Character'Pos('G') loop
		-- RIP : for c:character in 'A'..'G' loop
		-- ">>> iterator is an Ada2012 feature"        (>.<')
			if lire then
				if V(l,Character'Val(c))<Blanc then
					ecrire(image(T_Piece'pos(V(l,Character'Val(c)))));
				elsif V(l,Character'Val(c))=Blanc then
					ecrire(" B");
				else
					ecrire(" ᛫");
				end if;
				lire:=false;
			else
				ecrire("  ");
				lire:=true;
			end if;
			
		end loop;
		ecrire_ligne (" │");
	end loop;
	ecrire_ligne("   └───────────────┘");
end AfficheGrille;

function Gueri (V : in TV_Virus) return Boolean is
-- {} => {resultat = la piece rouge est prete a sortir (coin haut gauche)}
begin
	return V(1,'A')=V(2,'B') AND V(1,'A')=rouge;
end;

function Presente (V : in TV_Virus; NumP : in integer) return Boolean is
	-- {} => {resultat =  la piece de numero NumP appartient a la grille V}
	trouve:boolean:=false;
	l:T_lig:=1;
	c:T_col:='A';
begin
	while not trouve AND not (l=7 AND c='G') loop
		trouve:=T_Piece'pos(V(l,c))=NumP;
		if c='G' then
			c:='A';
			l:=l+1;
		else
			c:=Character'succ(c);
		end if;
	end loop;
	if l=7 AND c='G'then trouve:=T_Piece'pos(V(l,c))=NumP; end if;
	return trouve;
end;

function Possible (V : in TV_Virus; P : in T_Piece; Dir : in T_Direction) return Boolean is
-- {P appartient a la grille V} => {resultat = on peut deplacer P dans la direction Dir}
	possible:boolean:=true;
	l:T_lig:=1;
	c:T_col:='A';
	
	function bordsdemap(V: in TV_virus; L : in T_lig; C: in T_col) return boolean is
	begin
		case Dir is
			when bg =>
				return V(l+1,Character'pred(c))=vide OR V(l+1,Character'pred(c))=P;
			when hg =>
				return V(l-1,Character'pred(c))=vide OR V(l-1,Character'pred(c))=P;
			when bd =>
				return V(l+1,Character'succ(c))=vide OR V(l+1,Character'succ(c))=P;
			when hd =>
				return V(l-1,Character'succ(c))=vide OR V(l-1,Character'succ(c))=P;
		end case;
	exception
		when Constraint_Error => return false;
	end bordsdemap;
	
begin
	while possible AND not (l=7 AND c='G') loop
		if V(l,c)=P then
			possible:=bordsdemap(V,l,c);
		end if;
				
		if c='G' then
			c:='A';
			l:=l+1;
		else
			c:=Character'succ(c);
		end if;
	end loop;
	if V(l,c)=P AND l=7 AND c='G'then possible:=bordsdemap(V,l,c); end if;
	return possible;
end possible;

procedure Deplacement(V : in out TV_Virus; P : in T_Piece; Dir :in T_Direction) is
	-- {on peut déplacer P dans la direction Dir} => {V a été mise a jour suite au déplacement}
	i : integer:=1;
	j : character:='A';
	V_Piece : TV_Virus;
begin
	V_Piece := VIRUSVIDE;
	while j<Character'val(Character'Pos(V'last(2))+1) loop
			
		if V(i, j) = P  then
			if Dir=hd then
				for k in T_lig'range loop
					V_Piece(i-1, Character'succ(j)) := V(i, j);
				end loop;
			elsif	Dir=bd then
				for k in T_lig'range loop
					V_Piece(i+1, Character'succ(j)) := V(i, j);
				end loop;
			elsif	Dir=hg then
				for k in T_lig'range loop
					V_Piece(i-1, Character'pred(j)) := V(i, j);
				end loop;
			elsif Dir=bg then
				for k in T_lig'range loop
					V_Piece(i +1, Character'pred(j)) := V(i, j);
				end loop;
			end if;
		V(i, j) := vide;
		end if;
		i := i +1;
		if i>7 then
			i := 1;
			j := Character'val(Character'Pos(j) +1);
		end if;
	end loop;
	i := 1; j := 'A';
	while j<Character'Val(Character'Pos(V_Piece'last(2))+1) loop
		if V_Piece(i, j) = P then
			V(i, j) := P;
		end if;
		i := i +1;
		if i>7 then
			i := 1;
			j := Character'val(Character'Pos(j) +1);
		end if;
	end loop;
end Deplacement;

procedure CreeVectScore (f : in out p_Score_IO.file_type; niv : in integer; V : out TV_Score) is
	nivtemp:integer:=1;
	lu:integer:=0;
	a:TR_Score;
begin
	V:=(OTHERS=>((OTHERS=>'.'),0,niv));
	reset(f,in_file);
	
	while not end_of_file(f) AND nivtemp/=niv loop
		read(f, a);
		lu:=lu+1;
		if lu=10 then
			lu:=0; nivtemp:=nivtemp+1;
		end if;
	end loop;
	
	while not end_of_file(f) AND lu/=10 loop
		read(f,a);
		lu:=lu+1;
		V(lu):=a;
	end loop;
	
end CreeVectScore;

procedure TriScore(S: in out TV_Score) is
	temp:TR_Score;
	nivtemp:integer:=1;
	i:integer:=1;
begin
	for i in 1..9 loop
		if S(10-i).score<S(11-i).score then
			temp:=S(11-i);
			S(11-i):=S(10-i);
			S(10-i):=temp;
		end if;
	end loop;
end TriScore;

procedure SaveScore(S: in TV_Score; F: in out p_Score_IO.file_type; niv: in integer) is
	FF:p_Score_IO.file_type;
	a:TR_Score;
	b:TV_Score;
begin
	-- Etape 1) : copie de fichier de score actuel dans un nouveau fichier
	reset(F, in_file);
	
	ouverture:
		declare
		begin
			open(FF,out_file,"Scores.tmp");
		exception
		when p_Score_IO.NAME_ERROR =>
			create(FF,out_file,"Scores.tmp");
	end ouverture;

	reset(FF,out_file);

	for i in 1..200 loop
		read(f,a);
		write(ff,a);
	end loop;

	--Etape 2) : Ecriture de tous les scores dans le premier fichier, niveau par niveau
	reset(F, out_file);
	reset(FF,in_file);
	
	for i in 1..20 loop
		if i=niv then
			for j in 1..10 loop
				write(F,S(j));
			end loop;
		else
			CreeVectScore(FF,i,b);
			for j in 1..10 loop
				write(F,b(j));
			end loop;
		end if;
	end loop;
	close(FF);
	
end SaveScore;
end p_virus;

