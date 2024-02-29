List<DateTime> generateDaysFromYearBegin() {
    List<DateTime> dateList = [];
    DateTime now = DateTime.now();
    DateTime firstDayOfYear = DateTime(now.year, 1, 1);
    
    for (DateTime date = firstDayOfYear; date.isBefore(now); date = date.add(const Duration(days: 1))) {
      dateList.add(date);
    }
    
    return dateList;
  }