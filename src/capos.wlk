import artefactos.*
import enemigos.*

//NO está mal agregar en un test un método isEmpty() para una colección para probar si está vacía ( assert.that(coleccion.isEmpty()) )
//SI ES QUE NUNCA SE NOS PIDE LA FUNCIONALIDAD DE SABER SI LA COLECCIÓN ESTÁ VACÍA O NO EN ALGÚN REQUERIMIENTO

//no está bueno inventar código para cada cosa que quiero testear si es que no me las pide el requerimiento.


object castillo {
	
	const property artefactos = #{}
		
	method agregarArtefactos(_artefactos) {
		artefactos.addAll(_artefactos)		
	}

	//guarda un máximo y se fija en cada giro si el valor retornado (artefacto.poder(personaje)) es mayor al máximo que se tenía
	//hasta el momento. Luego de procesados todos los elementos de la colección, se retorna ese máximo.
	method artefactoMasPoderoso(personaje) {
		return artefactos.max({artefacto => artefacto.poder(personaje)}) 
	}
	
}


object rolando {

	const property artefactos = #{}
	var property capacidad = 2
	const casa = castillo
	const property historia = []
	var poderBase = 5

	method tieneArmaFatal(enemigo) {
		return artefactos.any({artefacto => artefacto.poder(self) > enemigo.poder()})
	}

	method armaFatal(enemigo) {
		return artefactos.find({artefacto => artefacto.poder(self) > enemigo.poder()})
	}

	//este setter lo agregamos para el diseño de los tests
	method poderBase(_poderBase) {
		poderBase = _poderBase
	}

	method puedeVencer(enemigo) {
		return self.poderDePelea() > enemigo.poder()
	}

	method artefactoMasPoderosoHogar() {
		return casa.artefactoMasPoderoso(self)
	}

	method luchar() {
		self.usarArtefactos()
		poderBase+=1
	}

	//metodo de ORDEN que hace recorrido ejecutando acciones por cada elemento procesado
	//NO es de consulta por lo que NO devuelve, nada como si lo hace sum
	method usarArtefactos() {
		artefactos.forEach({artefacto => artefacto.serUsado()})
	}

	method poderBase() {
		return poderBase
	}

	//método de recorrido como el map que suma a un acumulador los return por cada iteración donde emplea al elemento procesado.
	//Luego de procesados todos los elementos de la colección, se retorna esa suma
	method poderArtefactos() {
		return artefactos.sum({artefacto => artefacto.poder(self)})
	}

	method poderDePelea() {
		return poderBase + self.poderArtefactos()
	}

	method encontrar(artefacto) {
		if(artefactos.size() < capacidad) {
			artefactos.add(artefacto)
		}
		historia.add(artefacto)
	}
	
	method volverACasa() {
		casa.agregarArtefactos(artefactos)
		artefactos.clear()
	}	
	
	method posesiones() {
		return self.artefactos() + casa.artefactos()
	}
	
	method posee(artefacto) {
		return self.posesiones().contains(artefacto)	
	}
		
}

