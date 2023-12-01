class Task {
  int? id;
  String? title;
  String? desc;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? remind;
  String? repeat;

  Task({
    this.id,
    this.title,
    this.desc,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.remind,
    this.repeat,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    remind = json['remind'];
    repeat = json['repeat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['date'] = date;
    data['desc'] = desc;
    data['isCompleted'] = isCompleted;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['remind'] = remind;
    data['repeat'] = repeat;
    return data;
  }
}
