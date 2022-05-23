// ignore_for_file: constant_identifier_names

import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/views/screens/team_page/widgets/circular_button_in_list_item.dart';
import 'package:flutter/material.dart';

class PlayerListItem extends StatelessWidget {
  const PlayerListItem({
    Key? key,
    required this.playerModel,
    required this.authorized,
    required this.owner,
  }) : super(key: key);

  final PlayerModel playerModel;
  final bool authorized;
  final bool owner;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: ProgramConstants.getDefaultBoxShadow(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(playerModel.fullName),
          _buildButtons(context),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    // const double buttonSize = 24;
    // const double iconSize = 16;
    //
    // Widget kickButton = GestureDetector(
    //   onTap: () {
    //     //TODO: kick
    //   },
    //   child: Container(
    //     width: buttonSize,
    //     height: buttonSize,
    //     margin: const EdgeInsets.all(4),
    //     decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(100), color: Colors.red),
    //     child: const Center(
    //       child: Icon(
    //         Icons.close,
    //         color: Colors.white,
    //         size: iconSize,
    //       ),
    //     ),
    //   ),
    // );
    //
    // Widget captainButton = GestureDetector(
    //   onTap: () {
    //     //TODO: captain
    //   },
    //   child: Container(
    //     width: buttonSize,
    //     height: buttonSize,
    //     margin: const EdgeInsets.all(4),
    //     decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(100), color: Colors.orange),
    //     child: Center(
    //       child: Text(
    //         "C",
    //         style: Theme.of(context).textTheme.bodyText1!.copyWith(
    //             fontWeight: FontWeight.bold,
    //             color: Colors.white,
    //             fontSize: iconSize),
    //       ),
    //     ),
    //   ),
    // );
    //
    // Widget profileButton = GestureDetector(
    //   onTap: () {
    //     //TODO: profile
    //   },
    //   child: Container(
    //     width: buttonSize,
    //     height: buttonSize,
    //     margin: const EdgeInsets.all(4),
    //     decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(100),
    //         color: Theme.of(context).primaryColor),
    //     child: const Center(
    //       child: Icon(
    //         Icons.person,
    //         color: Colors.white,
    //         size: iconSize,
    //       ),
    //     ),
    //   ),
    // );

    List<Widget> buttons = [];

    if (!owner) {
      buttons.add(
        CircularButtonInListItem(
            buttonType: CircularButtonInListItem.profileButton,
            onTap: () {
              //TODO: show profile
            }),
      );
    }

    if (authorized && !owner) {
      buttons = [
        CircularButtonInListItem(
            buttonType: CircularButtonInListItem.captainButton,
            onTap: () {
              //TODO: captain
            }),
        CircularButtonInListItem(
            buttonType: CircularButtonInListItem.kickButton,
            onTap: () {
              //TODO: kick
            }),
        ...buttons
      ];
    }

    return Row(
      children: buttons,
    );
  }
}
