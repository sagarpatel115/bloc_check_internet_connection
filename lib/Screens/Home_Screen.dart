
import 'package:bloc_check_internet_connection/blocs/internet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/internet_state.dart';


class HomeScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(child: Center(
      child:
      BlocConsumer<InternetBloc, InternetState>(
        listener: (context, state) {
        if(state is InternetGainedState){
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Internet Connected"),backgroundColor: Colors.green,));
          }else if(state is InternetLostState){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Internet Connection"),backgroundColor: Colors.red,));
          }else{
             //return Text('loading....');
          }
        },
        builder: (context, state) {
          if(state is InternetGainedState){
              return Text('Connected');
          }else if(state is InternetLostState){
              return Text('Not Connected');
          }else{
             return Text('loading....');
          }
        },
      )
      
      )),
    );
  }
}

