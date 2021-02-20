#!/bin/bash
#Buscaminascum 2020. 
#Autor Ricardo Meza Díaz


#--------------------------------VARIABLES GLOBALES---------------------#

#Contador de puntos
puntos=0
 #Celdas aleatorias 
a="1 10 -10 -1"
b="-1 0 1"
c="0 1"
d="-1 0 1 -2 -3"
e="1 2 20 21 10 0 -10 -20 -23 -2 -1"
f="1 2 3 35 30 20 22 10 0 -10 -20 -25 -30 -35 -3 -2 -1"
g="1 4 6 9 10 15 20 25 30 -30 -24 -11 -10 -9 -8 -7"

#Definicion de la matriz Variable celda almacena el valor de cada celda
#Esta matriz mas abajo tendrá 100 valores contando del 0 al 99.
declare -a matriz

#--------------------------------VARIABLES GLOBALES---------------------#

#Muestra mensaje cuando, se lleva tiempo sin ingresar por teclado. 
function tiempoEspera(){

{
  printf '\n\n%s\n\n' "Mucho tiempo de espera!!"
  exit 1
}
}

#----------------------------------FUNCIONES-------------------------------


#----------------------------------MENUS-----------------------------------

#Primer esquema de menú que aparece al ejecutar el juego.

function menuPrincipal(){
	echo "_________________________________________________________________"
	echo "|----------------BIENVENIDO AL BUSCAMINACUM 2020----------------|"
	echo "|---------------------------------------------------------------|"
	echo "|-------------------------Menú----------------------------------|"
	echo "|.......................1.JUGAR.................................|"
	echo "|.......................2.Ayuda.................................|"
	echo "|.......................3.Salir.................................|"
	echo "|_______________________________________________________________|"
  
  echo -e "\n"
	echo "Pulse 1,2 o 3:"
}

#Menu para elegir nivel despues de haber escogido opción 1. JUGAR.

function menuNivel(){
	
  echo "_________________________________________________________________"
	echo "|---------------BIENVENIDO AL BUSCAMINACUM 2020-----------------|"
	echo "|---------------------------------------------------------------|"
	echo "|------------------------------NIVEL----------------------------|"
  echo "|                                                               |"
	echo "|...............1. Nivel 1: 10X10 Casillas 20 Minas ............|"
	echo "|...............2. Volver.......................................|"
	echo "|...............3. Salir........................................|"
	echo "|_______________________________________________________________|"
	
  echo -e '\n'
  echo "Pulse 1,2 o 3:"

}

#Funcionalidad que permite salir del juego, cuando se muestre la op en el menú.
function salir(){
  echo "Se ha salido el juego."
  exit 0
}

#Permite al jugador volver a jugar si quiere.
volverAJugar() {
  
  echo -e '\n'
  echo "Desea volver a jugar (Ss/Nn)? "

  read var3

  until [ $var3 -eq 5 ]              #Controla opcion por teclado.
  
  do 
    case $var3 in
        S)
            #volverAtras  
            source ./buscaminascum.sh           #Llama a menu de seleccion de nivel.
            ;;
        s)  
            #volverAtras             #Llama a menu de seleccion de nivel, para volver a jugar.
            source ./buscaminascum.sh 
            ;;
        #Cuando se pulsa N o n, se sale del juego.
        N)
            salir                  
            ;;
        n)
            salir
            ;;
        #Cuando no se pulsa ni S,s,n o N.
        *)  echo "No ha introducido ninguna opcion correcta."
          ;;
      esac

      read var3

    done 

}


#Menú que permite al usuario retroceder al menú anterior.

function volverAtras(){
	
  menuNivel
                            #Llamada menu de seleccionar nivel.
	read var1 

	until [ $var1 -eq 4 ]               #Control opciones por teclado del menu nivel.
	do 
 		case $var1 in
     		
        1)
       			
            echo "¡EMPIEZA EL JUEGO!"  
            echo -e "n"
            trap tiempoEspera INT

            creaTablero               #Crea tablero a partir de ahí permite jugar, llamando a otras funciones.         

           
          
            #Permite al usuario ingresar la fila y la columna a la vez tantas veces hasta que pierda o gane la partida.
            #Si quiere ingresar fila 2 columna h, la sintaxis correspondiente es: 
            # h2 
            #Primero columna y luego fila, sin espacio, en ese orden y en minúsculas.
            echo "Ejemplo columna h , fila 2, introduzca: h2"
            echo -e "\n"

            #Bucle que itera cada vez que el jugador deba introducir coordenada.
            while true; do 
              read -p "Introduzca una coordenada: " opcion

              #Busca en el tablero las coordenas ingresadas por el usuario anteriormente.
              #Si son validas o no.
              obtenerCoordenadas  
            done

          ;;

     		2) 
      			echo -e "\n"
            echo "Usted ha vuelto al menu anterior."
            echo -e "\n"

      			menuUntil                                  #Menu anterior al elegir nivel.                               
     			  
            ;;

    		3)
        		#Sale del juego
            salir
        		
            ;;

    		*)
       			echo "Ha introducido un numero incorrecto."
     			  ;;

  		esac

  		read var1 

  	done
}

