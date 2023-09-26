enum SpeechStatus { notListening, listening, receivedSpeech, error }

class SpeechState {
  final SpeechStatus status;
  final String text;

  SpeechState({required this.status, this.text = ''});

  SpeechState copyWith({
    SpeechStatus? status,
    String? text,
  }) {
    return SpeechState(
      status: status ?? this.status,
      text: text ?? this.text,
    );
  }

  // Add a reset function
  SpeechState resetText() {
    return SpeechState(status: this.status, text: '');
  }
}
