import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_call_app/modules/sign/cubit/cubit.dart';
import 'package:video_call_app/modules/videoCall/VideoLayout.dart';
import 'package:video_call_app/modules/videoCall/ils_screen.dart';
import 'package:video_call_app/shared/components/components.dart';
import 'package:video_call_app/shared/cubit/states.dart';
import 'package:videosdk/videosdk.dart';

import '../shared/cubit/cubit.dart';
import '../shared/network/videoCall_api/videoCallAPI.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            body: Center(
              child: defaultButton(
                  function: () {
                    navigateAndFinish(context, VideoCallLayout());
                  },
                  text: 'video call'),
            ),
          );
        },
      ),
    );
  }
}
