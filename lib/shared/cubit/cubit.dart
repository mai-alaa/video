// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_call_app/shared/cubit/states.dart';
import 'package:video_call_app/shared/network/videoCall_api/videoCallAPI.dart';
import 'package:videosdk/videosdk.dart';
import '../../modules/videoCall/ils_screen.dart';
import '../components/components.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  Future<String?> getRandomVolunteer() async {
    // Get all users from Firestore with the role 'volunteer'
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'volunteer')
        .get();

    List<QueryDocumentSnapshot> volunteers = snapshot.docs;
    if (volunteers.isNotEmpty) {
      // Select a random volunteer
      final random = Random();
      QueryDocumentSnapshot randomVolunteer =
          volunteers[random.nextInt(volunteers.length)];
      String volunteerId = randomVolunteer.id;
      return volunteerId;
    } else {
      return null;
    }
  }

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

  void startRandomVideoCall(BuildContext context) async {
    final String? volunteerId = await getRandomVolunteer();
    if (volunteerId != null) {
      // Use the volunteerId to initiate the video call with the selected volunteer using the videosdk package
      // Add your video call logic here
      onCreateButtonPressed(context);
      print('Initiating video call with volunteer ID: $volunteerId');
    } else {
      // Handle case when no volunteers are available
      // For example, show an error message to the user
      print('No volunteers available');
    }
  }
}
