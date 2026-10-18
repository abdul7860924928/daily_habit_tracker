abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'A server error occurred. Please try again.']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'A cache error occurred.']);
}

class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Validation failed. Please check your inputs.']);
}
