<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rut (rut) — agent index

**Chilean RUT/RUN validation: a `rut_field` form element, a `Drupal\rut\Rut` helper, and a storable field via the `rut_field` submodule.**

- **Version:** 8.x-1.x (release 8.x-1.12)
- **Core:** ^9 || ^10 || ^11
- **Form element:** `#type => 'rut_field'` (`src/Element/RutField.php`), props `#validate_js`, `#bypass_validation`, `#message_js`.
- **Helper:** `Drupal\rut\Rut` — `separateRut`, `calculateDv`, `validateRut`, `formatterRut`, `generateRut`.
- **Submodule `rut_field`:** field type `rut_field_rut` (cols `rut` bigint + `dv` char, combined `value`), widget `rut_field_widget`, default formatter, Feeds target, Views filter, `RutFieldType` + `UniqueRutField` constraints; field setting `bypass_validation`.
- **Also ships:** deprecated Drupal Console `rut:generate` / `rut:validate` commands; jQuery Rut library.
- **Security:** No routes, controllers or permissions — pure field/validation code, no anonymous or mutating endpoints. The uniqueness constraint query uses `accessCheck(FALSE)` intentionally (integrity check, not an access grant).

See [api/rut.md](api/rut.md).
