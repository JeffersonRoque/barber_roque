import 'package:barber_roque/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main(){
  Widget makeTestableWidget({Widget child}){
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('loginPage_teste', (WidgetTester tester) async{
    LoginPage page = LoginPage(onSignedIn: () {});

    await tester.pumpWidget(makeTestableWidget(child: page));
  });
}

