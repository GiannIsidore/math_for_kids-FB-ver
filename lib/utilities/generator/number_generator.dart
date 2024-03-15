import 'dart:math';

enum OperationType { Addition, Subtraction, Multiplication, Division }

class NumberGenerator {
  static List<int> generateNumbersForOperation(OperationType operation) {
    final random = Random();
    int num1 = 0;
    int num2 = 0;
    switch (operation) {
      case OperationType.Addition:
        num1 = random.nextInt(10);
        num2 = random.nextInt(10);
        break;
      case OperationType.Subtraction:
        num1 = random.nextInt(10) +
            5; // Ensure num1 is greater than num2 for subtraction
        num2 = random.nextInt(num1);
        break;
      case OperationType.Multiplication:
        num1 = random.nextInt(5) +
            1; // To keep it simple, limit the range for multiplication
        num2 = random.nextInt(5) + 1;
        break;
      case OperationType.Division:
        num2 = random.nextInt(5) +
            1; // To keep it simple, limit the range for division
        num1 = num2 *
            (random.nextInt(5) +
                1); // Ensure num1 is divisible by num2 for division
        break;
    }
    return [num1, num2];
  }
}
