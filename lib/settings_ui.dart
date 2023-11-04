import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class settings_page extends StatefulWidget {
  const settings_page({super.key});

  @override
  State<settings_page> createState() => _settings_pageState();
}

class _settings_pageState extends State<settings_page> {
  @override


  Widget build(BuildContext context) {

    double hi=MediaQuery.of(context).size.height;
    double wi=MediaQuery.of(context).size.width;


    final List<Setting> settings = [
      Setting(
        title: "Dark mode",
        icon: CupertinoIcons.moon_circle,
      ),
      Setting(
        title: "Notification",
        icon: Icons.notifications,
      ),
      Setting(
        title: "privacy",
        icon: CupertinoIcons.lock,
      ),
      Setting(
        title: "Security ",
        icon: CupertinoIcons.lock_shield,
      ),
      Setting(
        title: "Main",
        icon: CupertinoIcons.settings,
      ),
      Setting(
        title: "Report a problem",
        icon: CupertinoIcons.flag,
      ),

    ];



    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child:  SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: hi*0.15,
                  child: Center(child: Text("Settings",style: TextStyle(fontSize: 32),)),
                ),

              Row(
                children: [
                  CircleAvatar(
                    radius: wi*0.1,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("User Name",
                        style: TextStyle(fontWeight: FontWeight.bold,),
                      ),
                      Text("email")
                    ],
                  ),
                 // Icon(Icons.chevron_right),
                ],
              ),


                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 10),
                Column(
                  children: List.generate(
                    settings.length, (index) => SettingTile(setting: settings[index]),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

class SettingTile extends StatelessWidget {
  final Setting setting;
  const SettingTile({
    super.key,
    required this.setting,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // give route
      },
      child: ListTile(
          leading: Icon(setting.icon),
        title: Text(setting.title),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}


class Setting {
  final String title;
  final IconData icon;

  Setting({
    required this.title,
    required this.icon,
  });
}