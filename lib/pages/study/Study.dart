import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:final_demo/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// import 'package:toast/toast.dart';
import "../../utils/Global.dart";
import 'dart:ui';

final width = window.physicalSize.width;
final height = window.physicalSize.height;
const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

String selectedUrl = 'http://192.168.8.44:8081';
Timer? _timer;
GeolocationStatus? _permission;

void xxx() {
  Duration invokeDuration = const Duration(seconds: 10);
  _timer = Timer.periodic(invokeDuration, (timer) async {
    print("定时器任务开启");
    print(DateTime.now().toIso8601String());
    Position result = await _determinePosition();
    Map postData = {"lng": result.longitude, "lat": result.latitude};
    var postPostionRes = await Dio().post(
        "http://192.168.8.44:8080/api/v1/base/sendLocation",
        data: postData);
    print(postPostionRes);
    print("定时任务结束");
  });
}

Geolocator geo = Geolocator();
PermissionStatus? _ps;

Future<Position> _determinePosition() async {
  // if (Platform.isAndroid) {
  // } else if (Platform.isIOS) {
  // } else {}

  // 服务是否允许
  bool serviceEnabled;
  // 权限状态

  // 获取服务是否开启了
  serviceEnabled = await geo.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // 如果没有开启则直接跑错
    return Future.error('Location services are disabled.');
  }
  print(_permission);
  if (_ps == null) {
    _ps = await Permission.locationWhenInUse.request();
    if (_ps == PermissionStatus.denied) {
      return Future.error('Location permissions are denied');
    }
    if (_ps == PermissionStatus.permanentlyDenied) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }
  if (!await Permission.locationAlways.isGranted) {
    print("$_permission:当前app在app前台运行时才能获取定位");
    await Permission.locationAlways.request();
  }
  // 检查权限情况，返回权限对应枚举
  // if (_permission == null) {
  //   _permission = await geo.checkGeolocationPermissionStatus();
  //   // 如果权限没有被授权
  //   if (_permission == GeolocationStatus.denied) {
  //     // 则直接发起一次权限请求
  //     // _permission = await ;
  //     // 如果权限还是拒绝
  //     if (_permission == GeolocationStatus.denied) {
  //       // 还是拒绝，则再次抛出错误
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //
  //   // 如果权限是永久拒绝，则继续抛出错误
  //   if (_permission == GeolocationStatus.disabled) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  // }
  // if (_permission == LocationPermission.whileInUse) {
  //   print("$_permission:当前app在app前台运行时才能获取定位");
  //   _permission = await Geolocator.requestPermission();
  // }

  // 执行到这里，说明权限什么的都允许了，可以正式的请求定位
  // 根据is回答，默认采用的是google定位服务api，需要强制使用安卓设备
  return await geo.getCurrentPosition();
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(StudyPage());
}

class StudyPage extends StatelessWidget {
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    xxx();
    return MaterialApp(
      title: 'Flutter WebView Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (_) => const MyHomePage(title: 'Flutter WebView Demo'),
        '/widget': (_) {
          return WebviewScaffold(
            url: selectedUrl,
            withJavascript: true,
            mediaPlaybackRequiresUserGesture: false,
            appBar: AppBar(
              title: const Text('Widget WebView'),
            ),
            withZoom: true,
            withLocalStorage: true,
            hidden: true,
            initialChild: Container(
              color: Colors.redAccent,
              child: const Center(
                child: Text('Waiting.....'),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      flutterWebViewPlugin.goBack();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      flutterWebViewPlugin.goForward();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.autorenew),
                    onPressed: () {
                      flutterWebViewPlugin.reload();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Instance of WebView plugin
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  // On destroy stream
  late StreamSubscription _onDestroy;

  // On urlChanged stream
  late StreamSubscription<String> _onUrlChanged;

  // On urlChanged stream
  late StreamSubscription<WebViewStateChanged> _onStateChanged;

  late StreamSubscription<WebViewHttpError> _onHttpError;

  late StreamSubscription<double> _onProgressChanged;

  late StreamSubscription<double> _onScrollYChanged;

  late StreamSubscription<double> _onScrollXChanged;

  final _urlCtrl = TextEditingController(text: selectedUrl);

  final _codeCtrl = TextEditingController(text: 'window.navigator.userAgent');

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _history = [];

  @override
  void initState() {
    super.initState();

    flutterWebViewPlugin.close();

    _urlCtrl.addListener(() {
      selectedUrl = _urlCtrl.text;
    });

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebViewPlugin.onDestroy.listen((_) {
      if (mounted) {
        // Actions like show a info toast.
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Webview Destroyed')));
      }
    });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() {
          _history.add('onUrlChanged: $url');
        });
      }
    });

    _onProgressChanged =
        flutterWebViewPlugin.onProgressChanged.listen((double progress) {
      if (mounted) {
        setState(() {
          _history.add('onProgressChanged: $progress');
        });
      }
    });

    _onScrollYChanged =
        flutterWebViewPlugin.onScrollYChanged.listen((double y) {
      if (mounted) {
        setState(() {
          _history.add('Scroll in Y Direction: $y');
        });
      }
    });

    _onScrollXChanged =
        flutterWebViewPlugin.onScrollXChanged.listen((double x) {
      if (mounted) {
        setState(() {
          _history.add('Scroll in X Direction: $x');
        });
      }
    });

    _onStateChanged =
        flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (mounted) {
        setState(() {
          _history.add('onStateChanged: ${state.type} ${state.url}');
        });
      }
    });

