package application;

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
                zId = -1;
            }


            return metersList;
        }

    }


}
