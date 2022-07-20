import 'package:flutter/material.dart';

mixin ValidationMixin {
  final ValueNotifier<bool> isValid = ValueNotifier(false);

  final Set<ValueNotifier<bool>> _validationValues = {};

  List<ValueNotifier<bool>> get validationValues => _validationValues.toList();

  void startValidating(List<ValueNotifier<bool>> validationValues) {
    _validationValues.addAll(validationValues);
    for (var validationValue in validationValues) {
      validationValue.addListener(_validate);
    }
    _validate();
  }

  void addValidationValue(ValueNotifier<bool> value) {
    _validationValues.add(value);
    value.addListener(_validate);
    _validate();
  }

  void removeValidationValue(ValueNotifier<bool> value) {
    _validationValues.remove(value);
    value.removeListener(_validate);
    _validate();
  }

  void stopValidating() {
    for (var validationValue in _validationValues) {
      validationValue.removeListener(_validate);
    }
    isValid.dispose();
  }

  void _validate() {
    bool valid =
        _validationValues.every((validationValue) => validationValue.value);
    if (isValid.value != valid) {
      isValid.value = valid;
    }
  }
}