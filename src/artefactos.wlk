import capos.*

//se pasa el personaje a poder(personaje) en vez del poder de este porque, en algunos casos, se requiere de otro dato extra del personaje
//además de su poder. Sin embargo, si esto no fuera así y solo necesitara del poder en todos los casos de los artefactos, sería válido
//solo pasar el poder. Tmb hay que tener en cuenta, en ese caso, que se pueden agregar más poderes a futuro, los cuales capaz sí
//necesitan de otros datos del personaje además de su poder.
//pasando el personaje, es NECESARIO que todos los personajes entiendan el mensaje poderBase(), que es mediante el cual los objetos
//en sus métodos poder(personaje) podrán saber el poder base del personaje que se les pasa por parámetro.

//artefactos

object espada{
    var fueUsada = false;

    method poder(personaje) {
        return personaje.poderBase()* self.factorPorUso()
    }

    method serUsado() {
        fueUsada = true;
    }

    method factorPorUso() {
        return if(fueUsada) 0.5 else 1
    }

}

object collar {
    var usos = 0

    method serUsado() {
        usos = usos + 1
    }

    method poder(personaje) {
        return 3 + self.extraPorPoder(personaje)
    }

    method extraPorPoder(personaje) {
        return if(personaje.poderBase()>6) usos else 0
    }

}

object armadura {

    method serUsado() {

    }

    method poder(personaje) {
        return 6
    }

}

object libro {
    const hechizos = []

    method hechizos(_hechizos) {
        hechizos.clear()
        hechizos.addAll(_hechizos)
    }

    method serUsado() {
        hechizos.remove(self.hechizoActual())
    }

    method hechizoActual() {
        return hechizos.head()
    }

    method quedanHechizos() {
        return !(hechizos.isEmpty())
    }

    method poder(personaje) {
        return if(self.quedanHechizos()) self.hechizoActual().poderQueAporta(personaje) else 0
    }

}

//hechizos

object bendicion {

    method poderQueAporta(personaje) {
        return 4
    }

}

object invisibilidad {

    method poderQueAporta(personaje) {
        return personaje.poderBase()
    }

}

//¿esto no podría derivar en ciclo infinito?
object invocacion {

    method poderQueAporta(personaje) {
        return personaje.artefactoMasPoderosoHogar().poder(personaje)
    }

}