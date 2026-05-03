import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:se7etee/core/services/local/shared_pref.dart';
import 'package:se7etee/features/auth/data/model/doctor_model.dart';
import 'package:se7etee/features/auth/data/model/patient_model.dart';
import 'package:se7etee/features/patient/booking/data/appointment_model.dart';

class FirebaseProvider {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final patientCollection = _firestore.collection('patients');
  static final doctorCollection = _firestore.collection('doctors');
  static final appointmentCollection = _firestore.collection('appointments');

  static User? get currentUser => _auth.currentUser;

  static Future<void> addPatient(PatientModel patient) async {
    await patientCollection.doc(patient.uid).set(patient.toJson());
  }

  static Future<void> addDoctor(DoctorModel doctor) async {
    await doctorCollection.doc(doctor.uid).set(doctor.toJson());
  }

  static Future<void> addBookedAppointment(AppointmentModel appointment) async {
    await appointmentCollection.add(appointment.toJson());
  }

  static Future<void> deleteBookedAppointment(String id) async {
    await appointmentCollection.doc(id).delete();
  }

  static Future<QuerySnapshot> getBookedAppointmentsByPatientId(
    String patientId,
  ) async {
    return await appointmentCollection
        .where("patientID", isEqualTo: patientId)
        .get();
  }

  static Future<QuerySnapshot> getBookedAppointmentsByDoctorId(
    String doctorId,
  ) async {
    return await appointmentCollection
        .where("doctorID", isEqualTo: doctorId)
        .get();
  }

  static Future<void> updateDoctor(DoctorModel doctor) async {
    await doctorCollection.doc(doctor.uid).update(doctor.toUpdateData());
  }

  static Future<void> updatePatient(PatientModel patient) async {
    await patientCollection.doc(patient.uid).update(patient.toUpdateData());
  }

  static Stream<DocumentSnapshot<Object?>> getCurrentPatient()  {
    return patientCollection.doc(SharedPref.getUserId()).snapshots();
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

  static Future<QuerySnapshot> getDoctorsSpecializations(
    String specialization,
  ) async {
    return await doctorCollection
        .where("specialization", isEqualTo: specialization)
        .get();
  }

  static Future<QuerySnapshot> searchForDoctorsByName(String name) async {
    return await doctorCollection
        .where("specialization", isNull: false)
        .orderBy("name")
        .startAt([name.toLowerCase()])
        .endAt(['${name.toLowerCase()}\uf8ff'])
        .get();
  }
}
