const String categoryId = "id";
const String categoryName = "name";
const String categoryProductCount = "categoryCount";
const String categoryAvailable = "available";

class CategoryModel {
  String? catId;
  String? catName;
  num categoryCount;
  bool available;

  CategoryModel({
    this.catId,
    this.catName,
    this.categoryCount = 0,
    this.available = true,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      categoryId: catId,
      categoryName: catName,
      categoryProductCount : categoryCount,
      categoryAvailable : available,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) => CategoryModel(
    catId: map[categoryId],
    catName: map[categoryName],
    categoryCount: map[categoryProductCount],
    available : map[categoryAvailable],

  );
}
