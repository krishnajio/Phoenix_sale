import 'package:flutter/material.dart';
import 'package:phoenix_sale/screen/splashscreenforapp.dart';
import './screen/menu_screen.dart';
import './screen/List_tr_data.dart';
import './screen/Pdf_tr.dart';
import 'package:firebase_core/firebase_core.dart';
import './screen/daily_expenses_screen.dart';
import './screen/menu_sales_screen.dart';
import './screen/login_screen.dart';
import 'screen/tr_entry_screen.dart';
import './screen/supply_entry_screen.dart';
import './screen/List_dm_data.dart';
//import './screen/imgae_upload_screen.dart';
import './screen/trip_screen.dart';
import './screen/chicks_deamand_screen.dart';
import './screen/daily_expenses_screen.dart';
import './screen/List_demand_data.dart';
import './screen/List_expense_data.dart';
import './screen/List_tr_customer.dart';
import './screen/List_dm_customer.dart';
import './screen/Pdf_dm.dart';
import './screen/splashscreenforapp.dart';
import './screen/menu_sales_screen.dart';
import './screen/new_customer_add.dart';
import './screen/List_new_farmer.dart';

 Future<void> main() async {
   //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Phoenix Sales',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'NamBold',
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.black
          )
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreenForApp(),
      routes: {
        SalesMenuGrid.id : (context)=>SalesMenuGrid(),
        ListTrData.id :(context)=>ListTrData(),
        PdfTr.id : (context)=>PdfTr(),
        TrEntryScreen.id : (context)=>TrEntryScreen(),
        SupplyEntryScreen.id : (context)=>SupplyEntryScreen(),
        ListDmData.id : (context)=>ListDmData(),
        ChicksDemandScreen.id :(context)=>ChicksDemandScreen(),
        DailyExpensesScreen.id : (context)=>DailyExpensesScreen(),
        ListDemadData.id :(context)=>ListDemadData(),
        ListExpenseData.id : (context)=>ListExpenseData(),
        ListTrCustomer.id :(context)=>ListTrCustomer(),
        ListDmCustomer.id :(context)=>ListDmCustomer(),
        PdfDm.id :(context)=>PdfDm(),
        TripScreen.id : (context)=>TripScreen(),
        NewCustomeradd.id: (context)=>NewCustomeradd(),
        ListNewCustomer.id : (context)=>ListNewCustomer(),
        //ImageUploadScreen.id : (context)=>ImageUploadScreen(),
        //
      },
    );
  }
}
