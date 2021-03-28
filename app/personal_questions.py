import sys
from typing import Union, Tuple
from PyQt5 import QtWidgets, uic


class GerPersonalInfo(QtWidgets.QMainWindow):
    def __init__(self):
        super().__init__()
        uic.loadUi("personal_questions.ui", self)
        self.gender: str = None
        self.height: int = None
        self.weight: int = None
        self.age: int = None
        self.phys_active: bool = None
        self.smoke: bool = None
        self.alcohol: bool = None
        self.diabetes: bool = None
        self.bp_systolic: int = None
        self.bp_diastolic: int = None
        self.chol: int = None
        self.gluc: int = None

        self.next_push_button.clicked.connect(self.on_next_button_clicked)

    def on_next_button_clicked(self):
      pass

    def get_rb_gender(self) -> str:
        return 'Male' if self.rb_gender_male.isChecked() else \
            'Female' if self.rb_gender_female.isChecked() else None

    def get_rb_active(self) -> Union[bool, None]:
        return True if self.rb_active_yes.isChecked() else \
            False if self.rb_active_no.isChecked() else None

    def get_rb_smoke(self) -> Union[bool, None]:
        return True if self.rb_smoke_yes.isChecked() else \
            False if self.rb_smoke_no.isChecked() else None

    def get_rb_alcohol(self) -> Union[bool, None]:
        return True if self.rb_alco_yes.isChecked() else \
            False if self.rb_alco_no.isChecked() else None

    def get_rb_diabetes(self) -> Union[bool, None]:
        return True if self.rb_diabetes_yes.isChecked() else \
            False if self.rb_diabetes_no.isChecked() else None

    def get_height(self) -> Union[int, None]:
        text = self.lineedit_height.text()
        return int(text) if text.isnumeric() else None

    def get_weight(self) -> Union[int, None]:
        text = self.lineedit_weight.text()
        return int(text) if text.isnumeric() else None

    def get_age(self) -> Union[int, None]:
        text = self.lineedit_age.text()
        return int(text) if text.isnumeric() else None

    def get_bp(self) -> Union[Tuple[int, int], None]:
        systolic = self.lineedit_systolic.text()
        diastolic = self.lineedit_diastolic.text()
        if systolic.isnumeric() and diastolic.isnumeric():
            return int(systolic), int(diastolic)
        return None

    def get_chol_level(self) -> Union[int, None]:
        text = self.lineedit_gluc.text()
        return int(text) if text.isnumeric() else None

    def get_gluc_level(self) -> Union[int, None]:
        text = self.lineedit_chol.text()
        return int(text) if text.isnumeric() else None


if __name__ == '__main__':
    app = QtWidgets.QApplication(sys.argv)
    window = GerPersonalInfo()
    window.show()
    sys.exit(app.exec_())
