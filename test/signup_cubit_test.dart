import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecomerce_market/core/errors/failure.dart';
import 'package:ecomerce_market/features/auth/domain/entites/user_entity.dart';
import 'package:ecomerce_market/features/auth/domain/repos/auth_repo.dart';
import 'package:ecomerce_market/features/auth/presentation/views/cubits/cubit/signup_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late SignupCubit signupCubit;
  late MockAuthRepo mockAuthRepo;

  const email = 'test@test.com';
  const password = '123456';
  const name = 'Abdulteef';

  final user = UserEntity(name: name, email: email, uId: '123');

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    signupCubit = SignupCubit(mockAuthRepo);
  });

  tearDown(() async {
    await signupCubit.close();
  });

  group('SignupCubit', () {
    blocTest<SignupCubit, SignupState>(
      'emits [SignupLoading, SignupSuccess] when signup succeeds',
      build: () {
        when(
          () => mockAuthRepo.createUserWithEmailAndPassword(
            email: email,
            password: password,
            name: name,
          ),
        ).thenAnswer((_) async => Right(user));

        return signupCubit;
      },
      act: (cubit) => cubit.createUserWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      ),
      expect: () => [isA<SignupLoading>(), isA<SignupSuccess>()],
      verify: (_) {
        verify(
          () => mockAuthRepo.createUserWithEmailAndPassword(
            email: email,
            password: password,
            name: name,
          ),
        ).called(1);
      },
    );

    blocTest<SignupCubit, SignupState>(
      'emits [SignupLoading, SignupFailure] when signup fails',
      build: () {
        when(
          () => mockAuthRepo.createUserWithEmailAndPassword(
            email: email,
            password: password,
            name: name,
          ),
        ).thenAnswer((_) async => Left(ServerFailure('Signup Failed')));

        return signupCubit;
      },
      act: (cubit) => cubit.createUserWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      ),
      expect: () => [isA<SignupLoading>(), isA<SignupFailure>()],
      verify: (_) {
        verify(
          () => mockAuthRepo.createUserWithEmailAndPassword(
            email: email,
            password: password,
            name: name,
          ),
        ).called(1);
      },
    );
  });
}
