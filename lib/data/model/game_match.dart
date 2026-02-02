class GameMatch {
  final String id;
  final String locationName;
  final String imageUrl;
  final String dateTime;
  final String skillLevel;
  final int currentPlayers;
  final int maxPlayers;
  final double price;
  final GameHost host;
  final bool isFull;
  final String sport; // 'badminton' or 'pickleball'

  GameMatch({
    required this.id,
    required this.locationName,
    required this.imageUrl,
    required this.dateTime,
    required this.skillLevel,
    required this.currentPlayers,
    required this.maxPlayers,
    required this.price,
    required this.host,
    required this.isFull,
    required this.sport,
  });

  bool get hasAvailableSlots => currentPlayers < maxPlayers;
}

class GameHost {
  final String id;
  final String name;
  final String avatarUrl;
  final bool isVerified;

  GameHost({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.isVerified = false,
  });
}
