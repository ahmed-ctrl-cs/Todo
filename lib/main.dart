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
        leading: IconButton(
          icon: const Icon(Icons.menu), // This is the standard hamburger icon
          tooltip: 'Open Menu',
          onPressed: () {
            // Add your logic to open a drawer or navigate
            debugPrint('Menu tapped');
          },
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: themeColor.surfaceTint,
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
              radius: 20, // Controls the size of the circle
              backgroundImage: NetworkImage(
                'https://your-image-url.com/profile.jpg',
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TODAY'S FOCUS",
                    style: TextStyle(
                      color: Color.fromRGBO(110, 125, 109, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Good morning, Alex',
                    style: GoogleFonts.literata(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(27),
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color.fromRGBO(245, 243, 238, 0.6),
                borderRadius: BorderRadius.all(Radius.circular(12)),
                border: Border.all(
                  color: Color.fromRGBO(211, 211, 211, 0.5),
                  width: 0.5,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.flare_rounded,
                        size: 18,
                        color: Color.fromRGBO(148, 73, 49, 1),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'DAILY INTENTION',
                        style: TextStyle(
                          color: Color.fromRGBO(84, 67, 62, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 146),
                      Icon(
                        Icons.edit_outlined,
                        color: Color.fromRGBO(148, 73, 49, 1),
                        size: 20,
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    '"I will move through today with clarity and prioritize my well-being while achieving my creative goals."',
                    style: GoogleFonts.merriweather(
                      // Or GoogleFonts.merriweather
                      fontSize: 18,
                      letterSpacing: 1.3,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight
                          .w400, // This is the crucial missing piece (Semi-Bold)
                      color: const Color(
                        0xFF1E1B1A,
                      ), // Use your dark onSurface text color
                      height: 1.5, // Increases the space between lines
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Container(
                        width: 6, // Controls the exact size of the circle
                        height: 6,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(110, 125, 109, 1),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Refined by Mindful AI',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(110, 125, 109, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //the percentage circle
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(20),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircularPercentIndicator(
                    radius: 65,
                    lineWidth: 4,
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
                    circularStrokeCap: CircularStrokeCap.square,
                    animation: true,
                    animationDuration: 500,
                  ),
                  SizedBox(height: 20),
                  Text('$completedItems of $totalItems tasks completed'),
                ],
              ),
            ),
          ),
          //getting the data and presenting it
          ...Data.dummyData.map((groupData) {
            final int remainingCount = (groupData['completed'] as List)
                .where((status) => status == false)
                .length;

            return SliverMainAxisGroup(
              slivers: [
                //group names here
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          groupData['cName'],
                          style: GoogleFonts.literata(fontSize: 20),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 5, left: 5),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(206, 224, 202, 0.5),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: remainingCount == 0
                              ? null
                              : Text(
                                  remainingCount >= 2
                                      ? '$remainingCount Remainders'
                                      : '1 Remainder',
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                //the items in each group
                SliverList.builder(
                  itemCount: (groupData['items'] as List).length,
                  itemBuilder: ((context, index) {
                    final item = groupData['items'][index];

                    final List descriptions = groupData['discription'];
                    final String itemDisc = descriptions.length > index
                        ? descriptions[index]
                        : "";

                    bool complete = groupData['completed'][index];
                    return Container(
                      padding: EdgeInsets.all(1),
                      margin: EdgeInsets.only(
                        right: 18,
                        left: 18,
                        top: 0,
                        bottom: 18,
                      ),
                      decoration: groupData['completed'][index]
                          ? BoxDecoration(
                              color: Color.fromRGBO(245, 243, 238, 0.63),
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            )
                          : BoxDecoration(
                              color: Color(0xfff5f3ee),
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
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
                                  fontSize: 15,
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
                            : Text(item, style: TextStyle(fontSize: 15)),
                        subtitle: itemDisc.isEmpty
                            ? null // Removes the widget entirely if there is no description text
                            : groupData['completed'][index]
                            ? Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                      right: 4,
                                      left: 4,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(215, 213, 208, 0.4),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: Text(
                                      itemDisc,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Color.fromRGBO(
                                          120,
                                          120,
                                          120,
                                          0.6,
                                        ),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text('2:00 PM'),
                                ],
                              )
                            : Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                      right: 4,
                                      left: 4,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(215, 213, 208, 0.9),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: Text(
                                      itemDisc,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
        shape: CircleBorder(),
        backgroundColor: Color.fromRGBO(145, 71, 49, 1),
        foregroundColor: Colors.white,
        child: Icon(Icons.mic_none),
      ),
    );
  }
}
