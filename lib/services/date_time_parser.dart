class DateTimeParser{

  DateTime? parseDate(List localDate) {

    if (localDate.length == 3) {
      return DateTime(localDate[0], localDate[1], localDate[2]);
    } else {
      return null;
    }
  }

  DateTime tokenParseDate(List? localDate) {

    if (localDate?.length == 3) {
      return DateTime(localDate?[0], localDate?[1], localDate?[2]);
    } else {
      return DateTime(2001, 1, 1);
    }
  }
}