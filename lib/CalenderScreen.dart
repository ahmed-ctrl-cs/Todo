import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindfultodo/widgets/DayCard.dart';
import 'package:mindfultodo/widgets/FocusBar.dart';
import 'package:mindfultodo/assets/data.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});
  @override
  State<CalenderScreen> createState() => _CalenderScreen();
}

class _CalenderScreen extends State<CalenderScreen> {
  int selectedIndex = 3;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    List<double> weeklyFocusData = [4.2, 3.0, 20.2, 6.1, 4.5, 2.0, 1.5];
    double maxValue = weeklyFocusData.reduce((a, b) => a > b ? a : b);
    if (maxValue == 0) maxValue = 1;
    double weeklyFocusDataSum = 0;
    for (int i = 0; i < weeklyFocusData.length; i++) {
      weeklyFocusDataSum += weeklyFocusData[i];
    }
    int totalWeeklyTasks = 0;
    int completedWeeklyTasks = 0;

    for (var group in Data.dummyData) {
      List<dynamic> completedStatusList = group['completed'];
      totalWeeklyTasks += completedStatusList.length;
      completedWeeklyTasks += completedStatusList
          .where((status) => status == true)
          .length;
    }

    int remainingWeeklyTasks = totalWeeklyTasks - completedWeeklyTasks;
    double progressPercentage = totalWeeklyTasks == 0
        ? 0.0
        : completedWeeklyTasks / totalWeeklyTasks;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            print('Menu tapped');
          },
        ),
        backgroundColor: Colors.transparent,
        toolbarHeight: 30,
        title: Text(
          'Mindful Planner',
          style: TextStyle(
            color: Color.fromRGBO(148, 73, 49, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                'https://imgs.search.brave.com/BZx7X6J0HrCfjRBGoDkUIODgrIDWMlesjQwYm4Zvvhs/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pMC53/cC5jb20vcGljanVt/Ym8uY29tL3dwLWNv/bnRlbnQvdXBsb2Fk/cy9hcnRpc3RpYy1o/aWdoLWZhc2hpb24t/cG9ydHJhaXQtb2Yt/YS13b21hbi13aXRo/LXN1bmdsYXNzZXMt/ZnJlZS1pbWFnZS5q/cGVnP3c9NjAwJnF1/YWxpdHk9ODA',
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weekly Review',
                    style: GoogleFonts.literata(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Day 1 => Day 2',
                    style: TextStyle(color: Color.fromRGBO(84, 67, 62, 1)),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 110,
              child: ListView.builder(
                itemCount: 7,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  DateTime cardDate = DateTime.now().add(Duration(days: index));
                  String dNum = cardDate.day.toString();
                  List<String> weekdays = [
                    'MON',
                    'TUE',
                    'WED',
                    'THU',
                    'FRI',
                    'SAT',
                    'SUN',
                  ];
                  String dName = weekdays[cardDate.weekday - 1];

                  return DayCard(
                    dName: dName,
                    dNum: dNum,
                    isSelected: selectedIndex == index,
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  );
                }),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(242, 242, 240, 1),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Color.fromRGBO(243, 237, 234, 1)),
              ),
              padding: EdgeInsets.all(13),
              margin: EdgeInsets.all(13),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('FOCUS LEVEL'),
                      Text(
                        "${weeklyFocusDataSum / (weeklyFocusData.length)}h/day",
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ...List.generate(7, (index) {
                          List<String> singleLetterDays = [
                            'M',
                            'T',
                            'W',
                            'T',
                            'F',
                            'S',
                            'S',
                          ];
                          return Focusbar(
                            dName: singleLetterDays[index],
                            focusValue: weeklyFocusData[index],
                            hieghestValue: maxValue,
                            maxHeight: 120,
                            isSelected: selectedIndex == index,
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(249, 248, 243, 1),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Color.fromRGBO(243, 237, 234, 1)),
              ),
              padding: EdgeInsets.all(13),
              margin: EdgeInsets.all(13),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'TASK COMPLETION',
                        style: TextStyle(
                          color: Color.fromRGBO(105, 128, 109, 1),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  CircularPercentIndicator(
                    radius: 65,
                    lineWidth: 8,
                    percent: progressPercentage,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${((progressPercentage * 100).toInt()).toString()}%',
                          style: GoogleFonts.literata(fontSize: 25),
                        ),
                        Text(
                          'Focus',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff54433e),
                          ),
                        ),
                      ],
                    ),
                    progressColor: Color(0xff944931),
                    backgroundColor: Color.fromRGBO(211, 211, 211, 0.5),
                    circularStrokeCap: CircularStrokeCap.round,
                    animation: true,
                    animationDuration: 500,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text('Completed'),
                      Spacer(),
                      Text(
                        '$completedWeeklyTasks',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Remaining'),
                      Spacer(),
                      Text(
                        '$remainingWeeklyTasks',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
