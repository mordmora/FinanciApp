Map<String, String> sliceFullName(String name) {
  var fullName = name.split(' ');
  var firstName = fullName.isEmpty ? "" : fullName[0];
  var lastName = fullName.length > 1 ? fullName[1] : "";
  return {'firstName': firstName, 'lastName': lastName};
}

bool validName(String name) {
  if (name.trim().isEmpty) {
    return false;
  } else {
    var actualWords = name.split(' ').where((word) => word.trim().isNotEmpty);
    if (actualWords.length > 2) {
      return false;
    }
  }
  return true;
}
