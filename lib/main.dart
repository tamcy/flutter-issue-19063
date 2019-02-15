import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

Locale appLocale = const Locale('zh', 'HK');

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  void setLocale(Locale locale) {
    setState(() {
      appLocale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('zh', 'HK'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: appLocale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Locale _listItemLocale = const Locale('en', 'US');

  Text localeButtonTextWidget(Locale locale, Locale compareLocale) =>
      Text(locale.languageCode.toUpperCase(),
          style: TextStyle(color: (locale == compareLocale ? Colors.red : Colors.black26)));

  Widget appLocaleButton(Locale locale) => InkWell(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: localeButtonTextWidget(locale, appLocale),
        ),
        onTap: () {
          MyAppState appState = context.ancestorStateOfType(const TypeMatcher<MyAppState>());
          appState.setLocale(locale);
        },
      );

  Widget uiLocaleButton(Locale locale) => InkWell(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: localeButtonTextWidget(locale, _listItemLocale),
        ),
        onTap: () {
          setState(() {
            _listItemLocale = locale;
          });
        },
      );

  Widget labelWidget(String text) => Container(
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          color: Colors.black45,
        ),
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 12.0)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (int value) {},
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                  const PopupMenuItem<int>(
                    value: 1,
                    child: Text('這是 Pop-up menu 選單'),
                  ),
//                  const PopupMenuItem<int>(
//                    value: 2,
//                    child: Text('Item 2'),
//                  ),
                ],
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              labelWidget('APP'),
              appLocaleButton(const Locale('en', 'US')),
              appLocaleButton(const Locale('zh', 'HK')),
              SizedBox(
                width: 24.0,
              ),
              labelWidget('UI'),
              uiLocaleButton(const Locale('en', 'US')),
              uiLocaleButton(const Locale('zh', 'HK')),
            ]),
          ),
          Divider(),
        ]..addAll(_listItemLocale.languageCode == 'zh' ? getZhList() : getEnList()),
      ),
    );
  }

  ListTile buildListTile(IconData icon, String title, [String subtitle]) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      onTap: () {},
    );
  }

  List<Widget> getEnList() {
    return [
      buildListTile(Icons.chevron_right, 'Developer options'),
      buildListTile(Icons.system_update, 'System update', 'Updated to Android 8.1.0'),
      buildListTile(Icons.restore, 'Reset options', 'Network, apps or device can be reset'),
      buildListTile(Icons.info_outline, 'About phone', 'Nexus 5X'),
    ];
  }

  List<Widget> getZhList() {
    return [
      buildListTile(Icons.chevron_right, '開發人員選項'),
      buildListTile(Icons.system_update, '系統更新', '已更新至 Android 8.1.0'),
      buildListTile(Icons.restore, '重設選項', '網絡、應用程式或裝置可以重設'),
      buildListTile(Icons.info_outline, '關於手機', 'Nexus 5X'),
    ];
  }
}
