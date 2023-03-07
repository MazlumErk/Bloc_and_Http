import 'package:bloc/bloc.dart';
import 'dart:math' as math show Random;


extension RandomNameElement<N> on List<N> {
  N getRandomName() => elementAt(math.Random().nextInt(length));
}

class NamesCubit extends Cubit<String?> {
  NamesCubit({required this.nameList}) : super(null);
final List<String> nameList;
  void getRandomName() => emit(nameList.getRandomName());
}