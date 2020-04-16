import 'package:barber_roque/auth_firebase.dart';
import 'package:barber_roque/auth_provider.dart';
import 'package:barber_roque/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuth extends Mock implements BaseAuth{}

void main(){
  Widget makeTestableWidget({Widget child, BaseAuth auth}){
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('email or password empty, does not sign in', (WidgetTester tester) async{

    MockAuth mockAuth = MockAuth();

    LoginPage page = LoginPage();

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    await tester.tap(find.byKey(Key('signIn')));

    verifyNever(mockAuth.signInWithEmailAndPassword('', ''));
  });


  testWidgets('non-empty email and password, valid account, call sign in, succeed', (WidgetTester tester) async {

    MockAuth mockAuth = MockAuth();
    when(mockAuth.signInWithEmailAndPassword('email', 'password')).thenAnswer((invocation) => Future.value('uid'));

    LoginPage page = LoginPage();

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));
    
    Finder emailField = find.byKey(Key('email'));
    await tester.enterText(emailField, 'email');

    Finder passwordField = find.byKey(Key('password'));
    await tester.enterText(passwordField, 'password');

    await tester.tap(find.byKey(Key('signIn')));

    verify(mockAuth.signInWithEmailAndPassword('email', 'password')).called(1);
    
  });

  testWidgets('non-empty email and a password, valid account, call sign in, fails', (WidgetTester tester) async{
    MockAuth mockAuth = MockAuth();
    when(mockAuth.signInWithEmailAndPassword('email', 'password')).thenThrow(StateError('invalid credentials'));

    LoginPage page = LoginPage();

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

    Finder emailField = find.byKey(Key('email'));
    await tester.enterText(emailField, 'email');

    Finder passwordField = find.byKey(Key('password'));
    await tester.enterText(passwordField, 'password');

    await tester.tap(find.byKey(Key('signIn')));

    verify(mockAuth.signInWithEmailAndPassword('email', 'password')).called(1);
  });
}

