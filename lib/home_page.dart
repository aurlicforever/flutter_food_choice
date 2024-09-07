import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  List<Map<String, dynamic>> listFoods = [
    {'name': 'Atassi','price': 500.0, 'bigDishPrice': 300.0,'imagePath': 'assets/images/atassi.png'},
    {'name': 'Riz blanc','price': 300.0, 'bigDishPrice': 200.0,'imagePath': 'assets/images/riz_blanc.png'},
    {'name': 'Riz au gras','price': 500.0, 'bigDishPrice': 300.0,'imagePath': 'assets/images/riz_au_gras.png'},
  ];

  List<Map<String, dynamic>> listIngredients = [
    {'name': 'Friture','price': 200.0, 'imagePath': 'assets/images/friture.png', 'selected': false},
    {'name': 'Farine','price': 100.0, 'imagePath': 'assets/images/farine.png', 'selected': false},
    {'name': 'Piment en poudre','price': 0.0, 'imagePath': 'assets/images/piment_poudre.png', 'selected': false},
    {'name': 'Frite','price': 500.0, 'imagePath': 'assets/images/frite.png', 'selected': false},
    {'name': 'Alloco','price': 300.0, 'imagePath': 'assets/images/alloco.png', 'selected': false},
  ];
  PageController pageController = PageController();
  PageController pageIngredientController = PageController(viewportFraction: 0.4, initialPage: 3);
  int currentPage = 0;
  double gridScrollStartX = 0;
  double gridScrollEndX = 0;
  String selectedFoodName = "";
  double selectedFoodPrice = 0.0;
  int selectedFoodIndex = 0;
  int selectedIngredientIndex = 0;
  List<Map<String, dynamic>> selectedIngredients = [];
  String devise = "F";
  double total = 0.0;
  String dish = "small";
  double bigDishPrice = 0.0;
  bool moveIngredient = false;
  bool like = false;
  final GlobalKey imageKey = GlobalKey();

  @override
  void initState() {
    selectedFoodName =  listFoods[0]['name'];
    selectedFoodPrice = listFoods[0]['price'];
    total += listFoods[0]['price'];
    selectedIngredients.add({});
    tabController = TabController(length: 2, vsync: this);

    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        if (tabController.index == 0){
          setState(() {
            dish = "small";
            bigDishPrice = 0;
          });
        }else{
          setState(() {
            dish = "big";
            bigDishPrice = listFoods[selectedFoodIndex]['bigDishPrice'];
          });
        }
      }
    });
    super.initState();
  }
  bool animate = false;
  late TabController tabController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.center,
                  colors: [Color(0x40ff1493),Colors.transparent ])
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.center,
                  colors: [Color(0x400084ff), Colors.transparent])
                ),
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      margin: const EdgeInsets.only(top: 40, left: 20),
                      child: const Icon(Icons.arrow_back_outlined),
                  )
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 25, right: 20),
                      child: IconButton(
                          icon: Icon(like ? Icons.favorite : Icons.favorite_border,
                              color: like ? Colors.pink : Colors.black),
                          iconSize: 30,
                          onPressed: () {
                            setState(() {
                              like = !like;
                            });
                          }
                      )
                  )
              ),
              Align(
                alignment: Alignment.topRight,
                  child: Container(
                    margin: const EdgeInsets.only(top: 15),
                      child: Image.asset("assets/images/feuilles.png", width: 150,)
                  ).animate(
                    onPlay: (controller) => controller.repeat(reverse: true),)
                      .rotate(begin: -0.01,end: 0.01, duration: 2.seconds)
              ),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      margin: const EdgeInsets.only(left: 50),
                      child: Transform.rotate(
                        angle: -0.2,
                          child: Image.asset("assets/images/feuilles.png", width: 150,))
                  ).animate(
                    onPlay: (controller) => controller.repeat(reverse: true),)
                      .rotate(begin: -0.02,end: 0.04, duration: 3.seconds)
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 70),
                      child: Image.asset("assets/images/circle_line.png", width: 150,)
                  )
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30,),
                    Text(selectedFoodName, style: const TextStyle(fontSize: 25),),
                    Text('${(total + bigDishPrice).toString()} ${devise.toString()}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 250,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x40ff1493).withOpacity(0.1), 
                                    offset: const Offset(0,3),
                                    spreadRadius: 2,
                                    blurRadius: 30,
                                  )
                                ]
                              ),
                              child: Image.asset(
                                "assets/images/planche.png", height: 300,
                                key: imageKey,
                              )
                            ).animate(
                                target: animate ? 1 : 0,
                                onInit: (controller) => controller.loop(count: 1, reverse: true),
                                onComplete: (controller) {
                                  setState(() {
                                    animate = false;
                                  });
                                },)
                                .shimmer(delay: 200.ms, duration: 800.ms, color: Colors.grey[800])
                                .shake(hz: 4, curve: Curves.easeInOutCubic, rotation: 0.05),
                          ),
                          DragTarget(
                            builder: (context, candidateData, rejectedData) {
                              return Container(
                                height: 250,
                              );
                            },
                            onAcceptWithDetails: (DragTargetDetails<Map<String, dynamic>> details) {
                              if (selectedIngredients.length < 6) {
                                setState(() {
                                  selectedIngredients.add(details.data);
                                  animate = true;
                                });
                              }
                            },
                          ),
                          DragTarget(
                            builder: (context, candidateData, rejectedData) {
                              return SizedBox(
                                height: 250,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: PageView.builder(
                                        controller: pageController,
                                        onPageChanged: (index){
                                          setState(() {
                                            selectedFoodIndex = index;
                                            selectedFoodName = listFoods[index]['name'];
                                            bigDishPrice = listFoods[index]['bigDishPrice'];
                                            total = total - selectedFoodPrice + listFoods[index]['price'];
                                            selectedFoodPrice = listFoods[index]['price'];
                                            currentPage = index;
                                          });
                                        },
                                        reverse: true,
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (_, index){
                                          return AnimatedBuilder(
                                            animation: pageController, 
                                            builder: (context, child) {
                                              return child!;
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(top: 25, left: 25),
                                              child: Stack(
                                                children: [
                                                  OverflowBox(
                                                    minHeight: 20,
                                                    maxHeight: double.infinity,
                                                    alignment: Alignment.topCenter,
                                                    child: Align(
                                                      alignment: Alignment.topLeft,
                                                      child: Image.asset(
                                                        listFoods[index]['imagePath'], 
                                                        height: 110,)
                                                        .animate()
                                                        .scaleXY(
                                                          end: dish == "small" ? 1 : (2.3) / 2, 
                                                          curve: Curves.easeInOutCubic
                                                        )
                                                        .shake(hz: 2, curve: Curves.easeInOutCubic)
                                                        .elevation(end: 20),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          );
                                        },
                                        itemCount: listFoods.length,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            onAcceptWithDetails: (DragTargetDetails<Map<String, dynamic>> details) {
                              if (selectedIngredients.length < 6) {
                                setState(() {
                                  selectedIngredients.add(details.data);
                                  animate = true;
                                });
                              }
                            },
                          ),

                          Center(
                            child: DragTarget(
                              onAcceptWithDetails: (DragTargetDetails<Map<String, dynamic>> details) {
                                if (selectedIngredients.length < 6) {
                                  setState(() {
                                    selectedIngredients.add(details.data);
                                    animate = true;
                                  });
                                }
                              },
                              builder: (context, candidateData, rejectedData) {
                                return Container(
                                  height: 200,
                                  width: 300,
                                  margin: const EdgeInsets.only(top: 30),
                                  child: GestureDetector(
                                    onHorizontalDragStart: (details) {
                                      gridScrollStartX = details.localPosition.dx;
                                    },
                                    onHorizontalDragUpdate: (details) {
                                      gridScrollEndX = details.localPosition.dx;
                                      if (gridScrollEndX > gridScrollStartX) {
                                        // Scroll right
                                        pageController.animateToPage(currentPage+1,
                                            duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                                      } else {
                                        // Scroll left
                                        pageController.animateToPage(currentPage-1,
                                            duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                                      }
                                      gridScrollStartX = gridScrollEndX;
                                    },
                                    child: GridView.builder(
                                      itemCount: selectedIngredients.length,
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 0,),

                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: const EdgeInsets.all(5),
                                          child: index > 0 ? OverflowBox(
                                            minHeight: 80,
                                            child: Stack(
                                              children: [
                                                Image.asset(
                                                  selectedIngredients[index]['imagePath'],
                                                  height: 80,
                                                  width: 80
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        total -= selectedIngredients[index]['price'];
                                                        listIngredients[index]['selected'] == false;
                                                      });
                                                      selectedIngredients.removeAt(index);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(50),
                                                        color: Colors.red,
                                                      ),
                                                      padding: const EdgeInsets.all(2),
                                                      child: const Icon(Icons.close, color: Colors.white, size: 15,),
                                                    ),
                                                  )
                                                ),
                                              ],
                                            ),
                                          )
                                          : Container(),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                          listFoods.length, (index){
                            return Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x40ff1493).withOpacity(0.1), 
                                    offset: const Offset(0,3),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  )
                                ]
                              ),
                              child: Image.asset(
                                listFoods[index]['imagePath'], 
                                height: selectedFoodIndex == index ? 20 : 15,),
                            );
                          }
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin:const EdgeInsets.only(top: 15),
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x40ff1493).withOpacity(0.1),
                                offset: const Offset(0,3),
                                spreadRadius: 5,
                                blurRadius: 15,)
                            ],
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: TabBar(
                            tabAlignment: TabAlignment.center,
                            controller: tabController,
                            labelColor: Colors.white,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.pink
                            ),
                            physics: const BouncingScrollPhysics(),
                            isScrollable: true,
                            labelPadding: const EdgeInsets.only(left: 5, right: 5),
                            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                            tabs: [
                              Tab(
                                child: Container(
                                  width: 90,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Text("Petit plat",
                                    ),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Text("GRAND PLAT",
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          ),
                            ),
                        ],
                    ),
                    //
                    const SizedBox(height: 50,),
                    const Text("Ingrédients", style: TextStyle(fontSize: 18,),),
                    const SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text(listIngredients[selectedIngredientIndex]["name"],
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),)
                    ).animate(
                      onPlay: (controller) => controller.repeat(reverse: true),)
                        .slideY(end: -0.3, duration: 1.seconds)
                        .rotate(begin: -0.01,end: 0.01, duration: 2.seconds),
                    Container(
                      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: const Color(0x500084ff),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text("${listIngredients[selectedIngredientIndex]["price"]} $devise",
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                    ).animate(
                      onPlay: (controller) => controller.repeat(reverse: true),)
                        .slideY(end: -0.3, duration: 1.seconds, delay: 500.ms,)
                        .rotate(begin: -0.01,end: 0.01, duration: 2.seconds),
                    Stack(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Transform(
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.01)
                                  ..rotateX(0.6),
                                  alignment: FractionalOffset.center,
                                child: Container(
                                  height: 80,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x400084ff).withOpacity(0.2),
                                        offset: const Offset(0,3),
                                        spreadRadius: 25,
                                        blurRadius: 50,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(0)
                                  ),
                                )
                              ),
                            ],
                          ).animate(
                            onPlay: (controller) => controller.repeat(reverse: true),)
                            .rotate(begin: -0.05,end: 0.05, duration: 2.seconds
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                          height: 150,
                          child: PageView.builder(
                            controller: pageIngredientController,
                            onPageChanged: (index){
                              setState(() {
                                selectedIngredientIndex = index;
                              });
                            },
                            reverse: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (_, index){
                              var scale = selectedIngredientIndex == index ? 1.0 : 0.7;
                              return TweenAnimationBuilder(
                                duration: const Duration(milliseconds: 350),
                                tween: Tween(begin: scale, end: scale),
                                curve: Curves.ease,
                                builder: (context, value, child) {
                                  return Transform.scale(scale: value, child: child);
                                },
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      LongPressDraggable(
                                        maxSimultaneousDrags: isIngredientSelected(listIngredients[index]) == true ? 0 : 1,
                                        delay: const Duration(milliseconds: 200),
                                        onDraggableCanceled: (velocity, offset) {},
                                        feedback: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: OverflowBox(
                                            child: Image.asset(
                                              listIngredients[index]['imagePath'], 
                                              height: 100,
                                              width: 100),
                                          ),
                                        ),
                                        data: listIngredients[index],
                                        child: GestureDetector(
                                          onTap: () {
                                            if (selectedIngredientIndex == index 
                                              && selectedIngredients.length < 6 
                                              && isIngredientSelected(listIngredients[index]) == false){
                                                setState(() {
                                                  moveIngredient = true;
                                                  selectedIngredientIndex = index;
                                                  animate = true;
                                                  listIngredients[index]['selected'] = true;
                                                  total += listIngredients[index]['price'];
                                                });
                                            }
                                          },
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(0x400084ff).withOpacity(0.2),
                                                  offset: const Offset(0,3),
                                                  spreadRadius: 2,
                                                  blurRadius: 50,
                                                ),
                                              ],
                                            ),
                                            child: OverflowBox(
                                              child: Opacity(
                                                opacity:  isIngredientSelected(listIngredients[index]) == true ? 0.5 : 1,
                                                child: Image.asset(
                                                  listIngredients[index]['imagePath'], 
                                                  height: 100,
                                                  width: 100,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: listIngredients.length,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x400084ff).withOpacity(0.3), 
                                offset: const Offset(0,9),
                                spreadRadius: 2,
                                blurRadius: 30,
                              )
                            ]
                          ),
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            label: const Text("Commander", 
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            icon: const Icon(Icons.shopping_cart,
                              color: Colors.white,
                              size: 20,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 33, 33, 33),
                              textStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),      
                  ],
                ),
              ),
              Align(
                child: GestureDetector(
                  onTap: () {},
                  child: Visibility(
                    visible: moveIngredient,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 165),
                      child: Image.asset(
                          listIngredients[selectedIngredientIndex]['imagePath'], 
                          height: 100,
                          width: 100)
                    )
                    .animate(onComplete: (controller) {
                      setState(() {
                        moveIngredient = false;
                        selectedIngredients.add(listIngredients[selectedIngredientIndex]);
                      });
                    },)
                      .slideY(begin: (1 + 1.1)/2 ,end: moveIngredient ? -0.5 : (1 + 1.1)/2, )
                      .scaleXY(end: 0.8, curve: Curves.easeInOutCubic)
                      .fadeIn(curve: Curves.easeIn),
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  bool compareIngredients(Map<String, dynamic> ingredient1, Map<String, dynamic> ingredient2) {
    return ingredient1['name'] == ingredient2['name'];
  }
  bool isIngredientSelected(Map<String, dynamic> ingredient) {
    for (var selectedIngredient in selectedIngredients) {
      if (compareIngredients(selectedIngredient, ingredient)) {
        return true; // The ingredient is selected
      }
    }
    return false; // The ingredient is not selected
  }
}