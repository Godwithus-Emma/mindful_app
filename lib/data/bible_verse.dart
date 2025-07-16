
class BibleVerse {
  final String text;

  BibleVerse({
    required this.text,
  });

  BibleVerse.fromJson(Map<String, dynamic> json)
      : text = (json['text'] ?? '').replaceAll(RegExp(r'<S>\d+</S>'), '');
}
    //json['text'].replaceAll(RegExp(r'<S>\d+</S>');
  //  {
  //   final String cleanedText = json['text'].replaceAll(RegExp(r'<S>\d+</S>'), '');

  //   return BibleVerse(
  //     //pk: json['pk'],
  //     text: cleanedText,
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'text': text,
  //   };
  // }
//}