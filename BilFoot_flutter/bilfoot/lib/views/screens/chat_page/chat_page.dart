import 'package:bilfoot/data/models/conversation_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/views/screens/chat_page/widgets/chat_app_bar.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  // final ConversationModel conversationModel;

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  var isSubmitted = false;
  TextEditingController textEditingController = TextEditingController();
  late ConversationModel conversationModel;

  @override
  void initState() {
    super.initState();

    conversationModel = ConversationModel(
      members: [Program.program.dummyPlayer1, Program.program.dummyPlayer2],
      messages: [
        MessageModel(
          fromMail: "serhat.merak@ug.bilkent.edu.tr",
          content: "Deneme bir dummy mesajı",
          date: DateTime.now(),
        ),
        MessageModel(
          fromMail: "serhat.merak@ug.bilkent.edu.tr",
          content: "Gönderen serhat merak",
          date: DateTime.now(),
        ),
        MessageModel(
          fromMail: "ayberk.senguder@ug.bilkent.edu.tr",
          content: "Deneme bir response",
          date: DateTime.now(),
        ),
        MessageModel(
          fromMail: "ayberk.senguder@ug.bilkent.edu.tr",
          content: "Gönderen ayberk şengüder",
          date: DateTime.now(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(
          playerModel: conversationModel.members.firstWhere(
              (element) => element.email != Program.program.user!.email)),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: _getMessages()),
              const Divider(),
              _getTextBar(),
            ],
          )),
    );
  }

  Widget _getTextBar() {
    const double height = 35;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(minHeight: height, maxHeight: 150),
              child: Scrollbar(
                child: TextField(
                  controller: textEditingController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: Theme.of(context).textTheme.headline5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    hintText: "Mesajını yaz",
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox.square(dimension: 5),
          _getSendButton(height)
        ],
      ),
    );
  }

  Widget _getSendButton(double height) {
    return InkWell(
      onTap: () async {
        if (textEditingController.value.text.isNotEmpty) {
          // context
          //     .read<ChatBloc>()
          //     .add(ChatSendMessage(text: textEditingController.value.text));
          setState(() {
            textEditingController.text = "";
          });
        }
      },
      child: Container(
          width: height,
          height: height,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          margin: EdgeInsets.zero,
          child: const Icon(
            Icons.send,
            size: 16,
            color: Colors.white,
          )),
    );
  }

  final ScrollController _scrollController = ScrollController();

  Widget _getMessages() {
    //SingleChildScrollView is not a good idea to use in a chat app but
    //There won't be a huge message history so it is not a big problem
    return SingleChildScrollView(
      controller: _scrollController,
      child: Builder(
        builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            if (_scrollController.position.viewportDimension <
                _scrollController.position.maxScrollExtent) {
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
              );
            }
          });
          return Column(
            children: [
              ...List.generate(
                conversationModel.messages.length,
                (index) => ChatBubble(
                  isContinuation: index == 0
                      ? false
                      : conversationModel.messages[index].fromMail ==
                          conversationModel.messages[index - 1].fromMail,
                  isOwnMessage: conversationModel.messages[index].fromMail ==
                      Program.program.user!.email,
                  content: conversationModel.messages[index].content,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String content;
  final bool isContinuation;
  final bool isOwnMessage;

  const ChatBubble({
    Key? key,
    this.content = "",
    this.isContinuation = false,
    this.isOwnMessage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment:
              isOwnMessage ? Alignment.centerRight : Alignment.centerLeft,
          child: _getContent(content: content, context: context),
        ),
      ],
    );
  }

  Widget _getContent({required String content, required BuildContext context}) {
    double maxWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(
          left: 16, right: 16, bottom: 0, top: isContinuation ? 8 : 16),
      padding: const EdgeInsets.all(16),
      width: maxWidth * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: isOwnMessage
            ? Theme.of(context).primaryColor
            : Theme.of(context).colorScheme.secondary,
      ),
      child: Text(
        content,
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(height: 1.2, color: Colors.white),
        softWrap: true,
        textAlign: TextAlign.left,
      ),
    );
  }
}
