import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'speech_event.dart';
import 'speech_state.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:fluttertoast/fluttertoast.dart';


class SpeechBloc extends Bloc<SpeechEvent, SpeechState> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts flutterTts = FlutterTts();

  SpeechBloc() : super(SpeechState(status: SpeechStatus.notListening)) {
    on<StartListening>(_mapStartListeningEventToState);
    on<StopListening>(_mapStopListeningEventToState);
    on<ReceivedSpeech>(_mapReceivedSpeechEventToState);
  }

  void _mapStartListeningEventToState(StartListening event, Emitter<SpeechState> emit) async {
    await flutterTts.stop();

    bool available = await _speech.initialize();
    if (available) {
      Fluttertoast.showToast(msg: "Start listening");
      await flutterTts.speak("Start listening");
      await Future.delayed(Duration(seconds: 1));
      _speech.listen(onResult: (result) {
        add(ReceivedSpeech(result.recognizedWords));
      });
      emit(state.copyWith(status: SpeechStatus.listening));

    } else {
      emit(state.copyWith(status: SpeechStatus.error));
    }
  }

  void _mapStopListeningEventToState(StopListening event, Emitter<SpeechState> emit) async {
    await _speech.stop();
    emit(state.copyWith(status: SpeechStatus.notListening));
    Fluttertoast.showToast(msg: "Stopped listening");
    await flutterTts.speak("Stopped listening");

  }
  void _mapReceivedSpeechEventToState(ReceivedSpeech event, Emitter<SpeechState> emit) {
    emit(state.copyWith(status: SpeechStatus.receivedSpeech, text: event.text));
    print(event.text);
    //Fluttertoast.showToast(msg: event.text);
  }
}
