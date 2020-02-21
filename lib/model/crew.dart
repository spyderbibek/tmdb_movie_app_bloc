
class Crew {

  String credit_id;
  String department;
  int gender;
  int id;
  String job;
  String name;
  String profile_path;

	Crew.fromJsonMap(Map<String, dynamic> map): 
		credit_id = map["credit_id"],
		department = map["department"],
		gender = map["gender"],
		id = map["id"],
		job = map["job"],
		name = map["name"],
		profile_path = map["profile_path"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['credit_id'] = credit_id;
		data['department'] = department;
		data['gender'] = gender;
		data['id'] = id;
		data['job'] = job;
		data['name'] = name;
		data['profile_path'] = profile_path;
		return data;
	}
}
