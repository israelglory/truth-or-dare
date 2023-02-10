// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:t_or_d/components/bottom_chat.dart';

import 'package:t_or_d/components/chat_app_bar.dart';
import 'package:t_or_d/components/chat_bubbles.dart';
import 'package:t_or_d/features/chat_screen/chat_screen_viewmodel.dart';
import 'package:t_or_d/models/message_chat.dart';
import 'package:t_or_d/models/t_or_d_models/latest_question_model.dart';
import 'package:t_or_d/routes/exports.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  //String link;
  //String name;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatScreenViewModel>(
      init: ChatScreenViewModel(),
      builder: (controller) {
        return Scaffold(
          appBar: ChatAppBar(
            roomName: 'Cruise Land',
            chatId: controller.currentUser.currentRoomId,
          ),
          body: SafeArea(
            top: true,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.all(12.0),
                  child: Center(
                    child: StreamBuilder(
                      stream: controller.chatService.getlatestQuestionStream(
                        controller.currentUser.currentRoomId,
                      ),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
                        LatestQuestion content =
                            LatestQuestion.fromDocument(snapshot.data!);
                        return AppText(
                          content.content,
                          size: 16,
                          alignment: TextAlign.center,
                          fontWeight: FontWeight.w500,
                        );
                      },
                    ),
                  ),
                ),
                /*Expanded(
                  child: _DemoMessageList(),
                ),*/
                Flexible(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: controller.chatService.getChatStream(
                        controller.currentUser.currentRoomId, controller.limit),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        controller.listMessage = snapshot.data!.docs;
                        if (controller.listMessage.isNotEmpty) {
                          return ListView.separated(
                            padding: const EdgeInsets.all(10),
                            itemBuilder: (context, index) {
                              MessageChat messageChat =
                                  MessageChat.fromDocument(snapshot
                                      .data?.docs[index] as DocumentSnapshot);
                              print(messageChat.timestamp);
                              final time =
                                  Jiffy(messageChat.timestamp).format('h:mm a');
                              return TextMessage(
                                isUser: messageChat.idFrom ==
                                    controller.currentUser.uId,
                                message: messageChat.content,
                                time: time,
                              );
                            },
                            itemCount: snapshot.data!.docs.length,
                            reverse: true,
                            controller: controller.listScrollController,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 5,
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: Text(
                              "No message here yet...",
                            ),
                          );
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Wrap(
                      spacing: 8.0,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            await controller.getAndSendQuestion('truth');
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AppColors.primaryColor),
                            child: AppText(
                              'Truth',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await controller.getAndSendQuestion('wyr');
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AppColors.primaryColor),
                            child: AppText(
                              'Would You Rather',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await controller.getAndSendQuestion('nhie');
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AppColors.primaryColor),
                            child: AppText(
                              'Never Have I Ever',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                BottomChat(
                  onPressed: () {
                    controller.onSendMessage(
                        controller.textEditingController.text, 0);
                  },
                  txt: controller.textEditingController,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DemoMessageList extends StatelessWidget {
  const _DemoMessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: const [
          _DateLable(lable: 'Yesterday'),
          TextMessage(
            isUser: false,
            time: '10:00Pm',
            message: 'Hi, Lucy! How\'s your day going?',
          ),
          TextMessage(
            isUser: true,
            time: '10:00Pm',
            message: 'Hi, Lucy! How\'s your day going?',
          ),
          TextMessage(
            isUser: false,
            time: '10:00Pm',
            message: 'Hi, Lucy! How\'s your day going?',
          ),
          TextMessage(
            isUser: true,
            time: '10:00Pm',
            message: 'Hi, Lucy! How\'s your day going?',
          ),
          TextMessage(
            isUser: false,
            message: 'Hello this my new widget',
            time: '2:00 PM',
          ),
          TextMessage(
            isUser: true,
            time: '10:00Pm',
            message: 'Hi, Lucy! How\'s your day going?',
          ),
        ],
      ),
    );
  }
}

class _DateLable extends StatelessWidget {
  const _DateLable({
    Key? key,
    required this.lable,
  }) : super(key: key);

  final String lable;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
            child: Text(
              lable,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textFieldBackgroundColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: const Icon(CupertinoIcons.back),
            color: Colors.blue,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: 
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: IconButton(
                icon: const Icon(CupertinoIcons.video_camera_solid),
                onPressed: () {},
                color: Colors.blue,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: IconButton(
                icon: const Icon(CupertinoIcons.phone_solid),
                onPressed: () {},
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),*/
