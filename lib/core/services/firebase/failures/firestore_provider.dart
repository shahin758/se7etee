import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart' as _doctorCollection;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:se7etee/features/auth/data/model/doctor_model.dart';
import 'package:se7etee/features/auth/data/model/patient_model.dart';

class FirebaseProvider {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final patientCollection = _firestore.collection('patients');
  static final doctorCollection = _firestore.collection('doctors');

  static User? get currentUser => _auth.currentUser;

  static Future<void> addPatient(PatientModel patient) async {
    await patientCollection.doc(patient.uid).set(patient.toJson());
  }

  static Future<void> addDoctor(DoctorModel doctor) async {
    await doctorCollection.doc(doctor.uid).set(doctor.toJson());
  }

  static Future<void> updateDoctor(DoctorModel doctor) async {
    await doctorCollection.doc(doctor.uid).update(doctor.toUpdateData());
  }

  static Future<void> updatePatient(PatientModel patient) async {
    await patientCollection.doc(patient.uid).update(patient.toJson());
  }

  static Future<QuerySnapshot> getDoctors() async {
    return await doctorCollection.get();
  }

  static Future<QuerySnapshot> sortingDoctors() async {
    return await doctorCollection
        .where("specialization", isNull: false)
        .orderBy('rating', descending: true)
        .get();
  }
}
