// summary: Handles all Firestore reads/writes for coin flips.
import 'package:cloud_firestore/cloud_firestore.dart';

class FlipService {
  final _db = FirebaseFirestore.instance;
  final _col = 'flips';

  /// Stream of all flip docs, ordered by timestamp.
  Stream<QuerySnapshot<Map<String, dynamic>>> watchFlips() {
    return _db
        .collection(_col)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  /// Add a new flip record.
  Future<void> addFlip(bool isHeads) {
    return _db.collection(_col).add({
      'result': isHeads ? 'heads' : 'tails',
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
// summary: Handles all Firestore reads/writes for coin flips.
