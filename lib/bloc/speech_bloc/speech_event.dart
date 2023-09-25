abstract class SpeechEvent {}

class StartListening extends SpeechEvent {}

class StopListening extends SpeechEvent {}

class ReceivedSpeech extends SpeechEvent {
  final String text;
  ReceivedSpeech(this.text);
}
