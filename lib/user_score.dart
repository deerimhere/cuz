class UserScore {
  final String nickname;
  final int points;
  final int apples;

  UserScore(this.nickname, this.points, this.apples);

  // Firestore에서 데이터를 저장하고 로드할 수 있도록 Map으로 변환하는 메서드
  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'points': points,
      'apples': apples,
    };
  }

  // Firestore에서 데이터를 로드할 때 Map을 UserScore 객체로 변환하는 메서드
  factory UserScore.fromMap(Map<String, dynamic> map) {
    return UserScore(
      map['nickname'],
      map['points'],
      map['apples'],
    );
  }
}
