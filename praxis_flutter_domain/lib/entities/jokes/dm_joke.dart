import 'package:praxis_flutter_domain/mapper/ui_model_mapper.dart';

class DMJoke extends DomainModel {
  final int id;
  final String joke;

  DMJoke(this.id, this.joke);
}
