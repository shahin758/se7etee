import 'package:flutter/material.dart';
import 'package:se7etee/core/functions/navigation.dart';
import 'package:se7etee/core/routes/routes.dart';
import 'package:se7etee/core/styles/colors.dart';
import 'package:se7etee/core/styles/text_style.dart';
import 'package:se7etee/core/widgets/main_button.dart';
import 'package:se7etee/features/auth/data/model/doctor_model.dart';
import 'package:se7etee/features/search/doctor_profile/widgets/item_tile.dart';
import 'package:se7etee/features/search/doctor_profile/widgets/phone_tile.dart';

class DoctorProfileScreen extends StatefulWidget {
  final DoctorModel? doctorModel;

  const DoctorProfileScreen({super.key, this.doctorModel});
  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  late DoctorModel doctor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بيانات الدكتور')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.accentColor,
                        child: CircleAvatar(
                          backgroundColor: AppColors.accentColor,
                          radius: 60,
                          backgroundImage: (widget.doctorModel?.image != null)
                              ? NetworkImage(widget.doctorModel!.imageUrl!)
                              : const AssetImage('assets/doc.png'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "د. ${widget.doctorModel?.name ?? ''}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.title24.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.doctorModel?.specialization ?? '',
                          style: TextStyles.caption114.copyWith(
                            color: AppColors.darkcolor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              widget.doctorModel?.rating.toString() ?? '0.0',
                              style: TextStyles.body16.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 3),
                            const Icon(
                              Icons.star_rounded,
                              size: 20,
                              color: Colors.orange,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            IconTile(
                              onTap: () {},
                              backColor: AppColors.accentColor,
                              imgAssetPath: Icons.phone,
                              num: '1',
                            ),
                            if (widget.doctorModel?.phone2?.isNotEmpty == true)
                              IconTile(
                                onTap: () {},
                                backColor: AppColors.accentColor,
                                imgAssetPath: Icons.phone,
                                num: '2',
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),
              Text(
                "نبذه تعريفية",
                style: TextStyles.body16.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(widget.doctorModel?.bio ?? '', style: TextStyles.body16),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.accentColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TileWidget(
                      text:
                          '${widget.doctorModel?.openHour} - ${widget.doctorModel?.closeHour}',
                      icon: Icons.watch_later_outlined,
                    ),
                    const SizedBox(height: 15),
                    TileWidget(
                      text: widget.doctorModel?.address ?? '',
                      icon: Icons.location_on_rounded,
                    ),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: 20),
              Text(
                "معلومات الاتصال",
                style: TextStyles.body16.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.accentColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TileWidget(
                      text: widget.doctorModel?.email ?? '',
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 15),
                    TileWidget(
                      text: widget.doctorModel?.phone1 ?? '',
                      icon: Icons.call,
                    ),
                    if (widget.doctorModel?.phone2?.isNotEmpty == true) ...[
                      const SizedBox(height: 15),
                      TileWidget(
                        text: widget.doctorModel?.phone2 ?? '',
                        icon: Icons.call,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: MainButton(
            text: 'احجز موعد الان',
            onPressed: () {
              pushTo(context, Routes.bookingScreen, extra: widget.doctorModel);
            },
          ),
        ),
      ),
    );
  }
}
