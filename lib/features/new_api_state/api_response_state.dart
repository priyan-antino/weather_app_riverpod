import 'status_enum.dart';

class ApiResponseState<T> {
  Status? status;
  T? data;

  String? message;

  ApiResponseState(this.message, this.data, this.status);
  ApiResponseState.idle() : status = Status.IDLE;
  ApiResponseState.loading() : status = Status.LOADING;
  ApiResponseState.data() : status = Status.DATA;
  ApiResponseState.copmpleted() : status = Status.COMPLETED;
  ApiResponseState.failed() : status = Status.FAILED;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data: $data";
  }
}
