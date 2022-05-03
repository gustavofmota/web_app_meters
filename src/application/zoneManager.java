package application;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class zoneManager {


    public void getZones(ConnectionDB conn) throws SQLException {
        try (PreparedStatement preparedStatement = conn.getConnectX().prepareStatement(conn.SHOW_ZONE_SQL)) {

            ResultSet resultSet = preparedStatement.executeQuery(conn.SHOW_ZONE_SQL);

            List<Zone> zonesList = new ArrayList<>();

            while (resultSet.next()) {
                Zone zone = new Zone();

                zone.setId(resultSet.getInt("id"));
                zone.setCodGeo(resultSet.getString("codgeo"));
                zone.setNome(resultSet.getString("nome"));
                zone.setFk_medidorZona(resultSet.getInt("fk_medidorzona"));
                zone.setTotalCond(resultSet.getFloat("totalcond"));
                zone.setPopulacao(resultSet.getFloat("populacao"));

                zonesList.add(zone);
            }


        }
    }




}
