
class Network {
  String name;

  Network(String name) {
    this.name = name;
  }

  List<String> networks;

  Network.fromMap(Map<String, dynamic> data) {
    networks = data['name'];
  }

}