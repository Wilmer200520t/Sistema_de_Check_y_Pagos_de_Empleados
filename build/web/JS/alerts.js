/* global Swal */

function VentanaEmergente(type,titulo,text,footer){
  Swal.fire({
  icon: type,
  title: titulo,
  text: text,
  footer: footer
    });  
}

// check day validaciones
var data = document.querySelector(".icheck");
if (data !== null) {
    var tipo = data.dataset.tipo;
    var fecha = data.dataset.fecha;
    var hora = data.dataset.hora;
    var icon = data.dataset.icon;
    var tit = data.dataset.titulo;
    var user = data.dataset.user;
    var footer = `idUser: ${user}`;
    let text, titulo;
    if (icon === "success") {
        text = `Fecha: ${fecha}, Hora: ${hora}`;
        titulo = `${tit} de ${tipo}`;
    } else {
        titulo = tit;
        text = "Verifique que el id usuario este correctamente escrito o contacte con un supervisor.";
    }
    VentanaEmergente(icon, titulo, text, footer);
}



// login validaciones

var dtlg = document.querySelector(".login");
if (dtlg !== null) {
    var ico = dtlg.dataset.icon;
    var tex = dtlg.dataset.text;
    var titu = dtlg.dataset.titulo;
    var uid = dtlg.dataset.user;
    var foot = `idUser: ${uid}`;
    var num=dtlg.dataset.num;
    if (num === "camposvacios") {
        VentanaEmergente(ico, titu, tex, "");
    }else{
        VentanaEmergente(ico, titu, tex, foot);
    }
}

// registro validaciones

var dtreg = document.querySelector(".registro");
if (dtreg !== null) {
    var ico = dtreg.dataset.icon;
    var tex = dtreg.dataset.text;
    var titu = dtreg.dataset.titulo;
    var uid = dtreg.dataset.user;
    var foot = `idUser: ${uid}`;
    VentanaEmergente(ico, titu, tex, foot);

}

