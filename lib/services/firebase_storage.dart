import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scenario_maker_up/models/scenario_result_model.dart';
import 'package:scenario_maker_up/services/auth.dart';

class FirebaseStorage {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Сохранение сценария в коллекцию пользователя
  Future<void> saveScenario(ScenarioResultModel scenarioResult) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }
    await _db
        .collection(user.uid)
        .doc(scenarioResult.id)
        .set(scenarioResult.toJSON());
  }

  // Удаление сценария по id
  Future<void> deleteScenario(String documentId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }
    String userId = user.uid;

    if (userId != null) {
      await _db.collection(userId).doc(documentId).delete();
    } else {
      throw Exception('User not authenticated');
    }
  }

  // Получение стрима всех сценариев пользователя
  Stream<List<ScenarioResultModel>> getScenariosStream() {
    String? userId = Auth().getCurrentUserId;

    if (userId != null) {
      return _db
          .collection(userId)
          .snapshots()
          .map(
            (snapshot) =>
                snapshot.docs.map((doc) {
                  return ScenarioResultModel.fromJSON(doc.data());
                }).toList(),
          );
    } else {
      throw Exception('User not authenticated');
    }
  }
}
