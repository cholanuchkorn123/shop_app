abstract class BaseUseCase<Input, R> {
  Future<R> build(Input input);
}
