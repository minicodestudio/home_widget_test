import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String appGroupId = 'group.flutter_mcs_group';
  String iOSWidgetName = 'test_home_screen';
  String androidWidgetName = 'TestWidget';

  @override
  void initState() {
    super.initState();
    HomeWidget.setAppGroupId(appGroupId);
  }

  Future<void> updateWidget() async {
    print('Updating widget...');
    try {
      await HomeWidget.saveWidgetData<String>('title', '기둘개둘');
      await HomeWidget.saveWidgetData<String>('description', '즐거운 프로젝트');
      await HomeWidget.updateWidget(
        androidName: androidWidgetName,
        iOSName: iOSWidgetName,
      );
      print('Data saved and widget updated');
    } catch (e) {
      print('Error updating widget: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen Widget Test'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => updateWidget(),
          child: const Text('Update'),
        ),
      ),
    );
  }
}
