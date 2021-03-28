from PyQt5 import QtWidgets, uic
import pyqtgraph as pg
import sys
import psycopg2


POSTGRESQL_HOST = 'localhost'
POSTGRESQL_DATABASE = 'projectdb'
POSTGRESQL_USER = 'yelmurat'
POSTGRESQL_PASSWORD = 'password'


class MainWindow(QtWidgets.QMainWindow):
    def __init__(self, *args, **kwargs):
        super(MainWindow, self).__init__(*args, **kwargs)
        self.conn = psycopg2.connect(
            host=POSTGRESQL_HOST,
            database=POSTGRESQL_DATABASE,
            user=POSTGRESQL_USER,
            password=POSTGRESQL_PASSWORD)

        uic.loadUi('main.ui', self)
        self.plot_cardio()

    def plot_cardio(self):
        self.plot_cardio_age()
        self.plot_cardio_gender()

    def plot_cardio_age(self):
        query = 'SELECT c_age, (w_disease::NUMERIC / (w_disease+wo_disease)), (w_smoke::NUMERIC / (w_smoke+wo_smoke)), (w_alcohol::NUMERIC / (w_alcohol+wo_alcohol)), (w_active::NUMERIC / (w_active+wo_active)) FROM ( SELECT c_age, COUNT(c_age) FILTER (WHERE c_cardio_disease) AS w_disease, COUNT(c_age) FILTER (WHERE NOT c_cardio_disease) AS wo_disease, COUNT(c_age) FILTER (WHERE c_smoke) AS w_smoke, COUNT(c_age) FILTER (WHERE NOT c_smoke) AS wo_smoke, COUNT(c_age) FILTER (WHERE c_alcohol) AS w_alcohol, COUNT(c_age) FILTER (WHERE NOT c_alcohol) AS wo_alcohol, COUNT(c_age) FILTER (WHERE c_active) AS w_active, COUNT(c_age) FILTER (WHERE NOT c_active) AS wo_active FROM cardio GROUP BY c_age ORDER BY c_age ) AS cnt;'
        cursor = self.conn.cursor()
        cursor.execute(query)
        data = cursor.fetchall()
        cursor.close()

        ages = [data[i][0] for i in range(len(data))]
        disease = [float(data[i][1]) for i in range(len(data))]
        smoke = [float(data[i][2]) for i in range(len(data))]
        alcohol = [float(data[i][3]) for i in range(len(data))]
        active = [float(data[i][4]) for i in range(len(data))]

        self.graph_cardio.addLegend()
        self.graph_cardio.plot(ages, disease, pen='r', name='Percentage of cardio disease by age')
        self.graph_cardio.plot(ages, smoke, pen='b', name='Percentage of smokers by age')
        self.graph_cardio.plot(ages, alcohol, pen='y', name='Percentage of drinkers by age')
        self.graph_cardio.plot(ages, active, pen='c', name='Percentage of active people by age')

    def plot_cardio_gender(self):
        query = 'SELECT cat_gender.cat, COUNT(c_gender_id) FROM cardio, cat_gender WHERE c_cardio_disease = True AND c_gender_id = cat_gender.id GROUP BY cat_gender.cat;'
        cursor = self.conn.cursor()
        cursor.execute(query)
        data = cursor.fetchall()
        cursor.close()

        genders = [data[i][0] for i in range(len(data))]
        counts = [float(data[i][1]) for i in range(len(data))]
        n = len(genders)

        ticks = [list(zip(range(n), genders))]
        xax = self.graph_cardio_gender.getAxis('bottom')
        xax.setTicks(ticks)

        bg = pg.BarGraphItem(x=range(n), height=counts, width=0.8, brushes=['b', 'r'])
        self.graph_cardio_gender.addItem(bg)

    def __del__(self):
        self.conn.close()


def main():
    app = QtWidgets.QApplication(sys.argv)
    main = MainWindow()
    main.show()
    sys.exit(app.exec_())


if __name__ == '__main__':
    main()
