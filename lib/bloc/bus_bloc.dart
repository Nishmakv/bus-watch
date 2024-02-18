import 'package:bus_proj/bloc/bus_state.dart';
import 'package:bus_proj/repositories/bus_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusBloc extends Cubit<BusState> {
  BusBloc() : super(const BusInitial());

  final BusRepository _busRepository = BusRepository();
  TextEditingController originController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController vehicleController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List routesData = [];
  List vehiclesData = [];


  Future<void> getRoutes() async {
    if(formKey.currentState!.validate()) return;
    emit(const BusLoading());
    try {
      final routes = await _busRepository.getRoutes( origin: originController.text, destination: destinationController.text);
      routesData = routes;
      emit(const BusLoaded());
    } catch (e) {
      emit(BusError(e.toString()));
    }
  }

  Future<void> getRoutesfromVehicle() async {
    emit(const BusLoading());
    try {
      final vehicles = await _busRepository.getRoutesfromVehicle(vechicle: vehicleController.text);
      vehiclesData = vehicles;
      emit(const BusLoaded());
    } catch (e) {
      emit(BusError(e.toString()));
    }
  }
}