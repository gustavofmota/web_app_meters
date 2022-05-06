package application;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ZoneManager {


    public static List<Zone> getZones(ConnectionDB conn) throws SQLException {

        try (PreparedStatement preparedStatement = conn.getConnectX().prepareStatement(ConnectionDB.SHOW_ZONE_SQL)) {

            ResultSet resultSet = preparedStatement.executeQuery();

            ArrayList<Zone> zonesList = new ArrayList<>();

            while (resultSet.next()) {
                Zone zone = new Zone();

                zone.setId(resultSet.getInt("id"));
                zone.setCodGeo(resultSet.getString("codgeo"));
                zone.setNome(resultSet.getString("nome"));
                zone.setFk_medidorZona(resultSet.getInt("fk_medidorzona"));
                zone.setTotalCond(resultSet.getDouble("totalcond"));
                zone.setPopulacao(resultSet.getDouble("populacao"));

                zonesList.add(zone);
            }

            return zonesList;
        }
    }




    }
