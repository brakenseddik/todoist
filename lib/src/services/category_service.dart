import 'package:todoist/src/models/category.dart';
import 'package:todoist/src/repositories/repository.dart';

class CategoryService {
  Repository _repository;
  CategoryService() {
    _repository = Repository();
  }
  saveCategory(Category category) async {
    return await _repository.save('categories', category.categoryMap());
  }

  getCategories() async {
    return await _repository.getALL('categories');
  }

  getCategoryById(categoryId) async {
    return await _repository.getCategoryId('categories', categoryId);
  }

  updateCategory(Category category) async {
    return await _repository.update('categories', category.categoryMap());
  }

  removeCategory(categoryId) async {
    return await _repository.remove('categories', categoryId);
  }
}
