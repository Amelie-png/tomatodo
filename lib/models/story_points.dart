class StoryPoints {
  final int timePoints;
  final int complexityPoints;
  final int urgencyPoints;

  const StoryPoints(
    {this.timePoints = 3,
    this.complexityPoints = 3,
    this.urgencyPoints = 3}
  );

  StoryPoints copyWith({
    int? timePoints,
    int? complexityPoints,
    int? urgencyPoints
  }) {
    return StoryPoints(
      timePoints: timePoints ?? this.timePoints,
      complexityPoints: complexityPoints ?? this.complexityPoints,
      urgencyPoints: urgencyPoints ?? this.urgencyPoints
    );
  }

  int get total => timePoints + complexityPoints + urgencyPoints;
}