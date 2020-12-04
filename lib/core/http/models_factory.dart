class ModelsFactory {
  // Singleton handling.
  static ModelsFactory _instance;

  static ModelsFactory getInstance() {
    if (_instance != null) return _instance;
    _instance = ModelsFactory();
    return _instance;
  }

  // Mapping each model name with the actual value using fromJson factory method.
  Map<String, dynamic Function(Map<String, dynamic>)> _modelsMap = {};

  // Register the model in the map.
  void registerModel(
    String modelName,
    dynamic Function(Map<String, dynamic>) modelCreator,
  ) {
    _modelsMap.putIfAbsent(modelName, () => modelCreator);
    print("modelCreator isssssssssssssssssssssssss ${_modelsMap.toString()}");

  }

  // Generate the desired T model.
  T createModel<T>(json) {
    final modelName = T.toString();
    print("modelName isSSSSSSSSSSSSSSSSSS $modelName");
    print("_modelsMap.containsKey(modelName) isSSSSSSSSSSSSSSSSSS ${_modelsMap.containsKey(modelName)}");
    print("modelCreator isssssssssssssssssssssssss ${_modelsMap.toString()}");
    assert(_modelsMap.containsKey(modelName));
    final model = _modelsMap[modelName](json) as T;
    return model;
  }

  // Generate list of T model.
  List<T> createModelsList<T>(json) {
    return (json as List)
        .map((m) => m == null ? null : createModel<T>(m))
        .toList();
  }
}
