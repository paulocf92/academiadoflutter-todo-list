class TotalTasksModel {
  final int totalTasks;
  final int totalTasksFinished;

  int get unfinishedTasks => totalTasks - totalTasksFinished;

  TotalTasksModel({required this.totalTasks, required this.totalTasksFinished});
}
