import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_call_app/shared/components/components.dart';
import 'package:video_call_app/shared/cubit/cubit.dart';
import 'package:video_call_app/shared/cubit/states.dart';
import 'package:videosdk/videosdk.dart';

class VideoCallLayout extends StatelessWidget {
  const VideoCallLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  children: [
                    defaultButton(
                        function: () => AppCubit.get(context)
                            .initiateRandomVideoCall(context),
                        text: 'Random Video Call'),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultButton(
                        function: () => cubit.onCreateButtonPressed(context),
                        text: 'Create Meeting'),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Enter Meeting Id',
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      controller: cubit.meetingIdController,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultButton(
                        function: () => AppCubit.get(context)
                            .onJoinButtonPressed(context, Mode.CONFERENCE),
                        text: 'Join Meeting as Viewer'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
