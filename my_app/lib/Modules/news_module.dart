import 'package:equatable/equatable.dart';

class News extends Equatable {
  final String title;

  const News({
    required this.title,
  });

  @override
  List<Object?> get props => [title];

  static List<News> news = [
    const News(
      title: 'news test 1',
    ),
    const News(
      title: 'news test 2',
    ),
  ];
}
