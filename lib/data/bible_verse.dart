
class BibleVerse {
  final String text;
  int? id;

  BibleVerse({
    required this.text,
  });

  BibleVerse.fromMap(Map<String, dynamic> json)
      : text = (json['text'] ?? '').replaceAll(RegExp(r'<sup>\d+</sup>'), '').replaceAll(RegExp(r'<S>\d+</S>'), '');

    //json['text'].replaceAll(RegExp(r'<S>\d+</S>');
  //  {
  //   final String cleanedText = json['text'].replaceAll(RegExp(r'<S>\d+</S>'), '');

  //   return BibleVerse(
  //     //pk: json['pk'],
  //     text: cleanedText,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
    };
  }
}