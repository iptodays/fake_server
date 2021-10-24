/*
 * @Author: iptoday 
 * @Date: 2021-10-24 22:06:55 
 * @Last Modified by: iptoday
 * @Last Modified time: 2021-10-24 22:21:03
 */
import 'package:fake_server/pages/home/home.dart';
import 'package:fake_server/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with AutomaticKeepAliveClientMixin {
  /// 当前选中下标
  int _cIndex = 0;

  final List<Widget> _pages = <Widget>[
    const HomePage(),
  ];

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Row(
        children: <Widget>[
          _menusViewBuilder(),
          Expanded(
            child: _pageViewBuilder(),
          )
        ],
      ),
    );
  }

  /// 菜单栏
  Widget _menusViewBuilder() {
    return Container(
      width: 62,
      color: HexColor('#e4e4e5').withOpacity(0.4),
      padding: const EdgeInsets.only(top: 44),
      child: Column(
        children: <Widget>[
          CustomButton(
            child: Icon(Icons.satellite_sharp),
          ),
        ],
      ),
    );
  }

  /// 主体内容
  Widget _pageViewBuilder() {
    return PageView(
      controller: _controller,
      children: _pages,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
