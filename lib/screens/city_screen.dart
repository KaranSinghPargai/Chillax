import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chillax/utilities/constants.dart';
import 'package:chillax/services/networking.dart';
import 'package:google_fonts/google_fonts.dart';
class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xff082032),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children:[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_outlined,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: kTextFieldInputDecoration,
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
              FlatButton(
                onPressed: ()async {
                  NetworkHelper netWorking=NetworkHelper('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=35bb66586ed9239e8100c9c6cd1478f3');
                  var hasData= await netWorking.getData();
                  if(hasData==null){
                   showCupertinoDialog(context: context, builder: (context){
                     return CupertinoAlertDialog(
                       title: Text('Place not found, try another keywords',style: GoogleFonts.asap(),),
                       actions: [
                         TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Ok',style: GoogleFonts.asap(),),),
                       ],
                     );
                   });
                  }
                  else{
                    Navigator.pop(context, cityName);
                  }
                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
