package application;

import javax.servlet.http.HttpServletRequest;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MeterManager {

    public static List<Meter> getMeters(ConnectionDB conn, int zId) throws SQLException{


        try(PreparedStatement preparedStatement = conn.getConnectX().prepareStatement(ConnectionDB.SHOW_METER_SQL)){
            preparedStatement.setInt(1, zId);

            ResultSet resultSet = preparedStatement.executeQuery();

            ArrayList<Meter> metersList = new ArrayList<>();


            while (resultSet.next()) {
                Meter meter = new Meter();

                meter.setId(resultSet.getInt("id"));
                meter.setCodMedidor(resultSet.getString("codmedidor"));
                meter.setNomeMedidor(resultSet.getString("nomemedidor"));
                meter.setFk_zona(resultSet.getInt("fk_zona"));
                meter.setSuply_by(resultSet.getString("supply_by"));
                meter.setCodUni(resultSet.getString("coduni"));
                meter.setTipoMedidor(resultSet.getInt("tipomedidor"));

                metersList.add(meter);
            }


            return metersList;
        }

    }

public static Meter getMeter(ConnectionDB conn, int zId, int mId) throws SQLException{


        try(PreparedStatement preparedStatement = conn.getConnectX().prepareStatement(ConnectionDB.SELECT_SPECIFIC_METER_SQL)){
            preparedStatement.setInt(1, mId);
            preparedStatement.setInt(2, zId);

            ResultSet resultSet = preparedStatement.executeQuery();


            while (resultSet.next()) {
                Meter meter = new Meter();

                meter.setId(resultSet.getInt("id"));
                meter.setCodMedidor(resultSet.getString("codmedidor"));
                meter.setNomeMedidor(resultSet.getString("nomemedidor"));
                meter.setFk_zona(resultSet.getInt("fk_zona"));
                meter.setSuply_by(resultSet.getString("supply_by"));
                meter.setCodUni(resultSet.getString("coduni"));
                meter.setTipoMedidor(resultSet.getInt("tipomedidor"));

                return meter;
            }
        }catch (SQLException e) {
         e.printStackTrace();
        }
    return null;
}

    public static Meter addMeter(HttpServletRequest request, ConnectionDB conn, int zId) throws Exception {


        String codMed = request.getParameter("codMed");


        try(PreparedStatement verifyExists = conn.getConnectX().prepareStatement(ConnectionDB.VERIFY_METER_SQL)){
            verifyExists.setString(1, codMed);

            ResultSet resultSet = verifyExists.executeQuery();
            if (resultSet.next()) {
                throw new Exception("Codigo de Medidor já existe!");
            }
        }





        String nomeMed = request.getParameter("nomeMed");
        String supply_by = request.getParameter("supply_by");
        String codUni = request.getParameter("codUni");
        int tipoMed = Integer.parseInt(request.getParameter("tipoMed"));

        try(PreparedStatement preparedStatement = conn.getConnectX().prepareStatement(ConnectionDB.INSERT_METER_SQL)){
            preparedStatement.setString(1,codMed);
            preparedStatement.setString(2,nomeMed);
            preparedStatement.setInt(3, zId);
            preparedStatement.setString(4,supply_by);
            preparedStatement.setString(5,codUni);
            preparedStatement.setInt(6,tipoMed);

            preparedStatement.execute();
            conn.getConnectX().commit();

        } catch (SQLException e) {
            e.printStackTrace();
        }


        return null;
    }

    public static Meter editMeter(HttpServletRequest request, ConnectionDB conn, int zId, int mId) {
        String codMed = request.getParameter("codMed");
        String nomeMed = request.getParameter("nomeMed");
        String supply_by = request.getParameter("supply_by");
        String codUni = request.getParameter("codUni");
        int tipoMed = Integer.parseInt(request.getParameter("tipoMed"));

        try(PreparedStatement preparedStatement = conn.getConnectX().prepareStatement(ConnectionDB.UPDATE_METER_SQL)){
            preparedStatement.setString(1,codMed);
            preparedStatement.setString(2,nomeMed);
            preparedStatement.setInt(3, zId);
            preparedStatement.setString(4,supply_by);
            preparedStatement.setString(5,codUni);
            preparedStatement.setInt(6,tipoMed);
            preparedStatement.setInt(7,mId);

            preparedStatement.execute();
            conn.getConnectX().commit();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }



    public static Meter deleteMeter(ConnectionDB conn, int mId) throws SQLException {
        try {
            try (PreparedStatement deleteFk_MedidorZona = conn.getConnectX().prepareStatement(ConnectionDB.SET_MEDIDOR_ZONA_NULL)) {
                deleteFk_MedidorZona.setInt(1, mId);
                deleteFk_MedidorZona.execute();
            }

            try (PreparedStatement preparedStatement = conn.getConnectX().prepareStatement(ConnectionDB.DELETE_METER_SQL)) {
                preparedStatement.setInt(1, mId);
                preparedStatement.execute();
            }
            conn.getConnectX().commit();

        } catch (SQLException e) {
            conn.getConnectX().rollback();
            e.printStackTrace();
        }


        return null;
    }


}
