/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;

/**
 *
 * @author david
 */
@Entity
@Table(name = "reserva")
public class reserva implements Serializable {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "fecha")
    @Temporal(javax.persistence.TemporalType.DATE)
    Date fecha;
    
    @Column(name = "horaInicio")
    String horaInicio;
    
    @Column(name = "horaFin")
    String HoraFin;
    
    @Column(name = "Estado")
    String Estado;

    @ManyToOne
    @JoinColumn(name = "id_usuario", nullable = false)
    private usuario Usuario;

    public reserva() {
    }

    public reserva(Integer id, Date fecha, String horaInicio, String HoraFin, String Estado, usuario Usuario) {
        this.id = id;
        this.fecha = fecha;
        this.horaInicio = horaInicio;
        this.HoraFin = HoraFin;
        this.Estado = Estado;
        this.Usuario = Usuario;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getHoraInicio() {
        return horaInicio;
    }

    public void setHoraInicio(String horaInicio) {
        this.horaInicio = horaInicio;
    }

    public String getHoraFin() {
        return HoraFin;
    }

    public void setHoraFin(String HoraFin) {
        this.HoraFin = HoraFin;
    }

    public String getEstado() {
        return Estado;
    }

    public void setEstado(String Estado) {
        this.Estado = Estado;
    }

    public usuario getUsuario() {
        return Usuario;
    }

    public void setUsuario(usuario Usuario) {
        this.Usuario = Usuario;
    }

   

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof reserva)) {
            return false;
        }
        reserva other = (reserva) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.reservas[ id=" + id + " ]";
    }

}
