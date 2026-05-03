import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:se7etee/core/functions/navigation.dart';
import 'package:se7etee/core/routes/routes.dart';
import 'package:se7etee/core/services/firebase/failures/firestore_provider.dart';
import 'package:se7etee/core/services/local/shared_pref.dart';
import 'package:se7etee/core/styles/colors.dart';
import 'package:se7etee/core/styles/text_style.dart';
import 'package:se7etee/core/widgets/cards/doctor_card.dart';
import 'package:se7etee/core/widgets/custome_text_form_field.dart';
import 'package:se7etee/core/widgets/dialogs.dart';
import 'package:se7etee/core/widgets/main_button.dart';
import 'package:se7etee/features/auth/data/model/doctor_model.dart';
import 'package:se7etee/features/patient/booking/data/appointment_model.dart';
import 'package:se7etee/features/patient/booking/data/available_oppointment.dart';

class BookingScreen extends StatefulWidget {
  final DoctorModel doctor;

  const BookingScreen({super.key, required this.doctor});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  TimeOfDay currentTime = TimeOfDay.now();
  String? booking_hour;

  int selectedHour = -1;

  User? user;

  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  List<int> availableHours = [];

  getAvailableTimes(DateTime selectedDate) async {
    availableHours = getAvailableAppointments(
      selectedDate,
      widget.doctor.openHour ?? "0",
      widget.doctor.closeHour ?? "0",
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('احجز مع دكتورك')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              DoctorCard(doctor: widget.doctor, isClickable: false),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        '-- ادخل بيانات الحجز --',
                        style: TextStyles.title24,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'اسم المريض',
                      style: TextStyles.body16.copyWith(
                        color: AppColors.darkcolor,
                      ),
                    ),
                    //------------------------------------------------------------------------------
                    const Gap(10),
                    CustomeTextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) return 'من فضلك ادخل اسم المريض';
                        return null;
                      },
                      // textInputAction: TextInputAction.next,
                    ),
                    const Gap(15),
                    Text(
                      'رقم الهاتف',
                      style: TextStyles.body16.copyWith(
                        color: AppColors.darkcolor,
                      ),
                    ),
                    //------------------------------------------------------------------------------
                    const Gap(10),
                    CustomeTextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      // style: TextStyles.body16.copyWith(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل رقم الهاتف';
                        } else if (value.length < 10) {
                          return 'يرجي ادخال رقم هاتف صحيح';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      hintText: '',
                    ),
                    const Gap(15),
                    Text(
                      'وصف الحالة',
                      style: TextStyles.body16.copyWith(
                        color: AppColors.darkcolor,
                      ),
                    ),
                    //------------------------------------------------------------------------------
                    const Gap(10),
                    CustomeTextFormField(
                      controller: _descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      textInputAction: TextInputAction.next,
                    ),
                    const Gap(15),
                    Text(
                      'تاريخ الحجز',
                      style: TextStyles.body16.copyWith(
                        color: AppColors.darkcolor,
                      ),
                    ),
                    //------------------------------------------------------------------------------
                    const Gap(10),
                    CustomeTextFormField(
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          backgroundColor: AppColors.primaryColor,
                          radius: 18,
                          child: Icon(
                            Icons.date_range_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      readOnly: true,
                      onTap: () {
                        selectDate(context);
                      },
                      controller: _dateController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل تاريخ الحجز';
                        }
                        return null;
                      },
                    ),
                    const Gap(15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'وقت الحجز',
                            style: TextStyles.body16.copyWith(
                              color: AppColors.darkcolor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //------------------------------------------------------------------------------
                    const Gap(10),
                    // to make the slots arranged beside each other
                    Wrap(
                      spacing: 8.0,
                      children: [
                        for (var hour in availableHours)
                          ChoiceChip(
                            backgroundColor: AppColors.accentColor,
                            // showCheckmark: false,
                            checkmarkColor: AppColors.whitecolor,
                            // avatar: const Icon(Icons.abc),
                            selectedColor: AppColors.primaryColor,
                            label: Text(
                              '${(hour < 10) ? '0' : ''}${hour.toString()}:00',
                              style: TextStyle(
                                color: hour == selectedHour
                                    ? AppColors.whitecolor
                                    : AppColors.darkcolor,
                              ),
                            ),
                            selected: hour == selectedHour,
                            onSelected: (selected) {
                              setState(() {
                                selectedHour = hour;
                                booking_hour =
                                    '${(hour < 10) ? '0' : ''}${hour.toString()}:00';
                              });
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: MainButton(
          text: 'تأكيد الحجز',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (selectedHour != -1) {
                _createAppointment();
              } else {
                showMyDialog(context, 'من فضلك اختر وقت الحجز');
              }
            }
          },
        ),
      ),
    );
  }

  Future<void> _createAppointment() async {
    var appointmentData = AppointmentModel(
      patientID: SharedPref.getUserId(),
      doctorID: widget.doctor.uid ?? '',
      name: _nameController.text,
      doctorName: widget.doctor.name ?? '',
      phone: _phoneController.text,
      description: _descriptionController.text,
      location: widget.doctor.address ?? '',
      date: DateTime.parse('${_dateController.text} ${booking_hour!}:00'),
      isComplete: false,
    );
    await FirebaseProvider.addBookedAppointment(appointmentData).then((_) {
      showMyDialog(context, 'تم تسجيل الحجز بنجاح', type: DialogType.success);
      pushToBase(context, Routes.patientMainApp);
    });
  }

  Future<void> selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    ).then((date) {
      if (date != null) {
        _dateController.text = DateFormat(
          'yyyy-MM-dd',
        ).format(date); // to display the date

        getAvailableTimes(date); // to get available times
      }
    });
  }
}
