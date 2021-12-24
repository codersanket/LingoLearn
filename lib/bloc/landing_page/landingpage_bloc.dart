import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apppl/data/models/SpeechData.dart';
import 'package:flutter_apppl/data/repository/get_data_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

part 'landingpage_event.dart';

part 'landingpage_state.dart';

class LandingPagebloc extends Bloc<LandingPageEvent, LandingpageState> {
  GetDataRepo repo = GetDataRepo();
  bool p = true;
  bool play = false;

  LandingPagebloc({@required repo}) : super(InitLanadingPageState());

  LandingpageState get initialState => InitLanadingPageState();

  late stt.SpeechToText speech;
  bool isListening = false;
  String text = 'Press the button and start speaking';

  initializeSpeech() {
    speech = stt.SpeechToText();
  }

  Stream<LandingpageState> mapEventToState(LandingPageEvent event) async* {
    if (event is Stop) {
      isListening = false;
      speech.stop();

      yield InitLanadingPageState();
    }
    if (event is ListenVoice){
      yield Listening();
      if (!isListening) {
        bool available = await speech.initialize(
          onStatus: (val) => print('onStatus: $val'),
          onError: (val) => print('onError: $val'),
        );
        if (available) {
          isListening = true;
          speech.listen(
              onResult: (val) {
            text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {

            }
            print("the text is" + text);
          });
        }
      } else {
        isListening = false;
        speech.stop();
      }
      print("start");
      print(text);
      await Future.delayed(const Duration(seconds: 5), () {

      });

      print("end");
      try {
        SpeechData data = await repo.getData(text.toString());
        yield ListenVoiceState(name: data.word,
            meaning: data.definitions!.first.definition.toString(),
            example: data.definitions!.first.example.toString(),
            imageUrl: data.definitions!.first.imageUrl.toString());
      }
      catch(e){
        isListening = false;
        speech.stop();
        yield ErrorLandingPage();
      }
      }
  }
}
