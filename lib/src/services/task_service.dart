import 'package:todoist/src/models/task.dart';
import 'package:todoist/src/repositories/repository.dart';

class TaskService {
  Repository _repository;
  TaskService() {
    _repository = Repository();
  }
  insertTask(Task task) async {
    return await _repository.save('tasks', task.taskMap());
  }

  getTasks() async {
    return await _repository.getALL('tasks');
  }

  getTaskByCategory(String category) async {
    return await _repository.getTaskByCategory('tasks', 'category', category);
  }
}
