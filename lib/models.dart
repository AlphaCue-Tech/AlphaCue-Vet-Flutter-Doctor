class Communicate{
  String msgId;
  String type;
  String active;
  String from;
  String msg;
  String channel;
  String token;
  String time;
  String date;


  Communicate(this.msgId,this.type,this.active,this.from, this.msg,this.channel,this.token, this.time,this.date);

  Communicate.fromJson(Map json)
      :
        type=json['type'],
        msgId=json['msgId'],
        active=json['active'],
        from = json['from'],
        msg = json['msg'],
        channel=json['channel'],
        token=json['token'],
        time = json['time'],
        date=json['date']
  ;


}