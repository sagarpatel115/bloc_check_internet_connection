
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_check_internet_connection/blocs/internet_event.dart';
import 'package:bloc_check_internet_connection/blocs/internet_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class InternetBloc extends Bloc<InternetEvent,InternetState> {
  
  Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription ;

   InternetBloc() : super(InternetIntitalState()){

     on<InternetLostEvent>((event,state)=> emit(InternetLostState()));
     on<InternetGainedEvent>((event,state)=> emit(InternetGainedState()));

   connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
       if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi ){
         add(InternetGainedEvent());
       }else{
         add(InternetLostEvent());
       }
    });

   }

   @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }

  
}