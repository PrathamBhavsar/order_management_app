import '../../../data/repositories/category_repository.dart';

class GetLocalCategoriesUseCase {
  final CategoryRepository repository;

  GetLocalCategoriesUseCase(this.repository);

  Future<List<String>> execute() async =>
      await repository.getCategoriesFromDB();
}
