
class Character {
  late int charId;
  late String Name;
  late String StatusIfDeadOrAlive;
  late String Species;
  late String Type;
  late String Gender;
  late String Location;
  late String Image;
  late List<String> EpisodeAppearance;

  Character({
    required this.charId,
    required this.Name,
    required this.StatusIfDeadOrAlive,
    required this.Species,
    required this.Type,
    required this.Gender,
    required this.Location,
    required this.Image,
    required this.EpisodeAppearance,
  });

  Character.fromJson(Map<String, dynamic> json) {
    charId = json["id"] ?? 0;
    Name = json["name"] ?? "Unknown";
    StatusIfDeadOrAlive = json["status"] ?? "Unknown";
    Species = json["species"] ?? "Unknown";
    Type = json["type"] ?? "";
    Gender = json["gender"] ?? "Unknown";
    Location = json["location"]?["name"] ?? "Unknown";
    Image = json["image"];
    EpisodeAppearance = List<String>.from(json["episode"] ?? []);
  }
}
