String formatDate(String date) {
  DateTime parsedDate = DateTime.parse(date);
  return '${parsedDate.day}.${parsedDate.month}.${parsedDate.year}';
}
