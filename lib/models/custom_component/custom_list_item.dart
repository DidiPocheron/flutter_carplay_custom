import 'package:uuid/uuid.dart';

/// A selectable list item object that appears in a list template.
class CustomCPListItem {
  /// Unique id of the object.
  final String _elementId = const Uuid().v4();

  /// Text displayed in the list item cell.
  String text;

  /// Secondary text displayed below the primary text in the list item cell.
  String? detailText;

  /// An optional callback function that CarPlay invokes when the user selects the list item.
  final Function(Function() complete, CustomCPListItem self)? onPress;

  /// Displays an image on the leading edge of the list item cell.
  /// Image asset path in pubspec.yaml file.
  /// For example: images/flutter_logo.png
  String? image;

  /// Playback progress status for the content that the list item represents.
  double? playbackProgress;

  /// Determines whether the list item displays its Now Playing indicator.
  bool? isPlaying;

  /// Creates [CPListItem] that manages the content of a single row in a [CPListTemplate].
  /// CarPlay manages the layout of a list item and may adjust its layout to allow for
  /// the display of auxiliary content, such as, an accessory or a Now Playing indicator.
  /// A list item can display primary text, secondary text, now playing indicators as playback progress,
  /// an accessory image and a trailing image.
  CustomCPListItem({
    required this.text,
    this.detailText,
    this.onPress,
    this.image,
    this.playbackProgress,
    this.isPlaying,
  });

  Map<String, dynamic> toJson() => {
        "_elementId": _elementId,
        "text": text,
        "detailText": detailText,
        "onPress": onPress != null ? true : false,
        "image": image,
        "playbackProgress": playbackProgress,
        "isPlaying": isPlaying,
      };

  String get uniqueId {
    return _elementId;
  }
}
