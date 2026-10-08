<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rut — API & usage

## Form element (src/Element/RutField.php)
```php
$form['rut'] = [
  '#type' => 'rut_field',
  '#title' => t('Rut'),
  '#required' => TRUE,
  '#validate_js' => TRUE,        // optional jQuery client-side validation
  '#message_js' => t('Invalid Rut'),
  '#bypass_validation' => FALSE, // skip server-side check digit validation
];
```
Extends core Textfield; server-side `#element_validate => [RutField::validateRut]` runs `Rut::validateRut()` unless `#bypass_validation` is set. `#validate_js` attaches library `rut/rut.rut` and CSS classes `rut-validate-js` / `rut-bypass-validation`.

## Helper class Drupal\rut\Rut
- `Rut::separateRut('12.345.678-9')` -> `['12345678','9']`.
- `Rut::calculateDv('12345678')` -> `'9'` (mod-11; returns `'k'` for 10, `0` for 11).
- `Rut::validateRut($rut, $dv = NULL)` -> bool (accepts combined string or number+dv).
- `Rut::formatterRut($rut, $dv)` -> `'12.345.678-9'`.
- `Rut::generateRut($formatted = TRUE, $min = 1, $max = 20000000)` -> random valid RUT (uses `rand()`; test/sample data only, not for security).

## rut_field submodule
Field type `rut_field_rut`: stores `rut` (unsigned big int, indexed) + `dv` (char[1]); `value` is the formatted string. Setting `bypass_validation` disables the `RutFieldType` constraint. `UniqueRutField` constraint enforces uniqueness (query with `accessCheck(FALSE)`). Widget `rut_field_widget`, default formatter `rut_field_formatter_default`, Feeds `Target/RutTarget`, Views filter `RutEquality`.
