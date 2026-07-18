import 'package:dartz/dartz.dart';
import 'package:ecomerce_market/core/errors/failure.dart';
import 'package:ecomerce_market/features/auth/domain/entites/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });
}