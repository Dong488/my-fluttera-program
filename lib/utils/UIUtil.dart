class UIUtil {
  static List<String> nameList = [
    "Gifts",
    "Savings",
    "Transport",
    "Medicine",
    "Food",
    "Income"
  ];
  static List<String> imgList = [
    "images/icon_add_0.png",
    "images/icon_add_1.png",
    "images/icon_add_2.png",
    "images/icon_add_3.png",
    "images/icon_add_4.png",
    "images/icon_add_5.png"
  ];

  static String mapToString(Map<String, String> paramMap) {
    String str = "";
    paramMap.forEach((key, value) {
      str += (key + "--" + value + "++");
    });

    return str;
  }

  static Map<String, String> stringToMap(String str) {
    Map<String, String> map = Map();
    if (str.isNotEmpty) {
      List<String> oneList = str.split("++");
      oneList.forEach((element) {
        List<String> twoList = element.split("--");
        if (twoList.length > 1) {
          map[twoList[0]] = twoList[1];
        }
      });
    }
    return map;
  }

  static String getLocalTime() {
    DateTime dateTime = DateTime.now();
    int year = dateTime!.year;
    int month = dateTime!.month;
    int day = dateTime!.day;

    String str_year = "${year}-$month-$day";
    return str_year;
  }

  ///获取近七天的日期
  static List<String> getLastSevenDate() {
    List<String> dates = [];
    DateTime now = DateTime.now();

    for (int i = 6; i >=0; i--) {
      DateTime date = now.subtract(Duration(days: i));
      String formattedDate = "${date.year}-${date.month}-${date.day}";
      dates.add(formattedDate);
    }
    return dates;
  }
  ///只保留日期
  static String getOnlyDay(String formatStr) {
    List<String> strList=formatStr.split("-");
    if(strList.isNotEmpty){
      return strList[strList.length-1];
    }
    return "";
  }
}
