import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const TowerBox());
}

class TowerBox extends StatefulWidget {
  const TowerBox({super.key});

  @override
  State<TowerBox> createState() => _TowerBoxState();
}

class _TowerBoxState extends State<TowerBox> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late ListModel<int> _list;

  @override
  void initState() {
    var rng = math.Random();
    List<int> random = [];
    for (var i = 0; i <= 8; i++) {
      random.add(rng.nextInt(2) + 1);
    }
    super.initState();
    _list = ListModel<int>(
      listKey: _listKey,
      initialItems: <int>[
        0,
        random[0],
        random[1],
        random[2],
        random[3],
        random[4],
        random[5],
        random[6],
        random[7],
        random[8]
      ],
      removedItemBuilder: _buildRemovedItem,
    );
  }

  
  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _list[index],
    );
  }

  Widget _buildRemovedItem(
      int item, BuildContext context, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: item,
    );
  }

  void _remove() {
    if (_list._items[_list.length - 1] == 1) _list.removeAt(_list.length - 1);
  }
  void _remove2() {
    if (_list._items[_list.length - 1] == 2) _list.removeAt(_list.length - 1);
  }
  void _remove3() {
    if (_list._items[_list.length - 1] == 0) _list.removeAt(_list.length - 1);
  }

  late Timer _timer;
  late Timer _timer2;
  late Timer _timestart;

  int show = 2;
  int show2 = 2;
  int count = 0;

  bool button1 = false;
  bool button2 = false;
  

  void _destroy1() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        show = show-_timer.tick;
        if(show <=0){
          show =0;
          _timer.cancel();
        }
      });
      if (_timer.tick == 2) {
        //print('button1');
        button1 = true;
        //_timer.cancel();
        _remove();
        if (_list.length == 9) {
          Timer.periodic(const Duration(seconds: 1), (timer) {
            setState(() {
              count = timer.tick;
            });
          });
        }
        //isStart ==true;
        if (button2) {
          _remove3();
        }
        setState(() {
          _timestart = Timer(const Duration(seconds: 1), () {
            setState(() {
              show = 2;
            });
          });
        });
      }
      if (_timer.tick > 2) {
        button1 = false;
      }
      //print(_timer.tick);
    });
  }

  void _destroy2() {
    _timer2 = Timer.periodic(const Duration(seconds: 1), (timer) {
      //print(timer.tick);
      setState(() {
        show2 = show2-_timer2.tick;
        if(show2 <=0){
          show2 =0;
          _timer2.cancel();
        }
      });
      if (_timer2.tick == 2) {
        //print('button2');
        button2 = true;
        //_timer2.cancel();
        _remove2();
        if (_list.length == 9) {
          Timer.periodic(const Duration(seconds: 1), (timer) {
            setState(() {
              count = timer.tick;
            });
          });
        }

        if (button1) {
          _remove3();
        }
        setState(() {
          _timestart = Timer(const Duration(seconds: 1), () {
            setState(() {
              show2 = 2;
            });
          });
        });
      }
      if (_timer2.tick > 2) {
        button2 = false;
      }
    });
  }
  

  late int total = count;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: OrientationBuilder(builder: (_, orientation) {
        if (orientation == Orientation.portrait) {
          return Column(
            children: [
              Expanded(
                  flex: 6,
                  child: _list._items.isNotEmpty
                      ? Container(
                          color: Colors.grey[400],
                          child: SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              reverse: true,
                              child: AnimatedList(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                key: _listKey,
                                initialItemCount: _list.length,
                                itemBuilder: _buildItem,
                              )),
                        )
                      : Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.grey[400],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 200,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Total Time',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 23),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        '${total}s',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ))),
                            ],
                          ),
                        )),
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    SizedBox(
                      height: 75,
                      width: 75,
                      child: GestureDetector(
                        
                        onTapDown: (_) async{
                          _destroy1();
                           
                        },
                        onTapUp: (_) async{
                          
                          _timer.cancel();
                          _timer2.cancel();
                          setState(() {
                            show =2;
                            
                          });
                          if (!button1) {
                          } else {
                            button1 = false;
                          }
                          
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.pink[50],
                              border: Border.all(),
                              shape: BoxShape.circle),
                          alignment: Alignment.center,
                          child: Text(show.toString()),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 75,
                      width: 75,
                      child: GestureDetector(
                        onTapDown: (_) {
                          _destroy2();
                         
                        },
                        onTapUp: (_) {
                          _timer.cancel();
                          _timer2.cancel();
                          setState(() {
                            show2 =2;
                          });
                          if (!button2) {
                          } else {
                            button2 = false;
                          }
                          
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue[200],
                              border: Border.all(),
                              shape: BoxShape.circle),
                          alignment: Alignment.center,
                          child: Text(show2.toString()),
                        ),
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 75,
                      width: 75,
                      child: GestureDetector(
                        onTapDown: (_) {
                          _destroy1();
                          
                        },
                        onTapUp: (_) {
                          _timer.cancel();
                          _timer2.cancel();
                          setState(() {
                            show =2;
                          });
                          if (!button1) {
                          } else {
                            button1 = false;
                          }
                          
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.pink[50],
                              border: Border.all(),
                              shape: BoxShape.circle),
                          alignment: Alignment.center,
                          child: Text(show.toString()),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 5,
                  child: _list._items.isNotEmpty
                      ? Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.grey[400],
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            reverse: true,
                            child: AnimatedList(
                              physics: const NeverScrollableScrollPhysics(),

                              shrinkWrap: true,
                              //reverse: true,
                              key: _listKey,
                              initialItemCount: _list.length,
                              itemBuilder: _buildItem,
                            ),
                          ),
                        )
                      : Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.grey[400],
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 200,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Total Time',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 23),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          '${total}s',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ))),
                              ]))),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 75,
                      width: 75,
                      child: GestureDetector(
                        onTapDown: (_) {
                          _destroy2();
                          
                        },
                        onTapUp: (_) {
                          _timer.cancel();
                          _timer2.cancel();
                          setState(() {
                            show2 =2;
                          });
                          if (!button2) {
                          } else {
                            button2 = false;
                          }
                          
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue[200],
                              border: Border.all(),
                              shape: BoxShape.circle),
                          alignment: Alignment.center,
                          child: Text(show2.toString()),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )
            ],
          );
        }
      })
          //isPortrait ?

          ),
    );
  }
  
}

