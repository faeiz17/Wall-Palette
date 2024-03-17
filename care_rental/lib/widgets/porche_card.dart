import 'package:care_rental/colors.dart';
import 'package:care_rental/porsche.dart';
import 'package:flutter/material.dart';

class PorscheCard extends StatefulWidget {
  final Porsche variant;

  PorscheCard({required this.variant});

  @override
  State<PorscheCard> createState() => _PorscheCardState();
}

class _PorscheCardState extends State<PorscheCard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 300,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: widget.variant.colors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          GestureDetector(
            onTap: () => setState(() {
              widget.variant.isfavourite = !widget.variant.isfavourite;
            }),
            child: Padding(
              padding: EdgeInsets.all(5),
              child: widget.variant.isfavourite
                  ? Icon(
                      Icons.favorite,
                      size: 30,
                      color: Colors.red,
                    )
                  : Icon(
                      Icons.favorite_border_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
            ),
          ),
        ]),
        Image.asset(
          widget.variant.imageUrl,
          height: 100,
          width: 300,
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.variant.name,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2, left: 8),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.start,

              Icon(
                Icons.calendar_today,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Model Year " + widget.variant.modelYear,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 2, left: 8),
          child: Row(
            children: [
              Icon(
                Icons.attach_money,
                color: Colors.white,
              ),
              Text(
                " Price " + widget.variant.price.toString() + " K",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 2, left: 8),
          child: Row(
            children: [
              Icon(
                Icons.circle_sharp,
                color: widget.variant.colors.first,
              ),
              Text(
                " Color " + widget.variant.color,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 2, left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "More Details",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.arrow_circle_right_outlined,
                      color: widget.variant.colors.first,
                      size: 25,
                    ),
                  ],
                ),
                Row(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                   OutlinedButton( child: child)
                  ],
                ),
              ],
            ),
          ),
        )
      ]),

      // child: Row(
      //   children: [
      //     // Image on the right side
      //     Expanded(
      //       flex: 2,
      //       child: Image.asset(
      //         variant.imageUrl,
      //         //it: BoxFit.cover,
      //         height: 150,
      //         width: 300,
      //       ),
      //     ),
      //     // Details on the left side
      //     Expanded(
      //       flex: 2,
      //       child: Padding(
      //         padding: const EdgeInsets.all(10.0),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.end,
      //           children: [
      //             Icon(Icons.favorite),
      //             Text(
      //               variant.name,
      //               style: TextStyle(
      //                 fontFamily: "Roboto Mono",
      //                 fontSize: 24.0,
      //                 fontWeight: FontWeight.bold,
      //                 color: Colors.white,
      //               ),
      //             ),
      //             //SizedBox(height: 10.0),
      //             Row(
      //               children: [
      //                 Icon(Icons.calendar_today, color: Colors.white),
      //                 SizedBox(width: 5.0),
      //                 Text(
      //                   'Model Year: ${variant.modelYear}',
      //                   style: TextStyle(fontSize: 14.0, color: Colors.white),
      //                 ),
      //               ],
      //             ),
      //             SizedBox(height: 5.0),
      //             Row(
      //               children: [
      //                 Icon(Icons.color_lens, color: Colors.white),
      //                 SizedBox(width: 5.0),
      //                 Text(
      //                   '{variant.colors}',
      //                   style: TextStyle(fontSize: 14.0, color: Colors.white),
      //                 ),
      //               ],
      //             ),
      //             SizedBox(height: 5.0),
      //             Row(
      //               children: [
      //                 Icon(Icons.attach_money, color: Colors.white),
      //                 SizedBox(width: 5.0),
      //                 Text(
      //                   'Price: \$${variant.price.toStringAsFixed(2)}',
      //                   style: TextStyle(fontSize: 14.0, color: Colors.white),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
