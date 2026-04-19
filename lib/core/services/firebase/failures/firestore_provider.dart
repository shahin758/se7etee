import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:se7etee/features/auth/data/model/doctor_model.dart';
import 'package:se7etee/features/auth/data/model/patient_model.dart';

class FirestoreProvider {
  static final patientCollection = FirebaseFirestore.instance.collection('patients');
  static final doctorCollection = FirebaseFirestore.instance.collection('doctors');

  static Future<void> addPatient(PatientModel patient) async {
    await patientCollection.doc(patient.uid).set(patient.toJson());
  }

 static  Future<void> addDoctor(DoctorModel doctor) async {
    await doctorCollection.doc(doctor.uid).set(doctor.toJson());
  }
}
