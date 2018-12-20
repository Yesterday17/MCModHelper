///
/// Inspired by: https://github.com/TartaricAcid/TinkersForgingCalculator
///

import 'package:flutter/material.dart';
import '../utils/enum.dart';

class _HitPair {
  int value;
  String name;

  _HitPair(this.value, this.name);
}

class _Hits extends Enum<_HitPair> {
  const _Hits(_HitPair val) : super(val);

  /// 轻击
  static _Hits hitLight = _Hits(_HitPair(
    -3,
    '轻击',
  ));

  /// 击打
  static _Hits hitMedium = _Hits(_HitPair(
    -6,
    '击打',
  ));

  /// 重击
  static _Hits hitHard = _Hits(_HitPair(
    -9,
    '重击',
  ));

  /// 牵拉
  static _Hits draw = _Hits(_HitPair(
    -15,
    '牵拉',
  ));

  /// 冲压
  static _Hits punch = _Hits(_HitPair(
    2,
    '冲压',
  ));

  /// 弯曲
  static _Hits bend = _Hits(_HitPair(
    7,
    '弯曲',
  ));

  /// 镦锻
  static _Hits upset = _Hits(_HitPair(
    13,
    '镦锻',
  ));

  /// 收缩
  static _Hits shrink = _Hits(_HitPair(
    16,
    '收缩',
  ));

  /// 留空
  static _Hits empty = _Hits(_HitPair(
    0,
    '留空',
  ));

  static List<_Hits> toList() {
    List<_Hits> list = List();
    list.add(hitLight);
    list.add(hitMedium);
    list.add(hitHard);
    list.add(draw);
    list.add(punch);
    list.add(bend);
    list.add(upset);
    list.add(shrink);
    list.add(empty);
    return list;
  }
}

///
/// Calculator class
///
class _Calculate {
  static int getSum(List<int> list, {int getSum = 0}) {
    //
  }

  /// calculate
  static int calc() {}
}

class TinkersForgingCalcualtor extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<TinkersForgingCalcualtor> {
  final List<_Hits> _hitOperation = _Hits.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tinker\'s Forging 锻造计算器'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20.0),
            child: Text('Calculator EditText Area.'),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return GridTile(
                  child: FlatButton(
                    onPressed: () {
                      return 1;
                    },
                    child: Center(
                      child: Text(
                        _hitOperation[index].value.name,
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
