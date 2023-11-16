class Quiz {
  String name, imageAsset;
  int questionNum;

  Quiz(
      {required this.name,
      required this.imageAsset,
      required this.questionNum});
}

var quizez = [
  Quiz(name: 'Linux', imageAsset: 'assets/images/linux.jpg', questionNum: 10),
  Quiz(
      name: 'DevOps', imageAsset: 'assets/images/devops.webp', questionNum: 10),
  Quiz(
      name: 'Kubernetes',
      imageAsset: 'assets/images/kubernetes.png',
      questionNum: 10),
  Quiz(
      name: 'Programming',
      imageAsset: 'assets/images/programming.jpg',
      questionNum: 10),
  Quiz(
      name: 'Docker', imageAsset: 'assets/images/docker.webp', questionNum: 10),
  Quiz(name: 'SQL', imageAsset: 'assets/images/sql.jpg', questionNum: 10)
];
