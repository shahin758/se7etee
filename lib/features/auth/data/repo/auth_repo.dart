import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:se7etee/core/constants/user_type_enum.dart';
import 'package:se7etee/core/functions/image_uploader.dart';
import 'package:se7etee/core/services/firebase/failures/failure.dart';
import 'package:se7etee/core/services/firebase/failures/firestore_provider.dart';
import 'package:se7etee/core/services/local/shared_pref.dart';
import 'package:se7etee/features/auth/data/model/auth_params.dart';
import 'package:se7etee/features/auth/data/model/doctor_model.dart';
import 'package:se7etee/features/auth/data/model/patient_model.dart';

class AuthRepo {
  static Future<Either<Failure, UserTypeEnum>> login(AuthParams params) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: params.email,
            password: params.password,
          );
      User? user = credential.user;
      await SharedPref.cacheUserId(user?.uid ?? '');

      if (UserTypeEnum.fromString(user?.photoURL ?? '') ==
          UserTypeEnum.doctor) {
        return right(UserTypeEnum.doctor);
      } else {
        return right(UserTypeEnum.patient);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return left(Failure(message: 'الحساب غير موجود'));
      } else if (e.code == 'wrong-password') {
        return left(Failure(message: 'كلمة المرور خاطئة'));
      } else {
        return left(Failure(message: 'حدث خطأ'));
      }
    } catch (e) {
      return left(Failure(message: 'حدث خطأ'));
    }
  }

  //-------Register As Doctor-------

  static Future<Either<Failure, Unit>> registerDoctor(AuthParams params) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: params.email,
            password: params.password,
          );
      User? user = credential.user;
      await user?.updateDisplayName(params.name);
      await user?.updatePhotoURL(UserTypeEnum.doctor.value);
      await SharedPref.cacheUserId(credential.user?.uid ?? '');

      var doctorData = DoctorModel(
        name: params.name,
        email: params.email,
        uid: credential.user?.uid,
      );

      await FirebaseProvider.addDoctor(doctorData);

      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return left(Failure(message: 'كلمة المرور ضعيفة'));
      } else if (e.code == 'email-already-in-use') {
        return left(Failure(message: 'الحساب موجود بالفعل'));
      } else {
        return left(Failure(message: 'حدث خطأ'));
      }
    } catch (e) {
      return left(Failure(message: 'حدث خطأ'));
    }
  }

  //-------Register As Patient-------

  static Future<Either<Failure, Unit>> registerPatient(
    AuthParams params,
  ) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: params.email,
            password: params.password,
          );
      User? user = credential.user;
      await user?.updateDisplayName(params.name);
      await user?.updatePhotoURL(UserTypeEnum.patient.value);
      await SharedPref.cacheUserId(credential.user?.uid ?? '');

      var patientData = PatientModel(
        name: params.name,
        email: params.email,
        uid: credential.user?.uid,
      );

      await FirebaseProvider.addPatient(patientData);

      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return left(Failure(message: 'كلمة المرور ضعيفة'));
      } else if (e.code == 'email-already-in-use') {
        return left(Failure(message: 'الحساب موجود بالفعل'));
      } else {
        return left(Failure(message: 'حدث خطأ'));
      }
    } catch (e) {
      return left(Failure(message: 'حدث خطأ'));
    }
  }

  //-------Doctor Completing Registration-------

  static Future<Either<Failure, Unit>> updateDoctorProfile(
    DoctorModel doctorData,
  ) async {
    try {
      doctorData.imageUrl =
          await uploadImageToCloudinary(doctorData.image!) ?? '';

      await FirebaseProvider.updateDoctor(doctorData);
      return right(unit);
    } catch (e) {
      return left(Failure(message: 'حدث خطأ'));
    }
  }
}
