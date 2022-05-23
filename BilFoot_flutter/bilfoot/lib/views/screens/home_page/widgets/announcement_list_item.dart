import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/announcements/player_announcement_model.dart';
import 'package:bilfoot/views/screens/team_page/widgets/circular_button_in_list_item.dart';
import 'package:flutter/material.dart';

class AnnouncementListItem extends StatefulWidget {
  const AnnouncementListItem(
      {Key? key, this.invited = false, required this.playerAnnouncement})
      : super(key: key);

  final bool invited;
  final PlayerAnnouncementModel playerAnnouncement;

  @override
  State<AnnouncementListItem> createState() => _AnnouncementItemState();
}

class _AnnouncementItemState extends State<AnnouncementListItem> {
  late bool invited;

  @override
  void initState() {
    super.initState();
    invited = widget.invited;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow:
            ProgramConstants.getDefaultBoxShadow(context, smallShadow: true),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(4),
      child: Theme(
        data: ThemeData().copyWith(
          dividerColor: Colors.transparent,
        ), //removes outlined when activated
        child: ExpansionTile(
          title: Text(
            _getTitleText(),
            style: Theme.of(context).textTheme.bodyText2,
          ),
          leading: CircularButtonInListItem(
            buttonType: CircularButtonInListItem.profileButton,
            onTap: () {
              //TODO: Profile
            },
          ),
          tilePadding: const EdgeInsets.symmetric(horizontal: 4),
          childrenPadding: const EdgeInsets.symmetric(horizontal: 4),
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox.square(dimension: 5),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Message"),
                  ),
                ),
                const SizedBox.square(dimension: 10),
                invited
                    ? const Expanded(
                        child: Text(
                        "Invited",
                        textAlign: TextAlign.center,
                      ))
                    : Expanded(
                        child: ElevatedButton(
                        onPressed: () {
                          //TODO: invite
                          setState(() {
                            invited = true;
                          });
                        },
                        child: const Text("Invite"),
                      )),
                const SizedBox.square(dimension: 5),
              ],
            )
          ],
        ),
      ),
    );
  }

  String _getTitleText() {
    if (widget.playerAnnouncement.forTeam) {
      return '${widget.playerAnnouncement.announcer.fullName} is looking for ${widget.playerAnnouncement.positions.toString().substring(1, widget.playerAnnouncement.positions.toString().length - 1)} for team ${widget.playerAnnouncement.teamModel!.name}.';
    } else {
      return '${widget.playerAnnouncement.announcer.fullName} is looking for ${widget.playerAnnouncement.positions.toString().substring(1, widget.playerAnnouncement.positions.toString().length - 1)}.';
    }
  }
}