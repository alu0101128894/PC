#include <stdio.h>
#include <string.h>

int main(){

    int i,j = 0;
    char longitud;
    char cadena[50];
    char temporal;

    printf("Introduce un texto (menos de 50 caracteres): ");
    gets(cadena);
    longitud = strlen(cadena);


    
    for (i=0,j=longitud-1; i<longitud/2; i++,j--)
    {
        temporal = cadena[i];
        cadena[i] = cadena[j];
        cadena[j] = temporal;
    }
    printf("Resultado: %s\n", cadena);


    // int k = 0;
    // if(longitud <= 1){
    //     printf("Es palindroma");
    // }
    // int aux = longitud -1;
    // while(cadena[k] == cadena[aux]){
    //     if( k >= (aux)){
    //         printf("Es palindroma");
    //         k++;
    //      aux++;
    //     }

    //     else{
    //     printf("No es palindroma");
    //     }
    // }
   

}