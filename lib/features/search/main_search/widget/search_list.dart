
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se7etee/core/services/firebase/failures/firestore_provider.dart';
import 'package:se7etee/core/widgets/cards/doctor_card.dart';
import 'package:se7etee/features/auth/data/model/doctor_model.dart';
import 'package:se7etee/features/search/specialization_search/page/speacialization_screen.dart';

class SearchList extends StatelessWidget {
  const SearchList({super.key, required this.search});

  final String search;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: FirebaseProvider.searchForDoctorsByName(search),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return snapshot.data!.docs.isEmpty
              ? EmptyWidget()
              : Scrollbar(
                  child: ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      DoctorModel doctor = DoctorModel.fromJson(
                        snapshot.data!.docs[index].data()
                            as Map<String, dynamic>,
                      );
                      if (doctor.specialization?.isNotEmpty == true) {
                        return DoctorCard(doctor: doctor);
                      }
                      return const SizedBox();
                    },
                  ),
                );
        },
      ),
    );
  }
}
