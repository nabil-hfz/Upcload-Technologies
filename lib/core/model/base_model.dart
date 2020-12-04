
import 'package:upcload_technology/core/entity/base_entity.dart';

abstract class BaseModel<T extends BaseEntity> {
  T toEntity();
}
