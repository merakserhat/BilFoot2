import 'package:bilfoot/views/screens/match_page/widgets/date_picker.dart';
import 'package:bilfoot/views/screens/match_page/widgets/match_hour_selector.dart';
import 'package:bilfoot/views/screens/match_page/widgets/pitch_selector.dart';
import 'package:bilfoot/views/screens/match_page/widgets/publish_checkbox.dart';
import 'package:bilfoot/views/screens/match_page/widgets/reserved_checkbox.dart';
import 'package:bilfoot/views/widgets/panel_base.dart';
import "package:flutter/material.dart";
import 'package:numberpicker/numberpicker.dart';

class CreateMatchPanel extends StatefulWidget {
  const CreateMatchPanel({Key? key}) : super(key: key);

  @override
  State<CreateMatchPanel> createState() => _CreateMatchPanelState();
}

class _CreateMatchPanelState extends State<CreateMatchPanel> {
  bool isReserved = false;
  bool isPublish = true;
  int peopleLimit = 12;
  String selectedPitch = "Merkez 1";
  String selectedHour = "??-??";
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return PanelBase(
        child: Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 6,
              child: DatePicker(
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 30)),
                selectedDate: selectedDate,
                setSelectedDate: (DateTime date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
            ),
            const SizedBox.square(dimension: 10),
            Flexible(
              flex: 4,
              child: MatchHourSelector(
                  onChanged: (String? hour) {
                    if (hour != null) {
                      setState(() {
                        selectedHour = hour;
                        if (selectedHour == "??-??") {
                          isReserved = false;
                        }
                      });
                    }
                  },
                  selectedHour: selectedHour),
            )
          ],
        ),
        const SizedBox.square(dimension: 20),
        PitchSelector(
          onChanged: (value) {
            setState(() {
              selectedPitch = value;
            });
          },
          selectedPitch: selectedPitch,
        ),
        const SizedBox.square(dimension: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("People Limit: "),
            SizedBox(
              width: 150,
              child: NumberPicker(
                  minValue: 1,
                  maxValue: 20,
                  axis: Axis.horizontal,
                  itemWidth: 50,
                  value: peopleLimit,
                  onChanged: (value) {
                    setState(() {
                      peopleLimit = value;
                    });
                  }),
            ),
          ],
        ),
        const SizedBox.square(dimension: 20),
        ReservedCheckbox(
          onChanged: (value) {
            setState(() {
              isReserved = value ?? false;
            });
          },
          defaultValue: isReserved,
          disabled: selectedHour == "??-??",
        ),
        const SizedBox.square(dimension: 20),
        PublishCheckbox(
          onChanged: (value) {
            setState(() {
              isPublish = value ?? true;
            });
          },
          defaultValue: isPublish,
        ),
        const SizedBox.square(dimension: 20),
        ElevatedButton(
          onPressed: () {},
          child: const Text("Create"),
        ),
        const SizedBox.square(dimension: 10),
      ],
    ));
  }
}
