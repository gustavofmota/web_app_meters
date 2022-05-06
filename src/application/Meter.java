package application;

public class Meter {
    int id;
    String codMedidor;
    String nomeMedidor;
    int fk_zona;
    String suply_by;
    String codUni;
    int tipoMedidor;

    public int getzId() {
        return zId;
    }

    public void setzId(int zId) {
        this.zId = zId;
    }

    int zId;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCodMedidor() {
        return codMedidor;
    }

    public void setCodMedidor(String codMedidor) {
        this.codMedidor = codMedidor;
    }

    public String getNomeMedidor() {
        return nomeMedidor;
    }

    public void setNomeMedidor(String nomeMedidor) {
        this.nomeMedidor = nomeMedidor;
    }

    public int getFk_zona() {
        return fk_zona;
    }

    public void setFk_zona(int fk_zona) {
        this.fk_zona = fk_zona;
    }

    public String getSuply_by() {
        return suply_by;
    }

    public void setSuply_by(String suply_by) {
        this.suply_by = suply_by;
    }

    public String getCodUni() {
        return codUni;
    }

    public void setCodUni(String codUni) {
        this.codUni = codUni;
    }

    public int getTipoMedidor() {
        return tipoMedidor;
    }

    public void setTipoMedidor(int tipoMedidor) {
        this.tipoMedidor = tipoMedidor;
    }


}