#Menu until. Menu principal que le da funcionalidad al esquema del primer menu del juego.
#También, controla las opciones introducidas por teclado.

function menuUntil(){
	
  menuPrincipal    
                    #Primer menu que aparece al iniciar el programa.
	read var2
	
	until [ $var2 -eq 4 ]                  #Control opciones por teclado del menu principal.
	do 

 		case $var2 in
     		1)
       			echo -e "\n"
        		volverAtras                 #Menu anterior
          ;;
     		
        2)
      			echo -e "\n"
            cat Readme.txt              #Muestra ayuda desde ese fichero.
            echo -e "\n"
            menuUntil                   #Menu de vuevo para jugar.
     			
          ;;
    		
        3)  
        		salir                       #Permite salir del programa.
        		
            ;;
    		*)  
           
            echo -e  "\n"
       			echo "Ha introducido un numero incorrecto."
     			
          ;;
  		
      esac
  		
      read var2 
  	done
  	
}



#----------------------------------FIN MENUS--------------------------


#-------------------------------FUNCIONES TABLERO---------------------


#Pinta matriz, tablero de 10x10. 
function creaTablero(){


  contador=0                  #Cuenta la cantidad filas que ya se han rellenado.

  #Encabezado de columnas con espaciado.
  #Columnas tienen letras, filas tendrán número.
  printf '\n\n'
  printf '%s' "      a   b   c   d   e  f  g   h   i   j"
  printf '\n    %s\n' "----------------------------------------"

  #Nota: primero se imprimen las columnas, y despues se van imprimiendo las filas.

  #Imprime filas del 0 al 9.volverAJugar  10 filas con comando seq para ir incrementando.
  for fil in $(seq 0 9); do 
    printf '%d ' "$fil"                   #Imprime fila del 0 al 9.

    #Dentro de cada fila insertamos columnas, tambien del 0 al 9.
    #Despues de este for se crean las casillas completas del tablero.

    #imprime columnas en base a filas
    for col in $(seq 0 9); do

      ((contador+=1))               #Incrementa en una unidad el avance de columnas.

      #Funcion que verifica si la celda está vacía, para luego añadirle un "." 
      #a la casilla vacía.
      creaCeldaVacia $contador      

      #Separador | que separara cada casilla verticalmente.
      printf '%s \e[33m%s\e[0m ' "|" "${matriz[$contador]}"   

    done

    #Lineas inferiores para cerrar el tablero
    printf '%s\n' "|"
    printf '   %s\n' "----------------------------------------"

  done

  printf '\n\n' 

}

