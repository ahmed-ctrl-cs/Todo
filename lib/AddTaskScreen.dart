import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindfultodo/assets/data.dart';

class Addtaskscreen extends StatefulWidget {
  const Addtaskscreen({super.key});
  @override
  State<Addtaskscreen> createState() => _Addtaskscreen();
}

class _Addtaskscreen extends State<Addtaskscreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
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
            child: Column(
              children: [
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(245, 245, 243, 1),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color.fromRGBO(220, 220, 220, 1),
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.fact_check_outlined,
                      size: 40,
                      color: Color.fromRGBO(80, 100, 80, 1),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Confirm Tasks',
                  style: GoogleFonts.literata(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Review the tasks you just added.',
                  style: TextStyle(color: Color.fromRGBO(94, 78, 72, 1)),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 15)),
          ...Data.dummyData.map((groupData) {
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Text('ADDED TASKS'),
                  Text('${(groupData['items'] as List).length} items'),
                ],
              ),
            );
            return SliverList.builder(
              itemCount: (groupData['items'] as List).length,
              itemBuilder: ((context, index) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      width: screenSize.width - 20,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Color.fromRGBO(235, 220, 210, 1),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                groupData['items'][index],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),

                              Text(
                                groupData['cName'],
                                style: TextStyle(
                                  color: Color.fromRGBO(94, 78, 72, 1),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit_outlined),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                );
              }),
            );
          }),
        ],
      ),
    );
  }
}
