package application;

import javax.servlet.http.HttpServletRequest;
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

    public static Zone addZone(HttpServletRequest request, ConnectionDB conn) throws SQLException {

        conn.getConnectX().setAutoCommit(false);
        String codGeo = request.getParameter("codGeo");

        try(PreparedStatement verifyExists = conn.getConnectX().prepareStatement(ConnectionDB.VERIFY_ZONE_SQL)){
            verifyExists.setString(1, codGeo);

            ResultSet resultSet = verifyExists.executeQuery();
            if (resultSet.next() == true)
                return null;
        }





        String nomeZ = request.getParameter("nomeZ");
        double totalCond = Double.parseDouble(request.getParameter("totalCond"));
        double populacao = Double.parseDouble(request.getParameter("populacao"));

        try(PreparedStatement preparedStatement = conn.getConnectX().prepareStatement(ConnectionDB.INSERT_ZONE_SQL)){
            preparedStatement.setString(1,codGeo);
            preparedStatement.setString(2,nomeZ);
            preparedStatement.setDouble(3, totalCond);
            preparedStatement.setDouble(4,populacao);

            preparedStatement.execute();
            conn.getConnectX().commit();

        } catch (SQLException e) {
            conn.getConnectX().rollback();
            e.printStackTrace();
        }


        try(PreparedStatement verifyExists = conn.getConnectX().prepareStatement(ConnectionDB.VERIFY_ZONE_SQL)){
            verifyExists.setString(1, codGeo);

            ResultSet resultSet = verifyExists.executeQuery();

            while (resultSet.next()) {
                Zone zone = new Zone();

                zone.setId(resultSet.getInt("id"));
                zone.setCodGeo(resultSet.getString("codGeo"));
                zone.setNome(resultSet.getString("nome"));
                zone.setFk_medidorZona(resultSet.getInt("fk_medidorzona"));
                zone.setTotalCond(Double.parseDouble(resultSet.getString("totalcond")));
                zone.setPopulacao(Double.parseDouble(resultSet.getString("populacao")));

                return zone;
            }
        }

        return null;
    }

    public void deleteZone(ConnectionDB conn) throws SQLException{

    }

}
