<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins & helper API

The module does not define its own plugin *type* (no manager). It supplies concrete Field API and
validation plugins plus a static helper. Use these IDs when configuring displays or building forms.

## Field plugins

- **Field type** `nif_nie_cif` (`FieldNifNieCifItem`) — two columns:
  `type` (char 3, e.g. `NIF`/`NIE`/`CIF`) and `number` (varchar 255, indexed). Both properties are
  required. `isEmpty()` is true when `number` is empty. `default_widget`/`default_formatter` =
  `nif_nie_cif_default`. On `setValue()`/`preSave()` it normalizes the number and, when `type` is
  missing but `number` is set, auto-detects the type via `IdentificationHelper::identify()`.
  `getConstraints()` attaches the `NifNieCif` constraint.
- **Widget** `nif_nie_cif_default` (`FieldNifNieCifWidget`) — see
  [../configure/widget-settings.md](../configure/widget-settings.md). Attaches library
  `field_nif_nie_cif/input_filter`; renders number field with `data-identification-*` attributes.
- **Formatter** `nif_nie_cif_default` (`FieldNifNieCifFormatter`) — renders each item as
  `@type: @number` via `$this->t()` (placeholders are escaped; safe output).
- **Constraint** `NifNieCif` (`NifNieCifConstraint` + `NifNieCifConstraintValidator`) — validates a
  `FieldNifNieCifItem` through Drupal's validation API. Empty number → pass. Missing type, unsupported
  type, or checksum-invalid number each add a violation on the `type` or `number` path. This runs for
  forms, JSON:API and any entity validation, independent of the widget's `#element_validate`.

## `IdentificationHelper` (static, `Drupal\field_nif_nie_cif\Helper\IdentificationHelper`)

- `const SUPPORTED_TYPES = ['NIF','NIE','CIF']` — canonical detection order.
- `normalize(string $number): string` — trims, strips spaces/dots/hyphens (`/[\s.\-]+/u`), uppercases.
- `identify(string $number): ?array` — returns `['type'=>…, 'number'=>…]` for the first supported type
  that validates the normalized number, or `NULL`.
- `validateByType(string $type, string $number): bool` — validates a normalized number against an
  explicit `NIF`/`NIE`/`CIF` type (unknown type → `FALSE`).
- `validateNif` / `validateNie` / `validateCif(string): bool` — per-type checksum validators.
  NIF: 8 digits + control letter (`TRWAGMYFPDXBNJZSQVHLCKE[num % 23]`), or K/L/M special, or a `T…`
  form (accepted as-is). NIE: `[XYZ]` mapped to `0/1/2` then NIF letter check. CIF: 9 chars,
  entity-letter prefix, control digit/letter from a weighted sum.
- `getCifSum(string $cif): int` — control sum for CIF (throws `\InvalidArgumentException` if < 9 chars).

## Webform element (submodule `field_nif_nie_cif_webform`)

- **Element** `nif_nie_cif` (`NifNieCifWebformElement extends TextBase`, base `textfield`) —
  category "Custom elements". `prepare()` forces a textfield with `data-identification-mode=auto`,
  all types allowed, attaches `field_nif_nie_cif/input_filter`, and adds a validate callback.
  `validateElement()` normalizes the value; empty passes; otherwise `identify()` must succeed
  (else "The identification number provided is not valid."), and the canonical number is written back
  via `setValueForElement()`. Requires the `webform` module.
