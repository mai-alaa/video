// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_call_app/shared/cubit/states.dart';
import 'package:video_call_app/shared/network/videoCall_api/videoCallAPI.dart';
import 'package:videosdk/videosdk.dart';
import '../../modules/videoCall/ils_screen.dart';
import '../components/components.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  // ignore: avoid_types_as_parameter_names
  void onCreateButtonPressed(BuildContext context) async {
    // call api to create meeting and navigate to ILSScreen with meetingId,token and mode
    await createMeeting().then((meetingId) {
      if (!context.mounted) return;
      navigateAndFinish(
          context,
          ILSScreen(
            meetingId: meetingId,
            token: token,
            mode: Mode.CONFERENCE,
          ));
    });
  }

  final meetingIdController = TextEditingController();
  //Join the provided meeting with given Mode and meetingId
  void onJoinButtonPressed(BuildContext context, Mode mode) {
    // check meeting id is not null or invaild
    // if meeting id is vaild then navigate to ILSScreen with meetingId, token and mode
    String meetingId = meetingIdController.text;
    var re = RegExp("\\w{4}\\-\\w{4}\\-\\w{4}");
    if (meetingId.isNotEmpty && re.hasMatch(meetingId)) {
      meetingIdController.clear();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ILSScreen(
            meetingId: meetingId,
            token: token,
            mode: mode,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please enter valid meeting id"),
      ));
    }
  }

  void initiateRandomVideoCall(BuildContext context, String meetingId) async {
    // Check if any volunteers are available
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('volunteers')
        .where('availability', isEqualTo: true)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Randomly select a volunteer
      final DocumentSnapshot randomVolunteer =
          snapshot.docs[Random().nextInt(snapshot.docs.length)];

      // Get the volunteer's user ID
      final String volunteerId = randomVolunteer.id;

      // Initiate the video call
      try {
        final Room videoRoom = await VideoSDK.createRoom(
            roomId: meetingId, token: token, displayName: 'User');

        final String roomId = videoRoom.id;

        // Store the roomId and volunteerId in Firestore or any other database
        await FirebaseFirestore.instance
            .collection('Video Call')
            .doc('Video Call Id')
            .set({
          'roomId': roomId,
          'volunteerId': volunteerId,
        }); // to establish a connection between the user and the volunteer

        // TODO: Navigate to the video call screen and pass the roomId and volunteerId
        navigateAndFinish(
            context,
            ILSScreen(
              meetingId: meetingId,
              token: token,
              mode: Mode.CONFERENCE,
            ));
      } catch (error) {
        emit(AppErrorState(error.toString()));
        print('Error creating video room: $error');
      }
    } else {
      // No volunteers available, display a message to the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // ignore: prefer_const_constructors
            title: Text('No Volunteer Available'),
            content: const Text(
                'Currently, no volunteer is available. You can create a meeting instead.'),
            actions: [
              TextButton(
                onPressed: () async {
                  // TODO: Implement meeting creation logic
                  await createMeeting().then((meetingId) {
                    navigateAndFinish(
                        context,
                        ILSScreen(
                          meetingId: meetingId,
                          token: token,
                          mode: Mode.CONFERENCE,
                        ));
                  });
                },
                child: Text('Create Meeting'),
              ),
            ],
          );
        },
      );
    }
  }
}
