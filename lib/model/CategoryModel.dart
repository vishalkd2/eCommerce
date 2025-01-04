

class CategoryModel{
  int id;
  String name;
  String image;

  CategoryModel({required this.id,required this.name,required this.image});

  factory CategoryModel.fromJson(Map<String,dynamic>json){
    return  CategoryModel(
        id: json['id'],
        name: json['name'],
        image: json['image']);
  }
  @override
  String toString() {
    return 'CategoryModel(id: $id, name: $name, image: $image)';
  }
}

