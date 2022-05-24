package application;

import javax.servlet.http.HttpServletRequest;
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

    public static Zone addZone(HttpServletRequest request, ConnectionDB conn) throws Exception {

        conn.getConnectX().setAutoCommit(false);
        String codGeo = request.getParameter("codGeo");

        try (PreparedStatement verifyExists = conn.getConnectX().prepareStatement(ConnectionDB.VERIFY_ZONE_SQL)) {
            verifyExists.setString(1, codGeo);

            ResultSet resultSet = verifyExists.executeQuery();
            if (resultSet.next()) {
                throw new Exception("Codigo geografico já existe!");
            }
        }


        String nomeZ = request.getParameter("nomeZ");
        double totalCond = Double.parseDouble(request.getParameter("totalCond"));
        double populacao = Double.parseDouble(request.getParameter("populacao"));

        if (codGeo.equals(""))
            codGeo = null;

        if (nomeZ.equals(""))
            nomeZ = null;

        if (totalCond < 0)
            totalCond = 0;

        if (populacao < 0)
            populacao = 0;

        try (PreparedStatement preparedStatement = conn.getConnectX().prepareStatement(ConnectionDB.INSERT_ZONE_SQL)) {
            preparedStatement.setString(1, codGeo);
            preparedStatement.setString(2, nomeZ);
            preparedStatement.setDouble(3, totalCond);
            preparedStatement.setDouble(4, populacao);

            preparedStatement.execute();
            conn.getConnectX().commit();

        } catch (SQLException e) {
            conn.getConnectX().rollback();
            e.printStackTrace();
            throw new Exception("Os campos devem estar todos preenchidos!");
        }

        return null;
    }

    public static Zone getZone(ConnectionDB conn, int zId) throws SQLException {

        try (PreparedStatement preparedStatement = conn.getConnectX().prepareStatement(ConnectionDB.SELECT_SPECIFIC_ZONE_SQL)) {
            preparedStatement.setInt(1, zId);

            ResultSet resultSet = preparedStatement.executeQuery();


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
        } catch (SQLException e) {
            conn.getConnectX().rollback();
            e.printStackTrace();
        }

        return null;
    }


    public static Zone editZone(HttpServletRequest request, ConnectionDB conn, int zId) throws SQLException {
        String codGeo = request.getParameter("codGeo");
        String nomeZ = request.getParameter("nomeZ");
        String medidorZona = request.getParameter("medidorZona");
        double totalCond = Double.parseDouble(request.getParameter("totalCond"));
        double populacao = Double.parseDouble(request.getParameter("populacao"));


        try{
            updateMedZona(request,conn,zId,medidorZona);
        } catch (SQLException e) {
            conn.getConnectX().rollback();
            e.printStackTrace();
        }

        try (PreparedStatement preparedStatement = conn.getConnectX().prepareStatement(ConnectionDB.UPDATE_ZONE_SQL)) {
            preparedStatement.setString(1, codGeo);
            preparedStatement.setString(2, nomeZ);
            preparedStatement.setDouble(3, totalCond);
            preparedStatement.setDouble(4, populacao);
            preparedStatement.setInt(5, zId);

            preparedStatement.execute();
            conn.getConnectX().commit();
        } catch (SQLException e) {
            conn.getConnectX().rollback();
            e.printStackTrace();
        }

        return null;
    }




    public static Zone deleteZone(ConnectionDB conn, int zId) throws SQLException {
        try {
            try (PreparedStatement deleteFk_MedidorZona = conn.getConnectX().prepareStatement(ConnectionDB.SET_MEDIDOR_ZONA_NULL)) {
                deleteFk_MedidorZona.setInt(1, zId);
                deleteFk_MedidorZona.execute();
            }

            try (PreparedStatement deleteFk_Zona = conn.getConnectX().prepareStatement(ConnectionDB.DELETE_METERS_ZONE)) {
                deleteFk_Zona.setInt(1, zId);
                deleteFk_Zona.execute();
            }

            try (PreparedStatement preparedStatement = conn.getConnectX().prepareStatement(ConnectionDB.DELETE_ZONE_SQL)) {
                preparedStatement.setInt(1, zId);
                preparedStatement.execute();
            }
            conn.getConnectX().commit();

        } catch (SQLException e) {
            conn.getConnectX().rollback();
            e.printStackTrace();
        }


        return null;
    }

    public static Zone updateMedZona(HttpServletRequest request, ConnectionDB conn, int zId, String mZ) throws SQLException {
        if(mZ.equals(""))
            mZ=null;

        try{
            try(PreparedStatement preparedStatement = conn.getConnectX().prepareStatement(ConnectionDB.UPDATE_ZONE_METER)){
                preparedStatement.setString(1, mZ);
                preparedStatement.setInt(2, zId);
                preparedStatement.execute();
                conn.getConnectX().commit();
            }


        } catch (Exception e) {
            conn.getConnectX().rollback();
            e.printStackTrace();
        }

        return null;
    }
}
