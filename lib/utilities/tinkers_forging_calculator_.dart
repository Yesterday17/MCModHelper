///
/// Inspired by: https://github.com/TartaricAcid/TinkersForgingCalculator
///

import 'package:flutter/material.dart';

class _HitPair {
  String name;
  int value;

  _HitPair(this.value, this.name);

  @override
  String toString() {
    return name;
  }
}

abstract class _Hits {
  /// 轻击
  static _HitPair hitLight = _HitPair(
    -3,
    '轻击',
  );

  /// 击打
  static _HitPair hitMedium = _HitPair(
    -6,
    '击打',
  );

  /// 重击
  static _HitPair hitHard = _HitPair(
    -9,
    '重击',
  );

  /// 牵拉
  static _HitPair draw = _HitPair(
    -15,
    '牵拉',
  );

  /// 冲压
  static _HitPair punch = _HitPair(
    2,
    '冲压',
  );

  /// 弯曲
  static _HitPair bend = _HitPair(
    7,
    '弯曲',
  );

  /// 镦锻
  static _HitPair upset = _HitPair(
    13,
    '镦锻',
  );

  /// 收缩
  static _HitPair shrink = _HitPair(
    16,
    '收缩',
  );

  /// 留空
  static _HitPair empty = _HitPair(
    0,
    '留空',
  );

  static List<_HitPair> toList() {
    List<_HitPair> list = List();
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
  List<_HitPair> hits = List();
  int _hitCount = 1;

  int get hitCount => _hitCount;
  bool get canHitEmpty => _hitCount == 3;
  bool get canHit => _hitCount <= 3;

  List<List<_HitPair>> ans = [];

  static _Calculate instance = _Calculate();

  int getSum(List<_HitPair> list, {int getSum = 0}) {
    int sum = 0;
    for (_HitPair hit in list) {
      sum += hit.value;
    }
    return sum + getSum;
  }

  void hit(_HitPair hit) {
    _hitCount++;
    if (hit.value != 0) hits.insert(0, hit);
    if (hitCount > 3) {
      ans = calculate();
    }
  }

  void unhit() {
    if (_hitCount > 1) {
      _hitCount--;
      hits = hits.sublist(1);
    }
    this.ans.clear();
  }

  void reset() {
    this.hits.clear();
    this.ans.clear();
    this._hitCount = 1;
  }

  /// calculate
  List<List<_HitPair>> calculate() {
    int value = -getSum(hits), count = 10;

    List<List<_HitPair>> total = [
      [_Hits.empty]
    ];
    List<List<_HitPair>> tmp = [];
    List<List<_HitPair>> result = [[]];

    for (int i = 0; i < count; i++) {
      for (List<_HitPair> j in total) {
        for (_HitPair hit in _Hits.toList()) {
          if (hit == _Hits.empty) continue;

          int v = getSum(j, getSum: hit.value);
          if (v > -150 && v < 150) {
            List<_HitPair> tmpJ = j.sublist(0);
            tmpJ.add(hit);
            if (getSum(j, getSum: hit.value) == value) {
              tmpJ.addAll(hits);
              result.add(tmpJ.sublist(1));
            } else
              tmp.add(tmpJ);
          }
        }
      }
      total = tmp.sublist(0);
      tmp.clear();
      if (result.length > 1) break;
    }
    return result.sublist(1);
  }
}

class TinkersForgingCalcualtor extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<TinkersForgingCalcualtor> {
  final List<_HitPair> _hitOperation = _Hits.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tinker\'s Forging 锻造计算器'),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                constraints: BoxConstraints.expand(
                  height:
                      Theme.of(context).textTheme.display1.fontSize * 1.1 + 110,
                ),
                color: Theme.of(context).bottomAppBarColor,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 4.0, 0.0, 0.0),
                          child: Text(
                            _Calculate.instance.canHit
                                ? '请输入倒数第 ${_Calculate.instance.hitCount} 次锻造操作：'
                                : '锻造完成！',
                            style: Theme.of(context).textTheme.subhead.merge(
                                  TextStyle(color: Colors.greenAccent),
                                ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
                          child: Text(
                              '目前的锻造： ${_Calculate.instance.hitCount == 1 ? '无' : _Calculate.instance.hits.join(', ')}'),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 4.0, 0.0, 4.0),
                          child:
                              Text(_Calculate.instance.canHit ? '' : '锻造方案如下：'),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _Calculate.instance.ans.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              dense: true,
                              title: Text(
                                  '方案${index + 1}：${_Calculate.instance.ans[index].join(' -> ')}'),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('锻造方案'),
                                        content: Text(
                                          _Calculate.instance.ans[index]
                                              .join('->'),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('关闭'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                alignment: FractionalOffset.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: (() {
                    List<Widget> result = <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          MaterialButton(
                            minWidth: MediaQuery.of(context).size.width / 2,
                            child: Text('撤销'),
                            onPressed: _Calculate.instance.hitCount == 1
                                ? null
                                : () {
                                    setState(() {
                                      _Calculate.instance.unhit();
                                    });
                                  },
                          ),
                          MaterialButton(
                            minWidth: MediaQuery.of(context).size.width / 2,
                            child: Text('重置'),
                            onPressed: () {
                              setState(() {
                                _Calculate.instance.reset();
                              });
                            },
                          ),
                        ],
                      )
                    ];
                    List<Widget> rowWidgets = <Widget>[];
                    int i = 0;
                    for (_HitPair hit in _hitOperation) {
                      rowWidgets.add(
                        MaterialButton(
                          height: MediaQuery.of(context).size.width / 3,
                          minWidth: MediaQuery.of(context).size.width / 3,
                          onPressed: (!_Calculate.instance.canHit ||
                                  !_Calculate.instance.canHitEmpty &&
                                      hit.value == 0)
                              ? null
                              : () {
                                  setState(() {
                                    _Calculate.instance.hit(hit);
                                  });
                                },
                          child: Center(
                            child: Text(
                              hit.name,
                              textScaleFactor: 1.3,
                            ),
                          ),
                        ),
                      );

                      i++;

                      if (i / 3 == 1) {
                        i = 0;
                        result.add(Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: rowWidgets,
                        ));
                        rowWidgets = <Widget>[];
                      }
                    }
                    return result;
                  })(),
                ),
              ),
            ],
          ),
        ));
  }
}
