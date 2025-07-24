class Event {
  static const String collectionName = 'Events';
  String id;
  String image;
  String title;
  String description;
  String eventName;
  DateTime dateTime;
  String time;
  bool isFavorite;

  Event({
    this.id = '',
    required this.dateTime,
    required this.description,
    required this.eventName,
    required this.image,
    required this.time,
    required this.title,
    this.isFavorite = false,
  });

  Event.fromFireStore(Map<String, dynamic> data)
    : this(
        dateTime: DateTime.fromMillisecondsSinceEpoch(data["dataTime"]),
        description: data["description"],
        eventName: data["eventName"],
        image: data["image"],
        time: data["time"],
        title: data["title"],
        id: data["id"],
        isFavorite: data["isFavorite"],
      );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'eventName': eventName,
      'dataTime': dateTime.millisecondsSinceEpoch,
      'time': time,
      'isFavorite': isFavorite,
    };
  }
}
