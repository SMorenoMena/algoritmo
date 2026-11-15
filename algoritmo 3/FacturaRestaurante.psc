
SubProceso LeerPedido(subtotal Por Referencia)
    Escribir "Ingrese el valor del pedido:"
    Leer subtotal
FinSubProceso

SubProceso CalcularPorcentaje(base, porcentaje, resultado Por Referencia)
    resultado <- base * porcentaje / 100
FinSubProceso

SubProceso ImprimirFactura(subtotal, impuesto, propina)
    Definir total Como Real
	
    total <- subtotal + impuesto + propina
	
    Escribir "=========================="
    Escribir "FACTURA RESTAURANTE"
    Escribir "=========================="
    Escribir "Subtotal: $", subtotal
    Escribir "Impuesto 8%: $", impuesto
    Escribir "Propina 10%: $", propina
    Escribir "--------------------------"
    Escribir "TOTAL: $", total
    Escribir "=========================="
FinSubProceso

Algoritmo FacturaRestaurante
    Definir subtotal, impuesto, propina Como Real
	
    LeerPedido(subtotal)
	
    CalcularPorcentaje(subtotal, 8, impuesto)
	
    CalcularPorcentaje(subtotal, 10, propina)
	
    ImprimirFactura(subtotal, impuesto, propina)
FinAlgoritmo
