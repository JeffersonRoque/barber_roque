import 'package:barber_roque/login_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){  
  
  test('empty email returns erro string', () {

    var result = EmailFielValidadator.validade('');
    expect(result, 'e-mail obrigatório !');
  });

  test('no-empty email return null', (){
    var result = EmailFielValidadator.validade('_email');
    expect(result, null);
  });
  
  test('empty Password returns erro string', () {

    var result = PasswordFielValidador.validade('');
    expect(result, 'senha obrigatória !');
  });

  test('no-empty Password return null', (){
    var result = PasswordFielValidador.validade('_password');
    expect(result, null);
  });

}