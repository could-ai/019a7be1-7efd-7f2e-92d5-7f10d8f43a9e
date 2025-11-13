class UserProfile {
  final String id;
  final String name;
  final int age;
  final String bio;
  final int distance;
  final List<String> photos;
  final List<String> interests;

  UserProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.bio,
    required this.distance,
    required this.photos,
    required this.interests,
  });
}