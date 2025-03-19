// # Custom exceptions/failures

abstract class AppError implements Exception {
  final String message;
  const AppError(this.message);
}

class NetworkError extends AppError {
  const NetworkError() : super('Network error occurred');
}

class StorageError extends AppError {
  const StorageError() : super('Failed to save data');
}