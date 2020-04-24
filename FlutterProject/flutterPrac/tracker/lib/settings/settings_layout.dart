import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsLayout extends StatefulWidget {
  @override
  _SettingsLayout createState() => _SettingsLayout();
}

class _SettingsLayout extends State<SettingsLayout> {
  bool _finger = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('환경설정'),
      ),
      body: Container(
        child: SettingsList(
          sections: [
            SettingsSection(
              tiles: [
                SettingsTile(
                  title: '언어 선택',
                  subtitle: '한국어',
                  leading: Icon(Icons.language),
                  onTap: () {},
                ),
                SettingsTile.switchTile(
                  title: 'Use fingerprint',
                  leading: Icon(Icons.fingerprint),
                  switchValue: _finger,
                  onToggle: (bool value) {
                    setState(() {
                      _finger = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