#Cuenta Celdas libres y dice cuantas están libres.
#para llevar un seguimiento de las casillas disponibles 
#en el tablero, ya que podría seguirle pidiendo al jugador
#que ingrese coordenadas, aún cuando se hayan destapado
#todas las casillas.
function obtenerCeldasLibres(){
  
  celdasLibres=0

  #For que controla en base al número de casillas
  #que quedan en el tablero.
  for n in $(seq 1 ${#matriz[@]}); do

    #Controla si una celda tiene inicialmente el "." 
    #para luego definirla como casilla libre.
    if [[ "${matriz[$n]}" = "." ]]; then
      
      #Va almacenando la cantidad las casillas libres.
      #Incrementa el conteo de las casillas que están libres.
      ((celdasLibres+=1))                 
    
    fi

  done

}

#Verifica si la casilla está libre.
function esCasillaLibre(){
  
  local casilla=$1
  local valor=$2
  casillaNoDisponible=0
  
  #Controla que la casillla esté disponible o vacía 
  #las casillas disponibles tendrán un .
  if [[ "${matriz[$casilla]}" = "." ]]; then
    
    #Se actuliza el valor de la casilla.
    matriz[$casilla]=$valor
    #Actualiza la puntuación, sumando los valores de las celdas,
    #que se vayan descubiendo sin pisar una mina.
    puntos=$((puntos+valor))
  
  #Las casillas que ya no están disponibles se activara a 1. 
  else
     casillaNoDisponible=1

  fi

}

#Crea Celda vacia
function creaCeldaVacia(){

  local contador2=$1

    if [[ -z "${matriz[$contador2]}" ]]; then
      
      #Añade punto a la posicion de la celda para indicar que puede haber mina.
      #Todavía, no se habrá destapado, lógicamente.
      matriz[$contador]="."   
    
    fi

}

#Obtiene minas de la partida que he pisado.
#Funcionalidad opcional.
#que muesta en el tablero "finjuego" cuando se pierde la partida.
#Como se va a signar aleatoriamente a la matriz, aparecerá en cualquiere
#parte del tablero, buscando un espacion vacío, teniendo en cuenta que ya puden 
#haber  casillas descubiertas, como será aleatorio, a lo mejor no aparece en N partidas.
function obtenerMinas(){

  #Comando que genera aleatorios para que 
  #cuando salga la variable X y se guarde en m 
  #Se finalize el juego y lo muestre en el tablero. 
  m=$(shuf -e a b c d $e f g X -n 1)


  if [[ "$m" = "X" ]]; then
    
    for limite in ${!m}; do
      
      #Valores a aleatorios que puede existir en una casilla,
      #en este caso, un rango de 0 a 5 solo sacando 1 unico 
      #valor posible para la casilla.
      campo=$(shuf -i 0-5 -n 1)

      #Indice que ira incrementando para ir recorriendo 
      #el tablero hasta que se termine de recorrer el tablero.
      indice=$((i+limite))

      
      #Le pasa a esa funcion de casillaLibre la posición de la celda 
      #y un numero aleatorio entre 0 y 5, escogiendo solo 1 numero de 
      #esos aleatorios. 
      esCasillaLibre $indice $campo
    
    done
  
  #Caso en el que se pierda, pintará en el tablero dicho mensaje.
  elif [[ "$m" = "X" ]]; then
  
    g=0
    
    #En la matriz sobreescribe el contenido del índice
    #con la X
    matriz[$i]=X
    
    #Busca espacio desde la casilla 42 hasta la 49.
    #para escribir un mensaje de finjuego.
    for j in {42..49}; do
  
      salida="finjuego"

      #Imprime una letra en cada casilla.
      k=${salida:$g:1}
      matriz[$j]=${k^^}

      ((g+=1))
  
    done
  fi

}

#-----------------------FIN FUNCIONES TABLERO------------------------------------------#


#---------------------------LOGICA JUGADOR---------------------------------------------#

#Permite encontrar la coordenada fila y columna que el usuario ha ingresado por teclado.
function obtenerCoordenadas(){
  
  #Para columna y fila, usamos la sintaxis de stdin std::cin
  #Lee el primer caracter que será una letra y lo guarda en col.
  col=${opcion:0:1}   
  #Lee el segundo caracter que será un número entero positivo.
  #y lo guarda en fil.
  fil=${opcion:1:1}
  
  #En base, a la letra de columna que se haya ingresado
  #El sistema lo compara con un numero entero,para hacer una coversión.
  #y procesar mejor los datos.
  case $col in

    a ) o=1;;
    b ) o=2;;
    c ) o=3;;
    d ) o=4;;
    e ) o=5;;
    f ) o=6;;
    g ) o=7;;
    h ) o=8;;
    i ) o=9;;
    j ) o=10;;

  esac

  #En base a la columna elegida y la fila, calula el índice o posición 
  #que significará ese campo.
  #Esta operacion ayuda a ubicar la casilla en el tablero.
  #Por ejemplo si el i = 5, la ubicara en la casilla 5,comenzando desde cero.
  i=$(((fil*10)+o))


  #Le pasa al esa funcion de casillaLibre la posición de la celda 
  #y un numero aleatorio entre 0 y 5, escogiendo solo 1 numero de 
  #esos aleatorios. 
  #Es decir, el contenido de esas dos variables.
  #-i es el rango de los numeros enteros aleatorios y -n es el número máximo de números que va a devolver.
  #Se verifica si ese índice aputna una casilla libre.
  esCasillaLibre $i $(shuf -i 0-5 -n 1)       #Shuf genera numeros aleatorios, en este caso entre 0 y 5, solo con una salide de 1 numero.

  
  #Controla la si la coordenada es valida.
  if [[ $casillaNoDisponible -eq 1 ]] || [[ ! "$col" =~ [a-j] ]]; then
    
    printf '\n%s: %s\n' "Error:" "Casilla no permitida."
  
  #Caso en el que la coordenada se ha introducido bien,
  #y eso permitirá seguir jugando, llamando a las funciones, correspondientes.
  #Se vuelve a repetir el ciclo.
  else
   
    #NOTA IMPORTANTE:
    #Si la coordenada es admitida por el sistema, se descubre la mina. 
    #Y cuando se introduce una coordenada algunos valores, se rellenan,
    #al azar en el campo de mina(en el tablero). Los valores estos, se van
    #sumando a la puntuación del jugador, después de qu ese hayan extraido las minas.

    obtenerMinas
    creaTablero
    obtenerCeldasLibres
   
    #Controla si se ha encontrado la X para mostrar mensaje de Game over.
    if [[ "$m" = "X" ]]; then
      
      printf '\n\n\t%s: %s %d\n' "HAS PERDIDO" "Tu puntuación: " "$puntos"
      printf '\n\n\t%s\n\n' "Le quedaron solo $celdasLibres casillas del tablero sin destapar." 
      
      #exit 0
      #Como ya se ha perdido se llama a esta función, para volver a jugar.
      volverAJugar

    elif [[ $celdasLibres -eq 0 ]]; then
    
        printf '\n\n\t%s: %s %d\n' "HAS GANADO!" "Tu puntuación: " "$puntos"
        #exit 0
        #Se ganó, aún así se permite volver a jugar.
        volverAJugar
    fi
  fi

}

#---------------------------LOGICA JUGADOR------------------------



#------------------------------------MAIN--------------------------


menuUntil

trap tiempoEspera INT

#creaTablero

#while true; do
#  read -p "Introduce una coordenada: " opcion
#  obtenerCoordenadas
#done
#menu

#menuSwitch
# menu1

#-----------------------------END MAIN---------------------------
