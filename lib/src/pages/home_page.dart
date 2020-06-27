import 'dart:math';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:covid19/src/model/dactor_model.dart';
import 'package:covid19/src/model/user.dart';
import 'package:covid19/src/model/data.dart';
import 'package:covid19/src/theme/extention.dart';
import 'package:covid19/src/theme/light_color.dart';
import 'package:covid19/src/theme/text_styles.dart';
import 'package:covid19/src/theme/theme.dart';
// import 'package:covid19/src/services/auth.dart';
import 'package:covid19/src/services/location.dart';
import 'package:covid19/src/services/permission.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DoctorModel> doctorDataList;
  // final AuthService _auth = AuthService();
  final LocationService _locationService = LocationService();
  final PermissionService _permissionService = PermissionService();
  final bool loading = false;  

  @override
  void initState() { 
    doctorDataList = doctorMapList.map((x)=> DoctorModel.fromJson(x)).toList();
    super.initState();
  }
  Widget _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      leading: Icon(
        Icons.short_text,
        size: 30,
        color: Colors.black,
      ),
      actions: <Widget>[
        Icon(
          Icons.notifications_none,
          size: 30,
          color: LightColor.grey,
        ).p(8),
      ],
    );
  }

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Olá,", style: TextStyles.title.subTitleColor),
        Text("Rafael Mateus", style: TextStyles.h1Style),
      ],
    ).p16;
  }

  Widget _situation() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 1, right: 16, left: 16, bottom: 0),
          child: Row(
            children: <Widget>[
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: LightColor.lightGreen),
              ),
              Text("Sem sintomas", style: TextStyles.titleNormal.subTitleColor).p(8),
              Spacer(),
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: LightColor.lightGreen),
              ).p(8),
              Text("Quarentena voluntária", style: TextStyles.titleNormal.subTitleColor),
            ],
          ),
        ),
      ]
    );
  }

  Widget _searchField() {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(13)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: LightColor.grey.withOpacity(.3),
            blurRadius: 15,
            offset: Offset(5, 5),
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
          hintText: "Como você se sente hoje?",
          hintStyle: TextStyles.body.subTitleColor,
          suffixIcon: SizedBox(
            width: 50,
            child: Icon(Icons.mic, color: LightColor.purple)
              .alignCenter
              .ripple(() {}, borderRadius: BorderRadius.circular(13))),
        ),
      ),
    );
  }

  Widget _category() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Situação atual na sua cidade", style: TextStyles.title.bold),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.person_pin_circle,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ).p(2),
                  Text("500973", style: TextStyles.title.bold),
                ],
              )
            ],
          ),
        ),
        Text("Florianópolis - Santa Catarina", style: TextStyles.title.subTitleColor.bold),
        SizedBox(
          height: AppTheme.fullHeight(context) * .24,
          width: AppTheme.fullWidth(context),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _categoryCard("1250 casos", "desde janeiro",
                  color: LightColor.green, lightColor: LightColor.lightGreen),
              _categoryCard("42 casos", "últimos dias",
                  color: LightColor.skyBlue, lightColor: LightColor.lightBlue),
              _categoryCard("13 óbitos", "desde janeiro",
                  color: LightColor.orange, lightColor: LightColor.lightOrange)
            ],
          ),
        ),
      ],
    );
  }

  Widget _categoryCard(String title, String subtitle,{Color color, Color lightColor}) {
     TextStyle titleStyle = TextStyles.title.bold.white;
     TextStyle subtitleStyle = TextStyles.body.bold.white;
     if(AppTheme.fullWidth(context) < 392){
       titleStyle = TextStyles.body.bold.white;
       subtitleStyle = TextStyles.bodySm.bold.white;
     }
    return AspectRatio(
      aspectRatio: 6 / 8,
      child: Container(
        height: 280,
        width: AppTheme.fullWidth(context) * .3,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 50, top: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: lightColor.withOpacity(.8),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -20,
                  left: -20,
                  child: CircleAvatar(
                    backgroundColor: lightColor,
                    radius: 60,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        title,
                        style: titleStyle
                      ).hP8,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Text(
                        subtitle,
                        style: subtitleStyle,
                      ).hP8,
                    ),
                  ],
                ).p16
              ],
            ),
          ),
        ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }

  Widget _doctorsList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Estatísticas", style: TextStyles.title.bold),
              IconButton(
                icon: Icon(
                  Icons.sort,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {}
              ),
            ],
          ).hP16,
          getdoctorWidgetList()
        ],
      ),
    );
  }

  Widget getdoctorWidgetList(){
     return Column(
       children: doctorDataList.map((x){
            return  _doctorTile(x);
          }).toList()
     );
  }

  Widget _doctorTile(DoctorModel model) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 10,
            color: LightColor.grey.withOpacity(.2),
          ),
          BoxShadow(
            offset: Offset(-3, 0),
            blurRadius: 15,
            color: LightColor.grey.withOpacity(.1),
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: randomColor(),
              ),
              child: Image.asset(
                model.image,
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Text(model.name, style: TextStyles.title.bold),
          subtitle: Text(
           model.type,
            style: TextStyles.bodySm.subTitleColor.bold,
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ).ripple(() {
        Navigator.pushNamed(context, "/DetailPage", arguments: model);
      }, borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }

  Color randomColor() {
    var random = Random();
    final colorList = [
      Theme.of(context).primaryColor,
      LightColor.orange,
      LightColor.green,
      LightColor.grey,
      LightColor.lightOrange,
      LightColor.skyBlue,
      LightColor.titleTextColor,
      Colors.red,
      Colors.brown,
      LightColor.purpleExtraLight,
      LightColor.skyBlue,
    ];
    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    startLocationTracking(user);
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _header(),
                _situation(),
                _searchField(),
                _category(),
                chart(),
              ],
            ),
          ),
          _doctorsList(),
        ],
      ),
    );
  }

  Widget chart(){
  return 
      Container(
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(), // Initialize category axis.
          series: <LineSeries<SalesData, String>>[ // Initialize line series.
            LineSeries<SalesData, String>(
              dataSource: [
                SalesData('Jan', 35),
                SalesData('Feb', 28),
                SalesData('Mar', 34),
                SalesData('Apr', 32),
                SalesData('May', 40)
              ],
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales
            )
          ]
        )
  );
}

  Future<void> startLocationTracking(User user) async {
    if (await _permissionService.checkPermission()) {
      _locationService.startService(user);
    }
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}