typedef RemovedItemBuilder<T> = Widget Function(
    T item, BuildContext context, Animation<double> animation);

class ListModel<E> {
  ListModel({
    required this.listKey,
    required this.removedItemBuilder,
    Iterable<E>? initialItems,
  }) : _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final RemovedItemBuilder<E> removedItemBuilder;
  final List<E> _items;

  AnimatedListState? get _animatedList => listKey.currentState;

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList!.removeItem(
        index,
        (BuildContext context, Animation<double> animation) {
          return removedItemBuilder(removedItem, context, animation);
        },
      );
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];
}

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.animation,
    required this.item,
  }) : assert(item >= 0);

  final Animation<double> animation;

  final int item;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 35 / 100;
    var isP = MediaQuery.of(context).orientation == Orientation.portrait;
    //double width = 400 * 35 / 100;
    if (isP) {
      if (item == 0) {
        return SizedBox(
          height: 175,
          width: 300,
          child: SizeTransition(
            sizeFactor: animation,
            child: Transform.rotate(
              angle: -math.pi / 4,
              child: Center(
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: Container(
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
          ),
        );
      } else if (item == 1) {
        return SizeTransition(
          sizeFactor: animation,
          child: SizedBox(
            height: 75.0,
            child: Container(
              margin: EdgeInsets.only(left: width, right: width, bottom: 5.0),
              decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.pink[50],
                  borderRadius: BorderRadius.circular(8.0)),
            ),
          ),
        );
      } else {
        return SizeTransition(
          sizeFactor: animation,
          child: SizedBox(
            height: 75.0,
            child: Container(
              margin: EdgeInsets.only(left: width, right: width, bottom: 5.0),
              decoration: BoxDecoration(
                  color: Colors.blue[200],
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8.0)),
            ),
          ),
        );
      }
    } else {
      if (item == 0) {
        return SizedBox(
          height: 180,
          width: 300,
          child: SizeTransition(
            sizeFactor: animation,
            child: Transform.rotate(
              angle: -math.pi / 4,
              child: Center(
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: Container(
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
          ),
        );
      } else if (item == 1) {
        return FractionallySizedBox(
          widthFactor: .3,
          child: SizeTransition(
            sizeFactor: animation,
            child: SizedBox(
              height: 75.0,
              child: Container(
                margin: const EdgeInsets.only(bottom: 5.0),
                decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.pink[50],
                    borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
          ),
        );
      } else {
        return FractionallySizedBox(
          widthFactor: .3,
          child: SizeTransition(
            sizeFactor: animation,
            child: SizedBox(
              height: 75.0,
              child: Container(
                margin: const EdgeInsets.only(bottom: 5.0),
                decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
          ),
        );
      }
    }
  }
  
}