class Quiz {
  String name, imageAsset;
  int questionNum;

  Quiz(
      {required this.name,
      required this.imageAsset,
      required this.questionNum});
}

var quizez = [
  Quiz(name: 'HTML', imageAsset: 'assets/images/html.png', questionNum: 10),
  Quiz(name: 'JavaScript', imageAsset: 'assets/images/javascript.png', questionNum: 10),
  Quiz(name: 'PHP', imageAsset: 'assets/images/php.png', questionNum: 10),
  Quiz(name: 'Laravel', imageAsset: 'assets/images/laravel.png', questionNum: 10),
  Quiz(name: 'Wordpress', imageAsset: 'assets/images/wordpress.png', questionNum: 10),
  Quiz(name: 'DevOps', imageAsset: 'assets/images/devops.png', questionNum: 10),
  Quiz(name: 'Docker', imageAsset: 'assets/images/docker.jpg', questionNum: 10),
  Quiz(name: 'Kubernetes', imageAsset: 'assets/images/kubernetes.png', questionNum: 10),
  Quiz(name: 'Linux', imageAsset: 'assets/images/linux.png', questionNum: 10),
  Quiz(name: 'SQL', imageAsset: 'assets/images/sql.jpg', questionNum: 10),
];
