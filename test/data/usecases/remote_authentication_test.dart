import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:fordev/domain/usecases/usecases.dart';

import 'package:fordev/data/usecases/usecases.dart';
import 'package:fordev/data/http/http.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  late RemoteAuthentication sut;
  late HttpClientSpy httpClient;
  late String url;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });

  test('Should call HttpClient with correct values', () async {
    final params = AuthenticationParams(
      email: faker.internet.email(),
      secret: faker.internet.password(),
    );

    await sut.auth(params);

    verify(httpClient.request(
      url: url,
      method: 'post',
      body: {
        'email': params.email,
        'password': params.secret,
      },
    ));
  });
}
