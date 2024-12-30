class ResponseModel {
  final bool success;
  final String message;
  final String error;

  ResponseModel({required this.success, this.message = '', this.error = ''});
}
