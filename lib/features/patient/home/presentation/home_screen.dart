import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7etee/core/functions/navigation.dart';
import 'package:se7etee/core/routes/routes.dart';
import 'package:se7etee/core/services/firebase/failures/firestore_provider.dart';
import 'package:se7etee/core/styles/colors.dart';
import 'package:se7etee/core/styles/text_style.dart';
import 'package:se7etee/features/patient/home/widgets/specialist_widgets.dart';
import 'package:se7etee/features/patient/home/widgets/top_rated.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key, required this.onSearch});

  final Function() onSearch;

  @override
  State<PatientHomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<PatientHomeScreen> {
  final TextEditingController _doctorName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseProvider.currentUser;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              splashRadius: 20,
              icon: const Icon(
                Icons.notifications_active,
                color: AppColors.darkcolor,
              ),
              onPressed: () {},
            ),
          ),
        ],
        backgroundColor: AppColors.accentColor,
        elevation: 0,
        title: Text(
          'صــــــحّـتــي',
          style: TextStyles.title24.copyWith(color: AppColors.darkcolor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'مرحبا، ',
                      style: TextStyles.body16.copyWith(fontSize: 18),
                    ),
                    TextSpan(
                      text: currentUser?.displayName,
                      style: TextStyles.title24.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              Text(
                "احجز الآن وكن جزءًا من رحلتك الصحية.",
                style: TextStyles.title24.copyWith(
                  color: AppColors.darkcolor,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 20),

              // --------------- Search Bar --------------------------
              _searchBar(context),

              const SizedBox(height: 20),

              const SpecialistsBanner(),
              const SizedBox(height: 10),

              Text(
                "الأعلي تقييماً",
                textAlign: TextAlign.center,
                style: TextStyles.title24.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const TopRatedList(),
            ],
          ),
        ),
      ),
    );
  }



























  Container _searchBar(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: .3),
            blurRadius: 15,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: TextFormField(
        readOnly: true,
        onTap: widget.onSearch,
        textInputAction: TextInputAction.search,
        controller: _doctorName,
        cursorColor: AppColors.primaryColor,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          hintStyle: TextStyles.body16,
          filled: true,
          hintText: 'ابحث عن دكتور',
          suffixIcon: Container(
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: AppColors.primaryColor.withOpacity(0.9),
              borderRadius: BorderRadius.circular(17),
            ),
            child: IconButton(
              iconSize: 20,
              splashRadius: 20,
              color: Colors.white,
              icon: const Icon(Icons.search),
              onPressed: widget.onSearch,
            ),
          ),
        ),
        style: TextStyles.body16,
        onFieldSubmitted: (String value) {
          if (_doctorName.text.isNotEmpty) {
            pushTo(context, Routes.homeSearch, extra: _doctorName.text);
          }
        },
      ),
    );
  }
}
