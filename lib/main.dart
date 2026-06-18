import 'package:flutter/material.dart';
import 'package:mindfultodo/assets/colors.dart';
import 'assets/data.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(Render());
}

class Render extends StatelessWidget {
  const Render({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test => Mindful Todo List Maker',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.literata(fontSize: 22),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          tertiary: AppColors.tertiary,
        ),
      ),
      themeMode: ThemeMode.system,
      home: mainHomePage(),
    );
  }
}

class mainHomePage extends StatefulWidget {
  const mainHomePage({super.key});

  @override
  State<mainHomePage> createState() => _mainHomePage();
}

class _mainHomePage extends State<mainHomePage> {
  @override
  Widget build(BuildContext context) {
    //get the theme data from the mother class
    final themeColor = Theme.of(context).colorScheme;
    //get the number of items in the database and the number of completed ones
    int totalItems = 0;
    int completedItems = 0;

    for (var group in Data.dummyData) {
      List<dynamic> completedStatusList = group['completed'];
      totalItems += completedStatusList.length;
      // Count how many items in this specific group are exactly 'true'
      completedItems += completedStatusList
          .where((status) => status == true)
          .length;
    }
    double progressPercentage = totalItems == 0
        ? 0.0
        : completedItems / totalItems;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: themeColor.surfaceTint,
        toolbarHeight: 22,
        title: Text(
          'Mindful Planner',
          style: TextStyle(color: themeColor.primary),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xfff5f3ee),
                borderRadius: BorderRadius.all(Radius.circular(12)),
                border: Border.all(
                  color: Color.fromRGBO(211, 211, 211, 0.5),
                  width: 0.5,
                ),
              ),
              child: Text('The AI summery will be here when implemented'),
            ),
          ),
          //the percentage circle
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.all(Radius.circular(12)),
                border: Border.all(
                  color: Color.fromRGBO(211, 211, 211, 0.5),
                  width: 0.5,
                ),
              ),
              child: Column(
                children: [
                  CircularPercentIndicator(
                    radius: 100,
                    lineWidth: 10,
                    percent: progressPercentage,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${((progressPercentage * 100).toInt()).toString()}%',
                          style: GoogleFonts.literata(fontSize: 30),
                        ),
                        Text(
                          'Focus',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff54433e),
                          ),
                        ),
                      ],
                    ),
                    progressColor: Color(0xff944931),
                    backgroundColor: Color.fromRGBO(211, 211, 211, 0.5),
                    circularStrokeCap: CircularStrokeCap.square,
                    animation: true,
                    animationDuration: 500,
                  ),
                  SizedBox(height: 12),
                  Text('$completedItems of $totalItems tasks completed'),
                ],
              ),
            ),
          ),
          //getting the data and presenting it
          ...Data.dummyData.map((groupData) {
            return SliverMainAxisGroup(
              slivers: [
                //group names here
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.all(12),
                    child: Text(
                      groupData['cName'],
                      style: GoogleFonts.literata(fontSize: 20),
                    ),
                  ),
                ),
                //the items in each group
                SliverList.builder(
                  itemCount: (groupData['items'] as List).length,
                  itemBuilder: ((context, index) {
                    final item = groupData['items'][index];
                    final itemDisc = groupData['discription'][index];
                    bool complete = groupData['completed'][index];
                    return Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(
                        right: 12,
                        left: 12,
                        top: 0,
                        bottom: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xfff5f3ee),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        border: Border.all(
                          color: Color.fromRGBO(211, 211, 211, 0.5),
                          width: 0.5,
                        ),
                      ),
                      child: CheckboxListTile(
                        title: groupData['completed'][index]
                            ? Text(
                                item,
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Color.fromRGBO(
                                    120,
                                    120,
                                    120,
                                    0.8,
                                  ),
                                  color: Color.fromRGBO(120, 120, 120, 0.5),
                                ),
                              )
                            : Text(item),
                        subtitle: Text(itemDisc),
                        value: complete,
                        onChanged: (bool? value) {
                          setState(() {
                            groupData['completed'][index] = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    );
                  }),
                ),
              ],
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("this button was clicked");
        },
        elevation: 10,
        child: Icon(Icons.add),
      ),
    );
  }
}
