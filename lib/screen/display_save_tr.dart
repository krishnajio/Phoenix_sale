import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'menu_sales_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_sms/flutter_sms.dart';
//import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import '../constant/constants.dart';
import '../models/customer.dart';
import '../network/network.dart';
import '../widgets/rounded_button.dart';
import '../screen/menu_screen.dart';
//import 'package:toast/toast.dart';
import 'package:telephony/telephony.dart';

class DisplayAndSaveTR extends StatefulWidget {
  @override
  _DisplayAndSaveTRState createState() => _DisplayAndSaveTRState();
}

class _DisplayAndSaveTRState extends State<DisplayAndSaveTR> {
  final GlobalKey<ScaffoldState> ScafoldKey = new GlobalKey<ScaffoldState>();
  final telephony = Telephony.instance;
  List<String> bankdet = [];
  String? bd1, bd2 = '';
  String? _MobileNumber = '';
  String? _CCode = '';
  String? _CName = '';
  String? _TRNumber = '';
  String? _Trdate = 'TR/0000000/';
  String? _Tramount = '';
  String? _paymode = '';
  String? _DdNo = '';

  String? _bankdet = '';
  String? _paytype = '';
  String? _hdate = '';
  String? _ctype = '';
  String? _remarks = '';
  String? _rate = '';
  String? _bankdate = '';
  String? _smsTrNumber = '';
  List<String> _trsplit = [];

  DateTime selectedDate = DateTime.now();
  DateTime selectedHatchDate = DateTime.now();
  DateTime bankdepositselectedDate = DateTime.now();
  String? _value = 'CHEQUE';
  String? _myValuebank = "";
  String? _myValuePaymentType = "Current-Payment";
  String? _valueChicksType = "Broiler";
  double fontSize = 18;
  double height = 15;
  bool _isSaved = false;

  void fetchTRNumber() async {
    try {
      Uri url = Uri.parse('$Url/GetTRNumber?AreaCode=$AreaCode');
      NetworkHelper networkHelper = NetworkHelper(url);
      var data = await networkHelper.getData();
      // print(data);
      setState(() {
        if (data['TrNo'].length > 0) {
          _TRNumber = data['TrNo'][0]['trno'];
          _trsplit = data['TrNo'][0]['trno'].toString().split('/');
          _smsTrNumber = 'TR/${_trsplit[1]}/${_trsplit[2]}/${_trsplit[4]}';
          print('trno' + _TRNumber!);
        } else {
          _TRNumber = '-';
        }
      });
    } catch (e) {
      print(e);
      setState(() {
        _TRNumber = '-';
      });
    }
  }

  void getTRData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bankdet = prefs.getString('bank_det').toString().split('#');
    bd1 = bankdet[0];
    bd2 = bankdet[1];
    setState(() {
      _CCode = prefs.getString('customerCode');
      _CName = prefs.getString('customerName');
      _MobileNumber = prefs.getString('mobile');
      _TRNumber = prefs.getString('trno');
      _Trdate = prefs.getString('trdate');
      _Tramount = prefs.getString('tramount');
      _paymode = prefs.getString('paymode');
      _DdNo = prefs.getString('ddno');
      _bankdet = prefs.getString('bank_det');
      _paytype = prefs.getString('pay_type');
      _hdate = prefs.getString('hatch_date');
      _ctype = prefs.getString('chicks_type');
      _remarks = prefs.getString('remark');
      _rate = prefs.getString('rate');
      _bankdate = prefs.getString('bankdate');
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    getTRData();
    // fetchTRNumber();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ScafoldKey,
      appBar: AppBar(
        title: Text("SAVE TR"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(height),
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
                _TRNumber!,
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "TR Date :$_Trdate",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "TR Amount :$_Tramount",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              Row(
                children: [
                  Text(
                    _paymode!,
                    style: TextStyle(fontSize: fontSize),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    _DdNo!,
                    style: TextStyle(fontSize: fontSize),
                  )
                ],
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "$_bankdet",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              SizedBox(
                height: height,
              ),
              Text(
                _paytype!,
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "Bank deposit date:" + _bankdate!,
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "Hatch Date:" + _hdate!,
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              SizedBox(
                height: height,
              ),
              Text(
                _ctype!,
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "Chicks Rate:$_rate",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              SizedBox(
                height: height,
              ),
              Text(
                _remarks!,
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    fetchTRNumber();
                  },
                  child: Text('test')),
              if (_isSaved)
                Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              else
                RoundedButton(
                    title: 'Save TR',
                    colour: Colors.lightBlueAccent,
                    onPressed: () async {
                      setState(() {
                        _isSaved = true;
                      });

                      var connectivityResult =
                          await Connectivity().checkConnectivity();
                      if (connectivityResult != ConnectivityResult.mobile &&
                          connectivityResult != ConnectivityResult.wifi) {
                        Fluttertoast.showToast(
                            msg: "TNo internet connectivity",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER);
                        return;
                      }
                      fetchTRNumber();
                      try {
                        _trsplit = _TRNumber.toString().split('/');
                        _smsTrNumber =
                        'TR/${_trsplit[1]}/${_trsplit[2]}/${_trsplit[4]}';
                        Uri url = Uri.parse(
                            '$Url/InsertTrData?AreaCode=$AreaCode&Area=$AreaName&TRNo=$_TRNumber&' +
                                "TrDate=$_Trdate&HatchDate=$_hdate&uname=$UserName&Code=$_CCode&CName=$_CName&" +
                                "Pay_mode=$_paymode&DD_No=$_DdNo&Bank_det=$bd1+$bd2&Pay_type=$_paytype&Chick_type=$_ctype&" +
                                "CihckRate=$_rate&Remarks=$_remarks&TrAmount=$_Tramount&bankdate=$_bankdate");
                        print(url);
                        //20-12-23
                        NetworkHelper networkHelper = NetworkHelper(url);
                        var data = await networkHelper.getData();
                        print(data);
                      } catch (e) {
                        print("Errdatasave $e");
                      }
                      // showToast("Show Long Toast", duration: Toast.LENGTH_LONG);

                      // Navigator.pop(context);
                      print('TRNUMber');
                      print(_smsTrNumber);
                      try {

                        print('sms-trno' + _smsTrNumber!);
                        String _msg =
                            "Received with $_paymode on ${_bankdate} Rs:${_Tramount!} @ ${_rate!} From $_CName For $_ctype Chicks By $_smsTrNumber";
                        print(_msg);
                        List<String> recipents = [_MobileNumber!];
                        await telephony.sendSms(
                          to: "+91$_MobileNumber",
                          message: _msg,
                          statusListener: (s) => print(s.name),
                        );
                        //String _r =  await sendSMS(message: _msg, recipients: recipents);
                        print(_msg);
                        // FlutterOpenWhatsapp.sendSingleMessage(
                        // "91$_MobileNumber", _msg);
                      } catch (e) {
                        print("Errsendsms");
                        print(e);
                      }

                      Fluttertoast.showToast(
                          msg: "TR Data Saved...",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER);
                      setState(() {
                        _isSaved = false;
                      });
                      // Navigator.pushAndRemoveUntil(
                      // context,
                      //MaterialPageRoute(
                      //  builder: (context) => SalesMenuGrid()), );
                      Navigator.pushNamedAndRemoveUntil(
                          context, SalesMenuGrid.id, (route) => false);

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.clear();
                    }),
              SizedBox(
                height: 3,
              ),
              _isSaved
                  ? Center(
                      child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ))
                  : RoundedButton(
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
