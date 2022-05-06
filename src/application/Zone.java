package application;

public class Zone {
    int id;
    String codGeo;
    String Nome;
    int fk_medidorZona;
    double totalCond;
    double populacao;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCodGeo() {
        return codGeo;
    }

    public void setCodGeo(String codGeo) {
        this.codGeo = codGeo;
    }

    public String getNome() {
        return Nome;
    }

    public void setNome(String nome) {
        Nome = nome;
    }

    public int getFk_medidorZona() {
        return fk_medidorZona;
    }

    public void setFk_medidorZona(int fk_medidorZona) {
        this.fk_medidorZona = fk_medidorZona;
    }

    public double getTotalCond() {
        return totalCond;
    }

    public void setTotalCond(double totalCond) {
        this.totalCond = totalCond;
    }

    public double getPopulacao() {
        return populacao;
    }

    public void setPopulacao(double populacao) {
        this.populacao = populacao;
    }

}
