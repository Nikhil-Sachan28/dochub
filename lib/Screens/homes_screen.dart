import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_tut/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class HomesScreen extends StatefulWidget {
  const HomesScreen({super.key});

  @override
  State<HomesScreen> createState() => _HomesScreenState();
}

class _HomesScreenState extends State<HomesScreen> {
  TextEditingController locationController = TextEditingController();
  String Address = "";
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Location services are disabled.');

    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
        return ;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
     Position currentPosition = await Geolocator.getCurrentPosition();
      print(currentPosition.latitude.toString());
      print("\n");
      print(currentPosition.longitude.toString());
      List<Placemark> placemarks = await placemarkFromCoordinates(currentPosition.latitude, currentPosition.longitude);
      locationController.text = placemarks[0].locality.toString() +" "+ placemarks[0].country.toString();
      setState(() {
        Address = placemarks[0].thoroughfare.toString()+ " " + placemarks[0].subLocality.toString();
      });

  }

  List imageList = [
    {"id" : 1, "image" : 'assets/images/slide1.jpeg'},
    {"id" : 2, "image" : 'assets/images/slider2.jpeg'},
    {"id" : 3, "image" : 'assets/images/slider3.jpeg'},
  ];

  List doctors = [
    {"name" : "Dr.Shraddha Sharma", "degree" : "MBBS, MS", "rating" : "4.5", "reviews" : "48", "experience" : "4", "image" : "assets/images/doc1.jpeg" },
    {"name" : "Dr.Somya Tiwari", "degree" : "BPT, MPT", "rating" : "4.9", "reviews" : "1000", "experience" : "5",  "image" : "assets/images/doc2.jpeg"  },
    {"name" : "Dr. Aman", "degree" : "BHHS", "rating" : "4.8", "reviews" : "50", "experience" : "5",  "image" : "assets/images/doc3.jpeg"  },
    {"name" : "Dr. Harsh", "degree" : "MBBS, MS", "rating" : "5", "reviews" : "148", "experience" : "2",  "image" : "assets/images/doc4.jpeg"  },
    {"name" : "Dr. S.K.", "degree" : "MBBS, MD", "rating" : "5", "reviews" : "1048", "experience" : "10",  "image" : "assets/images/doc5.jpeg"  },
  ];

  List hospitals = [
    {"name" : "Care Hospital", "Address" : "Delhi", "rating" : "4.5", "reviews" : "48", "experience" : "4", "image" : "assets/images/hosp1.jpeg" },
    {"name" : "Sarvodaya Hospital", "Address" : "Faridabad", "rating" : "4.9", "reviews" : "1000", "experience" : "5",  "image" : "assets/images/hosp2.jpeg"  },
    {"name" : "Apollo Hospital", "Address" : "Delhi", "rating" : "4.8", "reviews" : "50", "experience" : "5",  "image" : "assets/images/hosp3.jpeg"  },
    {"name" : "Aster Hospital", "Address" : "Noida", "rating" : "5", "reviews" : "148", "experience" : "2",  "image" : "assets/images/hosp4.jpeg"  },
    {"name" : "Shaley Hospital", "Address" : "Kanpur", "rating" : "5", "reviews" : "1048", "experience" : "10",  "image" : "assets/images/hosp5.jpeg"  },
  ];

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  Widget getHeader(){
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 10,),
                Icon(Icons.location_on, size: 40,color: AppColors.carrot,),
                Expanded(child: Container(
                    child: Row(
                      children: [

                        Expanded(
                          // width: MediaQuery.of(context).size.width/2,
                          flex : 5,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(locationController.text,softWrap: true, maxLines: 1,style: TextStyle(
                                    color: AppColors.carrot,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Finlandia"
                                ),),
                                Text(Address,softWrap: true, maxLines: 1,style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Finlandia"
                                ),)
                              ]),
                        ),

                        Expanded(
                          // width: 20,
                          flex: 1,
                          child: IconButton(
                            onPressed: (){
                              getCurrentLocation();
                            },
                            icon: Icon(Icons.arrow_drop_down_circle),
                          ),
                        ),
                      ],
                    )

                )),
                SizedBox(
                  width: 30,
                  child: CircleAvatar(
                    child: Icon(Icons.notifications,  color: AppColors.carrot,),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 30,
                  child: CircleAvatar(
                    child: Icon(Icons.menu, color: AppColors.carrot,),
                  ),
                ),
                SizedBox(width: 10,)
              ],
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black12),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                    children: [
                      SizedBox(width: 10,),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Find Your suitable doctor",
                              border: InputBorder.none
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                        child: Icon(Icons.search),
                      )
                    ]
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // shrinkWrap: true,
            // scrollDirection: Axis.vertical,
            children: [
              // Card(
              //   color: Colors.transparent,
              //   elevation: 0,
              //   child: Padding(
              //     padding: EdgeInsets.all(10),
              //     child: Column(
              //       children: [
              //         Row(
              //           children: [
              //             SizedBox(width: 10,),
              //             Icon(Icons.location_on, size: 40,color: AppColors.carrot,),
              //             Expanded(child: Container(
              //               child: Row(
              //                 children: [
              //
              //                   Expanded(
              //                     // width: MediaQuery.of(context).size.width/2,
              //                     flex : 5,
              //                     child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                         children: [
              //                         Text(locationController.text,softWrap: true, maxLines: 1,style: TextStyle(
              //                           color: AppColors.carrot,
              //                           fontSize: 18,
              //                           fontWeight: FontWeight.w600,
              //                             fontFamily: "Finlandia"
              //                         ),),
              //                         Text(Address,softWrap: true, maxLines: 1,style: TextStyle(
              //                           fontSize: 12,
              //                           fontWeight: FontWeight.w500,
              //                           fontFamily: "Finlandia"
              //                         ),)
              //                       ]),
              //                   ),
              //
              //                   Expanded(
              //                     // width: 20,
              //                     flex: 1,
              //                     child: IconButton(
              //                       onPressed: (){
              //                         getCurrentLocation();
              //                       },
              //                       icon: Icon(Icons.arrow_drop_down_circle),
              //                     ),
              //                   ),
              //                 ],
              //               )
              //
              //             )),
              //             SizedBox(
              //               width: 30,
              //               child: CircleAvatar(
              //                 child: Icon(Icons.notifications,  color: AppColors.carrot,),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 10,
              //             ),
              //             SizedBox(
              //               width: 30,
              //               child: CircleAvatar(
              //                 child: Icon(Icons.menu, color: AppColors.carrot,),
              //               ),
              //             ),
              //             SizedBox(width: 10,)
              //           ],
              //         ),
              //         SizedBox(height: 10,),
              //         Padding(
              //           padding: EdgeInsets.symmetric(horizontal: 10),
              //           child: Container(
              //             height: 50,
              //             decoration: BoxDecoration(
              //               border: Border.all(width: 2, color: Colors.black12),
              //               borderRadius: BorderRadius.circular(10)
              //             ),
              //             child: Row(
              //               children: [
              //                 SizedBox(width: 10,),
              //                 Expanded(
              //                   child: TextField(
              //                     decoration: InputDecoration(
              //                         hintText: "Find Your suitable doctor",
              //                       border: InputBorder.none
              //                     ),
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   width: 30,
              //                   child: Icon(Icons.search),
              //                 )
              //               ]
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              getHeader(),
              Padding(
                padding: EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  // padding: EdgeInsets.all(20),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 1.05,
                    // decoration: BoxDecoration(
                    //   border: Border.all(width: 2),
                    //   borderRadius: BorderRadius.circular(20),
                    //
                    // ),
                    child: CarouselSlider(
                      carouselController: carouselController,
                      items: imageList.map(
                                (item) => Image.asset(item['image'],
                                  fit: BoxFit.cover,
                                  width: double.infinity -50,
                                  height: 150,
                                )).toList(),

                      options: CarouselOptions(
                        scrollDirection: Axis.horizontal,
                        scrollPhysics: BouncingScrollPhysics(),
                        aspectRatio: 16/9,
                        // viewportFraction: 0.8,
                        viewportFraction: 1,
                        autoPlay: true,
                        enableInfiniteScroll:true,
                        enlargeFactor: 0.3,
                        autoPlayInterval: Duration(seconds: 3),
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),



                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imageList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => carouselController.animateToPage(entry.key),
                    child: Container(
                      width: currentIndex == entry.key ? 17 : 7,
                      height: 7.0,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 3.0,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: currentIndex == entry.key
                              ? Colors.red
                              : AppColors.carrot),
                    ),
                  );
                }).toList(),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child:Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(),
                        child: Container(
                          // width: 100,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.pink,
                            borderRadius: BorderRadius.circular(10)
                
                          ),
                          child: Image.asset("assets/images/doctor.png"),
                        )
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child:Card(
                          elevation: 0,

                          shape: RoundedRectangleBorder(),
                          child: Container(
                            // width: 100,
                            height: 60,
                            decoration: BoxDecoration(
                                color: AppColors.face,
                                borderRadius: BorderRadius.circular(10)
                
                            ),
                            child: Image.asset("assets/images/appointment.png"),
                          )
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child:Card(
                          elevation: 0,

                          shape: RoundedRectangleBorder(),
                          child: Container(
                            // width: 100,
                            height: 60,
                            decoration: BoxDecoration(
                                color: AppColors.lightParrotGreen,
                                borderRadius: BorderRadius.circular(10)
                
                            ),
                            child: Image.asset("assets/images/prescription.png"),
                          )
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child:Card(
                          elevation: 0,

                          shape: RoundedRectangleBorder(),
                          child: Container(
                            // width: 100,
                            height: 60,
                            decoration: BoxDecoration(
                                color: AppColors.lightGreen,
                                borderRadius: BorderRadius.circular(10)
                
                            ),
                            child: Image.asset("assets/images/chemist.png"),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Row(
                  children: [
                    Expanded(child: Center(child: Text("Doctor", style: TextStyle(
                      fontFamily: "Finlandia",
                      fontSize: 12,
                      fontWeight: FontWeight.w500
                    ),
                    ))),
                    Expanded(child: Center(child: Text("Appointment", style: TextStyle(
                        fontFamily: "Finlandia",
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                    ),))),
                    Expanded(child: Center(child: Text("Prescriptions", style: TextStyle(
                        fontFamily: "Finlandia",
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                    ),))),
                    Expanded(child: Center(child: Text("Chemist", style: TextStyle(
                        fontFamily: "Finlandia",
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                    ),)))
                  ],
                ),
              ),
              Card(
                color: Colors.transparent,
                elevation: 0,
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Row(
                              children: [
                                Text("Our Doctors", style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Finlandia",
                                    fontWeight: FontWeight.bold

                                ),),
                                Spacer(),
                                InkWell(
                                  onTap: (){

                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.carrot
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      child: Text("See More", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: "Finlandia",

                                      ),),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      // width: 300,
                      height: 280,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: doctors.length,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                  width: 180,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: AppColors.pink),
                                    // color: AppColors.face
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                          flex:6,
                                          child: Image.asset(doctors[index]['image'], height: 170,)),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(doctors[index]["name"],
                                                style: TextStyle(
                                                    fontFamily: "Finlandia",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14
                                                ),
                                              ),
                                              Text(doctors[index]["degree"], style: TextStyle(
                                                  fontFamily: "Finlandia",
                                                  // fontWeight: FontWeight.bold,
                                                  fontSize: 14
                                              ),),
                                              Row(
                                                children: [
                                                  Icon(Icons.star, color: Colors.yellow, size: 20,),
                                                  Text(doctors[index]["rating"], style: TextStyle(
                                                      fontFamily: "Finlandia",
                                                      // fontWeight: FontWeight.bold,
                                                      fontSize: 12
                                                  ),),
                                                  Text("(${doctors[index]["reviews"]})", style: TextStyle(
                                                      fontFamily: "Finlandia",
                                                      // fontWeight: FontWeight.bold,
                                                      fontSize: 12
                                                  ),),
                                                  Spacer(),
                                                  Icon(Icons.shopping_bag, size: 20,),
                                                  Text("${doctors[index]["experience"]} Years", style: TextStyle(
                                                      fontFamily: "Finlandia",
                                                      // fontWeight: FontWeight.bold,
                                                      fontSize: 12
                                                  ),)
                                                ],
                                              )

                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(10)),

                                          child: Container(
                                            color: AppColors.carrot,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 10),
                                              child: Row(
                                                children: [
                                                  Text("See doctor Now", style: TextStyle(
                                                      fontFamily: "Finlandia",
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 14
                                                  ),),
                                                  Spacer(),
                                                  Icon(Icons.video_call)

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            );
                          }
                      ),
                    )
                  ],
                ),
              ),
              Card(
                // color: Colors.transparent,
                elevation: 0,
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Row(
                              children: [
                                Text("Our Hospitals", style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Finlandia",
                                    fontWeight: FontWeight.bold

                                ),),
                                Spacer(),
                                InkWell(
                                  onTap: (){

                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.carrot
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      child: Text("See More", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: "Finlandia",

                                      ),),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      // width: 300,
                      height: 280,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: hospitals.length,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                  width: 180,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: AppColors.pink),
                                    // color: AppColors.face
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                          flex:6,
                                          child: Image.asset(hospitals[index]['image'], height: 170,)),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(hospitals[index]["name"],
                                                style: TextStyle(
                                                    fontFamily: "Finlandia",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14
                                                ),
                                              ),
                                              Text(hospitals[index]["Address"], style: TextStyle(
                                                  fontFamily: "Finlandia",
                                                  // fontWeight: FontWeight.bold,
                                                  fontSize: 14
                                              ),),
                                              Row(
                                                children: [
                                                  Icon(Icons.star, color: Colors.yellow, size: 20,),
                                                  Text(hospitals[index]["rating"], style: TextStyle(
                                                      fontFamily: "Finlandia",
                                                      // fontWeight: FontWeight.bold,
                                                      fontSize: 12
                                                  ),),
                                                  Text("(${hospitals[index]["reviews"]})", style: TextStyle(
                                                      fontFamily: "Finlandia",
                                                      // fontWeight: FontWeight.bold,
                                                      fontSize: 12
                                                  ),),
                                                  // Spacer(),
                                                  // Icon(Icons.shopping_bag, size: 20,),
                                                  // Text("${doctors[index]["experience"]} Years", style: TextStyle(
                                                  //     fontFamily: "Finlandia",
                                                  //     // fontWeight: FontWeight.bold,
                                                  //     fontSize: 12
                                                  // ),)
                                                ],
                                              )

                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(10)),

                                          child: Container(
                                            color: AppColors.carrot,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 10),
                                              child: Row(
                                                children: [
                                                  Text("Visit Hospital", style: TextStyle(
                                                      fontFamily: "Finlandia",
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 14
                                                  ),),
                                                  Spacer(),
                                                  Icon(Icons.video_call)

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            );
                          }
                      ),
                    )
                  ],
                ),
              ),



            ],

          ),
        ),
      ),
    );
  }
}
