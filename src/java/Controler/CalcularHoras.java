
package Controler;
import Controler.conexion.*;
import java.sql.*;
import java.time.LocalTime;
public class CalcularHoras {
    
    public static String restarhoras(String init,String fin){
        Double total=0.0;
        //DEFINIR HORA
        int hora=Integer.parseInt(init.split(":")[0]);
        int mina=Integer.parseInt(init.split(":")[1]);
        int seca=Integer.parseInt(init.split(":")[2]);
        
        int horb=Integer.parseInt(fin.split(":")[0]);
        int minb=Integer.parseInt(fin.split(":")[1]);
        int secb=Integer.parseInt(fin.split(":")[2]);
        
        // Definir dos objetos LocalTime
        LocalTime hora2 = LocalTime.of(hora,mina,seca);  // 10:30
        LocalTime hora1 = LocalTime.of(horb,minb,secb);   // 02:15

        // Restar horas
        LocalTime resultado = hora1.minusHours(hora2.getHour()).minusMinutes(hora2.getMinute()).minusSeconds(hora2.getSecond());
        String rs=String.valueOf(resultado);
        if(rs.equals("00:00")){
            return "00:00:00";
        }else{
            return rs;
        }
    }
    
    public static String sumarhoras(String init,String fin){
        
        System.out.println(init+" -- "+fin);
        //DEFINIR HORA
        int hora=Integer.parseInt(init.split(":")[0]);
        int mina=Integer.parseInt(init.split(":")[1]);
        
        int horb=Integer.parseInt(fin.split(":")[0]);
        int minb=Integer.parseInt(fin.split(":")[1]);
        
        // Definir dos objetos LocalTime
        String resultado=(hora+horb)+":"+(mina+minb)+":00";   
        return resultado;
    }
    
    public static String conversion(String hora){
        int hor=Integer.parseInt(hora.split(":")[0]);
        int mina=Integer.parseInt(hora.split(":")[1]);
        int seca=Integer.parseInt(hora.split(":")[2]);
        
        seca=seca/60;
        mina+=Math.floor(seca);
        hor+=Math.floor(mina/60);
        mina=(mina%60)*10/6;
        return hor+"."+mina;
    }
    
    public CalcularHoras(String iduser,String idperiod) throws ClassNotFoundException, SQLException{
        String horan="00:00:00",horas="00:00:00",horad="00:00:00",horaf="00:00:00",horap="00:00:00",horar="00:00:00";
        conexion cn= new conexion();
        Connection conex=cn.getConexion();
        cn.st=conex.createStatement();
        cn.rs=cn.st.executeQuery("call sp_call_check("+iduser+","+idperiod+")");
        
        while (cn.rs.next()) {
            String intit=cn.rs.getString(4);
            String fin=cn.rs.getString(5);
            String tpdia=cn.rs.getString(6);
            if (tpdia.equals("Normal")) {
                if (fin != null) {
                    String temp = restarhoras(intit, fin);
                    horan = sumarhoras(temp, horan);

                }

            }else if(tpdia.equals("Sabado")){
                if (fin != null) {
                    String temp = restarhoras(intit, fin);
                    horas = sumarhoras(temp, horas);

                }           
            }else if(tpdia.equals("Domingo")){
                if (fin != null) {
                    String temp = restarhoras(intit, fin);
                    horad = sumarhoras(temp, horad);
                    
                }           
            }else if(tpdia.equals("Feriado")){
                if (fin != null) {
                    String temp = restarhoras(intit, fin);
                    horaf = sumarhoras(temp, horaf);
                }           
            }
               
        }
        horan=conversion(horan);
        horas=conversion(horas);
        horad=conversion(horad);
        horaf=conversion(horaf);      
        cn.rs=cn.st.executeQuery("call sp_insert_journeys("+horan+","+horas+","+horad+","+horaf+",1,1,+"+iduser+","+idperiod+")");
    
    
    }
    
    
}
