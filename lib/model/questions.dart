class Question {
  String name, imageAsset;
  int questionNum;

  Question(
      {required this.name,
      required this.imageAsset,
      required this.questionNum});
}

var questions = [
  Question(name: 'Linux', imageAsset: 'assets/images/linux.jpg', questionNum: 10),
  Question(name: 'DevOps', imageAsset: 'assets/images/devops.webp', questionNum: 10),
  Question(name: 'Kubernetes', imageAsset: 'assets/images/kubernetes.png', questionNum: 10),
  Question(name: 'Programming', imageAsset: 'assets/images/programming.jpg', questionNum: 10),
  Question(name: 'Docker', imageAsset: 'assets/images/docker.webp', questionNum: 10),
  Question(name: 'SQL', imageAsset: 'assets/images/sql.jpg', questionNum: 10)
];
