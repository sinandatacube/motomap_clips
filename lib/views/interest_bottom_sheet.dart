import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:motomap_clips/logic/impression/impression_cubit.dart';
import 'package:motomap_clips/views/views.dart';

enum BookTestDrive { yes, no }

enum ExchangeCar { yes, no }

class InterestBottomSheet extends StatefulWidget {
  final String showRoomId;
  final String id;
  final String type;
  final String vehicleType;
  final String vehicleFrom;
  final String customerId;
  final String customerName;
  final String customerMobile;
  final bool isMotoClip;
  final int index;

  const InterestBottomSheet(
      {super.key,
      required this.id,
      required this.index,
      required this.customerMobile,
      required this.isMotoClip,
      required this.customerId,
      required this.customerName,
      required this.showRoomId,
      required this.vehicleFrom,
      required this.type,
      required this.vehicleType});

  @override
  State<InterestBottomSheet> createState() => _InterestBottomSheetState();
}

class _InterestBottomSheetState extends State<InterestBottomSheet> {
  BookTestDrive bookTestDrive = BookTestDrive.yes;
  ExchangeCar exchangeCar = ExchangeCar.no;
  final ctrlTestDriveDate = TextEditingController();
  final now = DateTime.now().add(const Duration(days: 1));
  late DateTime selectedDate;

  @override
  void initState() {
    selectedDate = now;
    ctrlTestDriveDate.text = DateFormat.yMMMMEEEEd().format(now);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("Show Interest", textScaleFactor: 1.5),
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 16),
            child: Text("Book a test drive ?"),
          ),
          Row(
            children: [
              Radio(
                value: BookTestDrive.yes,
                groupValue: bookTestDrive,
                onChanged: (value) {
                  bookTestDrive = value!;
                  setState(() {});
                },
              ),
              const Text("Yes"),
              const SizedBox(width: 20),
              Radio(
                value: BookTestDrive.no,
                groupValue: bookTestDrive,
                onChanged: (value) {
                  bookTestDrive = value!;
                  setState(() {});
                },
              ),
              const Text("No"),
            ],
          ),
          if (bookTestDrive == BookTestDrive.yes)
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Select test drive date"),
                  const SizedBox(height: 16),
                  TextField(
                    controller: ctrlTestDriveDate,
                    onTap: selectDate,
                    readOnly: true,
                    decoration: const InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.calendar_month),
                    ),
                  ),
                ],
              ),
            ),
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 16),
            child: Text("Exchange your car ?"),
          ),
          Row(
            children: [
              Radio(
                value: ExchangeCar.yes,
                groupValue: exchangeCar,
                onChanged: (value) {
                  exchangeCar = value!;
                  setState(() {});
                },
              ),
              const Text("Yes"),
              const SizedBox(width: 20),
              Radio(
                value: ExchangeCar.no,
                groupValue: exchangeCar,
                onChanged: (value) {
                  exchangeCar = value!;
                  setState(() {});
                },
              ),
              const Text("No"),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Cancel"),
                ),
              ),
              const SizedBox(width: 16),
              BlocConsumer<ImpressionCubit, ImpressionState>(
                listener: (context, state) {
                  debugPrint(state.toString() + " asdfghjkk");

                  if (state is ImpressionError) {
                    debugPrint(state.toString() + " qewr");

                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                        margin: const EdgeInsets.all(5),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                  if (state is ImpressionSet) {
                    Navigator.of(context).pop();
                    if (widget.isMotoClip) {
                      reelsList[widget.index].isInterested = "1";
                    } else {
                      // navigatorKey.currentState!.pushReplacement(
                      //   MaterialPageRoute(
                      //       builder: (context) => MultiBlocProvider(
                      //             providers: [
                      //               BlocProvider(
                      //                 create: (context) => DetailsCubit(
                      //                     apiRepository:
                      //                         context.read<ApiRepository>(),
                      //                     internetRepository: context
                      //                         .read<InternetRepository>())
                      //                   ..loadDetails(
                      //                       showroomId: widget.showRoomId,
                      //                       id: widget.id,
                      //                       tableType: widget.vehicleFrom,
                      //                       type: widget.vehicleType),
                      //               ),
                      //               BlocProvider(
                      //                 create: (context) => ImpressionCubit(
                      //                     apiRepository:
                      //                         context.read<ApiRepository>()),
                      //               )
                      //             ],
                      //             child: ProductDetailScreen(
                      //                 showShowroom: true,
                      //                 type: widget.vehicleType.toLowerCase()),
                      //           )),
                      // );
                    }
                  }
                },
                builder: (context, state) {
                  debugPrint(state.toString() + " impression state");

                  return Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final testDriveBooking = bookTestDrive.name;
                        final carExchanging = exchangeCar.name;
                        final testDriveDate = selectedDate;

                        print(testDriveBooking);
                        print(carExchanging);
                        print(testDriveDate);
                        if (testDriveBooking.isEmpty) {
                          Fluttertoast.cancel();
                          Fluttertoast.showToast(msg: "Fill all fields");
                        } else if (ctrlTestDriveDate.text.isEmpty) {
                          Fluttertoast.cancel();
                          Fluttertoast.showToast(msg: "Choose testdrive date");
                        } else {
                          context.read<ImpressionCubit>().setImpression(
                              customerMobile: widget.customerMobile,
                              customerId: widget.customerId,
                              customerName: widget.customerName,
                              tableType: widget.vehicleFrom,
                              vechicleType: widget.vehicleType.toLowerCase(),
                              addId: widget.id,
                              showroomId: widget.showRoomId,
                              isExchange: carExchanging,
                              isTestDrive: testDriveBooking,
                              testDriveDate: testDriveDate.toString());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      child: state is ImpressionLoading
                          ? const CupertinoActivityIndicator(
                              color: Colors.white,
                            )
                          : const Text("Submit"),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  selectDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: now,
      lastDate: now.add(const Duration(days: 30)),
    );

    selectedDate = selected ?? selectedDate;

    ctrlTestDriveDate.text = DateFormat.yMMMMEEEEd().format(selectedDate);
  }
}
