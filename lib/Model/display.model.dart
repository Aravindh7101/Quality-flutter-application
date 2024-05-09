class DisplayModel {
  List<Item>? l;
  List<Item>? f;
  List<Item>? s;
  List<Item>? p;
  List<Item>? t;
  List<Item>? c;

  DisplayModel({this.l, this.f, this.s, this.p, this.t, this.c});

  DisplayModel.fromJson(Map<String, dynamic> json) {
    if (json['l'] != null) {
      l = <Item>[];
      json['l'].forEach((v) {
        l!.add(new Item.fromJson(v));
      });
    }
    if (json['f'] != null) {
      f = <Item>[];
      json['f'].forEach((v) {
        f!.add(new Item.fromJson(v));
      });
    }
    if (json['s'] != null) {
      s = <Item>[];
      json['s'].forEach((v) {
        s!.add(new Item.fromJson(v));
      });
    }
    if (json['p'] != null) {
      p = <Item>[];
      json['p'].forEach((v) {
        p!.add(new Item.fromJson(v));
      });
    }
    if (json['t'] != null) {
      t = <Item>[];
      json['t'].forEach((v) {
        t!.add(new Item.fromJson(v));
      });
    }
    if (json['c'] != null) {
      c = <Item>[];
      json['c'].forEach((v) {
        c!.add(new Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.l != null) {
      data['l'] = this.l!.map((v) => v.toJson()).toList();
    }
    if (this.f != null) {
      data['f'] = this.f!.map((v) => v.toJson()).toList();
    }
    if (this.s != null) {
      data['s'] = this.s!.map((v) => v.toJson()).toList();
    }
    if (this.p != null) {
      data['p'] = this.p!.map((v) => v.toJson()).toList();
    }
    if (this.t != null) {
      data['t'] = this.t!.map((v) => v.toJson()).toList();
    }
    if (this.c != null) {
      data['c'] = this.c!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  int? entId;
  int? headId;
  int? subheadId;
  String? description;
  String? file;
  String? name;
  int? kId;
  int? skId;
  String? frequency;
  String? strip;
  int? priority;
  var reminderStamp;
  String? insertDate;
  String? reminderDate;
  int? status;
  int? archive;
  String? newdata;
  String? datetime;
  int? hId;
  String? headName;
  int? shId;
  String? subheadName;
  var cmId;
  var msg;
  var eId;
  var cmDatetime;
  String? kName;
  String? skName;
  String? skDatetime;

  Item({
    this.entId,
    this.headId,
    this.subheadId,
    this.description,
    this.file,
    this.name,
    this.kId,
    this.skId,
    this.frequency,
    this.strip,
    this.priority,
    this.reminderStamp,
    this.insertDate,
    this.reminderDate,
    this.status,
    this.archive,
    this.newdata,
    this.datetime,
    this.hId,
    this.headName,
    this.shId,
    this.subheadName,
    this.cmId,
    this.msg,
    this.eId,
    this.cmDatetime,
    this.kName,
    this.skName,
    this.skDatetime,
  });

  Item.fromJson(Map<String, dynamic> json) {
    entId = json['ent_id'];
    headId = json['head_id'];
    subheadId = json['subhead_id'];
    description = json['description'];
    file = json['file'];
    name = json['name'];
    kId = json['k_id'];
    skId = json['sk_id'];
    frequency = json['frequency'];
    strip = json['strip'];
    priority = json['priority'];
    reminderStamp = json['reminder_stamp'];
    insertDate = json['insert_date'];
    reminderDate = json['reminder_date'];
    status = json['status'];
    archive = json['archive'];
    newdata = json['newdata'];
    datetime = json['datetime'];
    hId = json['h_id'];
    headName = json['head_name'];
    shId = json['sh_id'];
    subheadName = json['subhead_name'];
    cmId = json['cm_id'];
    msg = json['msg'];
    eId = json['e_id'];
    cmDatetime = json['cm_datetime'];
    kName = json['k_name'];
    skName = json['sk_name'];
    skDatetime = json['sk_datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ent_id'] = this.entId;
    data['head_id'] = this.headId;
    data['subhead_id'] = this.subheadId;
    data['description'] = this.description;
    data['file'] = this.file;
    data['name'] = this.name;
    data['k_id'] = this.kId;
    data['sk_id'] = this.skId;
    data['frequency'] = this.frequency;
    data['strip'] = this.strip;
    data['priority'] = this.priority;
    data['reminder_stamp'] = this.reminderStamp;
    data['insert_date'] = this.insertDate;
    data['reminder_date'] = this.reminderDate;
    data['status'] = this.status;
    data['archive'] = this.archive;
    data['newdata'] = this.newdata;
    data['datetime'] = this.datetime;
    data['h_id'] = this.hId;
    data['head_name'] = this.headName;
    data['sh_id'] = this.shId;
    data['subhead_name'] = this.subheadName;
    data['cm_id'] = this.cmId;
    data['msg'] = this.msg;
    data['e_id'] = this.eId;
    data['cm_datetime'] = this.cmDatetime;
    data['k_name'] = this.kName;
    data['sk_name'] = this.skName;
    data['sk_datetime'] = this.skDatetime;
    return data;
  }
}
