abstract class Either<T, E> {}

class Success<T, E> extends Either<T, E> {
  final T value;

  Success(this.value);
}

class Failure<T, E> extends Either<T, E> {
  final E error;

  Failure(this.error);
}