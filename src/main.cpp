////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////// MATA49 - PROGRAMACAO DE SOFTWARE BASICO ///////////////////////////////////////////////////////
//////////////////////////////////////////////// 	  Danilo de Andrade Peleteiro 		////////////////////////////////////////////////////////
//////////////////////////////////////////////// 		   Dimitri Marinho 				////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////// CODIGO NAO OTIMIZADO REFERENTE À BUSCA DE MENOR CAMINHO EM UM GRAFO ////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include <iostream>

#define DEBUG 0

using namespace std;

int main(){

	int pilares, pontes,i;
	cin >> pilares >> pontes;

	pilares+=2; // aumenta em 2, pois há o primeiro e ultimo pilares

	int tamanho_total;
	tamanho_total=pontes*3; // todas as informacoes serao armazenadas num vetor com tamanho 3x maior que a quantidade de pontes.

	int caminho[tamanho_total];
	int custo[pilares];

	for(i=0;i<tamanho_total;i++)
		cin >> caminho[i];

	for(i=0;i<pilares;i++)
		custo[i]=3000000; // Valor qualquer acima do limite (50*50*100)

	// DEBUG
	if(DEBUG)
	{
		for(i=0;i<tamanho_total;i+=3)
			cout << caminho[i] << " " << caminho[i+1] << " " << caminho[i+2] << endl;
	}

	custo[0]=0; // O custo do primeiro pilar é sempre zero.

	for(int k=0;k<pilares;k++)
	{
		for(i=0;i<tamanho_total;i+=3)
		{


			if(caminho[i]==k)
			{
				// DEBUG
				if(DEBUG){
					for(int j = 0; j < pilares; j++)
						cout << custo[j] << " " << endl;
				}

				if(custo[caminho[i]] + caminho[i+2] < custo[caminho[i+1]])
					custo[caminho[i+1]] = custo[caminho[i]] + caminho[i+2];

				// (Debug)
				if(DEBUG)
					cout << endl;
			}
		}
	}

	// DEBUG
	if(DEBUG){
		for(int j = 0; j < pilares; j++)
			cout << custo[j] << " " << endl;
		cout << endl;
	}

	cout << custo[pilares-1] << endl;

	return 0;
}
