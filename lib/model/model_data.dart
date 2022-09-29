class ModelClass {
  String? name;
  String? email;
  String? age;
  String? image;
  String? address;

  ModelClass({
    this.name,
    this.email,
    this.image,
    this.age,
    this.address,
  });

  factory ModelClass.fromJson(Map<String, dynamic> json) => ModelClass(
      email: json["email"],
      name: json["name"],
      age: json["age"],
      image: json["image"],
      address: json["address"]);

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "name": name,
      "age": age,
      "image": image,
      "address": address
    };
  }
}
