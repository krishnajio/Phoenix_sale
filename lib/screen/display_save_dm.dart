import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
//import 'package:flutter_sms/flutter_sms.dart';
//import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import '../widgets/rounded_button.dart';
//import 'package:toast/toast.dart';
import '../network/network.dart';
import '../constant/constants.dart';
import '../screen/menu_sales_screen.dart';
import 'package:telephony/telephony.dart';



class SaveSupply extends StatefulWidget {
  static const String id = 'SaveSupply';
  @override
  _SaveSupplyState createState() => _SaveSupplyState();
}

class _SaveSupplyState extends State<SaveSupply> {
  String? bd1, bd2 = '';
  String? _MobileNumber = '';
  String? _CCode = '';
  String? _CName = '';
  String? _dmNumber = '';
  String? _dmDate = 'TR/0000000/';
  String? _totalChicks = '';
  String? _trasnitMortality = '';
  String? _hdate = '';
  String? _ctype = '';
  String? _remarks = '';
  String? _rate = '';
  String? _hatchery = '';
  String? _smsDmNumber='';
  List<String> _dmsplit=[];
  final telephony = Telephony.instance;
  double height = 10;
  double fontSize = 18;
  bool _isSaved = false;

  getSupplyData() async {
    SharedPreferences shpSypply = await SharedPreferences.getInstance();

    setState(() {
      _CName = shpSypply.getString('customerName')!;
      _CCode = shpSypply.getString('customerCode');
      _MobileNumber = shpSypply.getString('mobile');
      _dmNumber = shpSypply.getString('dmno');
      _dmDate = shpSypply.getString('dmdate');
      _totalChicks = shpSypply.getString('totalchicks');
      _trasnitMortality = shpSypply.getString('transit_mortality');
      _hdate = shpSypply.getString('hatch_date');
      _hatchery = shpSypply.getString('hatchery');
      _ctype = shpSypply.getString('chicks_type');
      _rate = shpSypply.getString('rate');
      _remarks = shpSypply.getString('remark');
    });
  }

  void fetchDMNumber() async {
    try {
      Uri url = Uri.parse('$Url/GetDMNumber?AreaCode=$AreaCode');
      NetworkHelper networkHelper = NetworkHelper(url);
      var data = await networkHelper.getData();
      // print(data);
      setState(() {
        if (data['DmNo'].length > 0) {
          _dmNumber = data['DmNo'][0]['DmNo'];
          print('dmno' + _dmNumber!);
        } else {
          _dmNumber = '-';
        }
      });
    } catch (e) {
      print(e);
      setState(() {
        _dmNumber = '-';
      });
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    getSupplyData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Supply'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height,
              ),
              Row(
                children: [
                  Text(
                    _CCode!,
                    style: TextStyle(fontSize: fontSize),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      _CName!,
                      style: TextStyle(fontSize: fontSize),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "Mobile:$_MobileNumber",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "DM:$_dmNumber",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "DM Date:$_dmDate",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "Hatch Date:$_hdate",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "Chick :$_ctype",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "Total Chick :$_totalChicks",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "Transit Mortality:$_trasnitMortality",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "Rate:$_rate",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "$_hatchery",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "$_remarks",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: 20,
              ),
              _isSaved ? Center(child: CircularProgressIndicator(strokeWidth: 2,))  : RoundedButton(
                  title: 'Save Supply',
                  colour: Colors.lightBlueAccent,
                  onPressed: () async {
                    setState(() {
                      _isSaved =true;
                    });
                    var connectivityResult =
                        await Connectivity().checkConnectivity();
                    if (connectivityResult != ConnectivityResult.mobile &&
                        connectivityResult != ConnectivityResult.wifi) {
                      Fluttertoast.showToast(msg : "Please check Network Connectivity", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                      return;
                    }


                    fetchDMNumber();
                    try {
                      Uri url =
                         Uri.parse('$Url/InsertDMData?AreaCode=$AreaCode&Area=$AreaName&DMNo=$_dmNumber&'
                      +
                      "DMDate=$_dmDate&HatchDate=$_hdate&uname=$UserName&Code=$_CCode&CName=$_CName&"
                      +
                      "Chick_type=$_ctype&"
                      +
                      "CihckRate=$_rate&Remarks=$_remarks&TotalChicks=$_totalChicks&Mortality=$_trasnitMortality&Hatchries=$_hatchery");
                      print(url);
                      NetworkHelper networkHelper = NetworkHelper(url);
                      var data = await networkHelper.getData();
                        print(data);
                    } catch (e) {
                      print(e);
                    }
                    // showToast("Show Long Toast", duration: Toast.LENGTH_LONG);
                    Fluttertoast.showToast(msg : "Supply Information Saved...", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);

                    Navigator.of(context).pop();

                    try {
                      _dmsplit = _dmNumber.toString().split('/');
                      _smsDmNumber = 'DM/${_dmsplit[1]}/${_dmsplit[2]}/${_dmsplit[4]}';


                      String _msg =
                          "Supplied $_ctype Chicks Hatch date $_hdate having Qty $_totalChicks and TM $_trasnitMortality @ $_rate to $_CName by $_smsDmNumber"  ;
                      List<String> recipents = [_MobileNumber!];

                      await telephony.sendSms(
                          to: "+91$_MobileNumber",
                          message: _msg,
                          statusListener: (s) => print(s.name));

                    } catch (e) {
                      print(e);
                    }


                   // Navigator.pushAndRemoveUntil(
                     // context,
                      //MaterialPageRoute(builder: (context) => SalesMenuGrid()), );

                    Navigator.pushNamedAndRemoveUntil(
                        context, SalesMenuGrid.id, (route) => false);
                    SharedPreferences shpSypply =
                    await SharedPreferences.getInstance();
                    shpSypply.clear();
                  },),
              SizedBox(
                height: 5,
              ),
              RoundedButton(
                  title: 'Previous...',
                  colour: Colors.lightBlueAccent,
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
