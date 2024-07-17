enum TaskFilterEnum {
  today,
  tomorrow,
  week,
}

extension TaskFilterDescription on TaskFilterEnum {
  String get description {
    switch (this) {
      case TaskFilterEnum.today:
        return 'TODAY\'S TASKS';
      case TaskFilterEnum.tomorrow:
        return 'TOMORROW\'S TASKS';
      case TaskFilterEnum.week:
        return 'WEEK TASKS';
    }
  }
}