    _onHttpError =
        flutterWebViewPlugin.onHttpError.listen((WebViewHttpError error) {
      if (mounted) {
        setState(() {
          _history.add('onHttpError: ${error.code} ${error.url}');
        });
      }
    });
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    _onProgressChanged.cancel();
    _onScrollXChanged.cancel();
    _onScrollYChanged.cancel();
    flutterWebViewPlugin.close();

    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).userInfo;
    // ToastContext().init(context);
// ignore: prefer_collection_literals
    final Set<JavascriptChannel> jsChannels = [
      JavascriptChannel(
          name: 'fuck',
          onMessageReceived: (JavascriptMessage message) {
            print("get message from JS, message is: ${message.message}");
          }),
    ].toSet();

    flutterWebViewPlugin.launch(
      selectedUrl,
      withJavascript: true,
      javascriptChannels: jsChannels,
      rect: Rect.fromLTWH(
          0.0,
          MediaQuery.of(context).padding.top,
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              56.0),
      userAgent: kAndroidUserAgent,
      // invalidUrlRegex:
      //     r'^(https).+(twitter)', // prevent redirecting to twitter when user click on its icon in flutter website
    );

    var javascript = "window.flutterInfo=${json.encode(user)}";
    print(javascript);
    print(json.encode(user));
    // flutterWebViewPlugin.evalJavascript(javascript);

    return Scaffold(
        key: _scaffoldKey,
        // body: SingleChildScrollView(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Container(
        //         padding: const EdgeInsets.all(24.0),
        //         child: TextField(controller: _urlCtrl),
        //       ),
        //       ElevatedButton(
        //         onPressed: () {
        //           flutterWebViewPlugin.launch(
        //             selectedUrl,
        //             withJavascript: true,
        //             javascriptChannels: jsChannels,
        //             rect: Rect.fromLTWH(
        //                 0.0,
        //                 MediaQuery.of(context).padding.top,
        //                 MediaQuery.of(context).size.width,
        //                 MediaQuery.of(context).size.height -
        //                     MediaQuery.of(context).padding.top -
        //                     56.0),
        //             userAgent: kAndroidUserAgent,
        //             // invalidUrlRegex:
        //             //     r'^(https).+(twitter)', // prevent redirecting to twitter when user click on its icon in flutter website
        //           );
        //           var javascript = "window.flutterInfo=${json.encode(user)}";
        //           print(javascript);
        //           print(json.encode(user));
        //           flutterWebViewPlugin.evalJavascript(javascript);
        //         },
        //         child: const Text('Open Webview (rect)'),
        //       ),
        //       ElevatedButton(
        //         onPressed: () {
        //           flutterWebViewPlugin.launch(selectedUrl, hidden: true);
        //         },
        //         child: const Text('Open "hidden" Webview'),
        //       ),
        //       ElevatedButton(
        //         onPressed: () {
        //           flutterWebViewPlugin.launch(
        //             selectedUrl,
        //           );
        //         },
        //         child: const Text('Open Fullscreen Webview'),
        //       ),
        //       ElevatedButton(
        //         onPressed: () {
        //           Navigator.of(context).pushNamed('/widget');
        //         },
        //         child: const Text('Open widget webview'),
        //       ),
        //       Container(
        //         padding: const EdgeInsets.all(24.0),
        //         child: TextField(controller: _codeCtrl),
        //       ),
        //       ElevatedButton(
        //         onPressed: () {
        //           print(user);
        //           var javascript = "window.flutterInfo=${json.encode(user)}";
        //           print(javascript);
        //           print(json.encode(user));
        //           final future = flutterWebViewPlugin.evalJavascript(javascript);
        //           future.then((String? result) {
        //             print(result);
        //             setState(() {
        //               _history.add('eval: $result');
        //             });
        //           });
        //         },
        //         child: const Text("Add window's property"),
        //       ),
        //       ElevatedButton(
        //         onPressed: () {
        //           print(user);
        //           var javascript = "window.addItem(100)";
        //           print(javascript);
        //           final future = flutterWebViewPlugin.evalJavascript(javascript);
        //           future.then((String? result) {
        //             print(result);
        //             setState(() {
        //               _history.add('eval: $result');
        //             });
        //           });
        //         },
        //         child: const Text("调用js方法添加元素"),
        //       ),
        //       ElevatedButton(
        //         onPressed: () {
        //           print('result');
        //           final future =
        //               flutterWebViewPlugin.evalJavascript(_codeCtrl.text);
        //           future.then((String? result) {
        //             print(result);
        //             setState(() {
        //               _history.add('eval: $result');
        //             });
        //           });
        //         },
        //         child: const Text('Eval some javascript'),
        //       ),
        //       ElevatedButton(
        //         onPressed: () {
        //           final future = flutterWebViewPlugin
        //               .evalJavascript('alert("Hello World");');
        //           future.then((String? result) {
        //             setState(() {
        //               _history.add('eval: $result');
        //             });
        //           });
        //         },
        //         child: const Text('Eval javascript alert()'),
        //       ),
        //       ElevatedButton(
        //         onPressed: () {
        //           setState(() {
        //             _history.clear();
        //           });
        //           flutterWebViewPlugin.close();
        //         },
        //         child: const Text('Close'),
        //       ),
        //       ElevatedButton(
        //         onPressed: () {
        //           flutterWebViewPlugin.getCookies().then((m) {
        //             setState(() {
        //               _history.add('cookies: $m');
        //             });
        //           });
        //         },
        //         child: const Text('Cookies'),
        //       ),
        //       Text(_history.join('\n'))
        //     ],
        //   ),
        // ),
        body: Container());
  }
}
