import capos.*
import artefactos.*

//enemigos

object archibaldo {
    const property casa = palacioDeMarmol
    const property poder = 16
}

object caterina {
    const property casa = fortalezaDeAcero
    const property poder = 28
}

object astra {
    const property casa = torreDeMarfil
    const property poder = 14
}

//lugares

object palacioDeMarmol {

}

object fortalezaDeAcero {

}

object torreDeMarfil {

}

//eretia

object eretia {
    const habitantes = #{archibaldo, caterina, astra}

    //all retorna true si TODOS los elementos procesados derivan en la condición cumplida
    //any retornaría un valor booleano true si UN elemento procesado deriva en la condición cumplida.
    //any y all precisan una condición booleana dentro del bloque
    method esPoderoso(personaje) {
        return habitantes.all({habitante => personaje.puedeVencer(habitante)}) 
    }

    //el map SIEMPRE DEVUELVE UNA LISTA, ya que puede darse que guarde valores iguales al procesar distintos elementos, por lo que,
    //para asegurar que todos esos elementos se guarden efectivamente y no se pierda alguno, es necesario usar una lista y no un set
    //Se la puede cambiar a set con asSet()
    method conquistables(personaje) {
        return self.vencibles(personaje).map({habitante => habitante.casa()}).asSet()
    }

    method vencibles(personaje) {
        return habitantes.filter({habitante => personaje.puedeVencer(habitante)})
    }

}