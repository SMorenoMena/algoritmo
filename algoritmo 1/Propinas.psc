Algoritmo Propinas
	Definir cuenta, propina, total, personas, cada_uno Como Real
	Escribir 'Ingrese el valor de la cuenta:'
	Leer cuenta
	Escribir 'Ingrese la cantidad de personas:'
	Leer personas
	propina <- cuenta*0.10/100
	total <- cuenta+propina
	cada_uno <- total/personas
	Escribir 'La propina es: ', propina
	Escribir 'El total a pagar es: ', total
	Escribir 'Cada persona debe pagar: ', cada_uno
FinAlgoritmo
