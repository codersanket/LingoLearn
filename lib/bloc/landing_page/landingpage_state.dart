part of 'landingpage_bloc.dart';

abstract class LandingpageState {}

class InitLanadingPageState extends LandingpageState {}

class FetchLandingPageState extends LandingpageState {
  final List<SpeechData>? data;

  FetchLandingPageState({this.data});
}

class ErrorLandingPage extends LandingpageState {}
class Listening extends LandingpageState {}
class ListenVoiceState extends LandingpageState{
  String? name;
  String? meaning;
  String? example;
  String? imageUrl;
  ListenVoiceState({this.name, this.meaning,this.example,this.imageUrl});
}