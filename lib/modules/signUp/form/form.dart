import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_call_app/modules/home.dart';
import 'package:video_call_app/shared/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class FormRole extends StatelessWidget {
  const FormRole({Key? key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context) => SelectedRoleCubit(),
      child: BlocConsumer<SelectedRoleCubit, SelectRoleStates>(
        listener: (BuildContext context, state) {
          if (state is SelectedRolSubmittedState) {
            navigateAndFinish(context, HomeScreen());
          }
        },
        builder: (BuildContext context, Object? state) {
          SelectedRoleCubit cubit = SelectedRoleCubit.get(context);

          return Scaffold(
            body: Form(
              key: formKey,
              child: Container(
                color: const Color.fromARGB(255, 241, 152, 182),
                child: Center(
                  child: Column(
                    children: [
                      const Image(image: AssetImage('assets/gp-logo copy.png')),
                      const SizedBox(height: 16),
                      const Text(
                        'Select Your Role !',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Color.fromARGB(255, 6, 2, 124),
                        ),
                      ),
                      const SizedBox(height: 16),
                      RadioListTile(
                        title: const Text('Desisted'),
                        value: 'Desisted',
                        groupValue: cubit.role,
                        onChanged: (value) => cubit.selectRole(role: value),
                      ),
                      const SizedBox(height: 16),
                      RadioListTile(
                        title: const Text('Volunteer'),
                        value: 'Volunteer',
                        groupValue: cubit.role,
                        onChanged: (value) => cubit.selectRole(role: value),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
