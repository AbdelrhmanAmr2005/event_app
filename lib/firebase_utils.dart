import 'package:assignment/model/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventsCollection() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore:
              (snapshot, options) => Event.fromFireStore(snapshot.data()!),
          toFirestore: (event, options) => event.toFireStore(),
        );
  }

  static Future<void> addEventsToFireStore(Event event) {
    var eventsCollection = getEventsCollection();
    DocumentReference<Event> docRef = eventsCollection.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }
}
