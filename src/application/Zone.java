package application;

public class Zone {
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

    public float getTotalCond() {
        return totalCond;
    }

    public void setTotalCond(float totalCond) {
        this.totalCond = totalCond;
    }

    public float getPopulacao() {
        return populacao;
    }

    public void setPopulacao(float populacao) {
        this.populacao = populacao;
    }

    int id;
    String codGeo;
    String Nome;
    int fk_medidorZona;
    float totalCond;
    float populacao;
}
