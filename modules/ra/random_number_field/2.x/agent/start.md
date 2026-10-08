<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Random Number Field (random_number_field) — agent index

A field type that fills an entity with a **random integer** from a configurable min/max range at
creation time. Package `Field`. Core requirement `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.
Version 2.0.0-rc1 (dir `2.x`). **No dependencies** beyond Drupal core, no permissions, no routes,
no services, no hooks/`.module`, no `.install`, no config/schema, no submodules.

- **The field type, widget, formatter, the `min`/`max` settings and how to add/operate it** →
  [fields/random-number.md](fields/random-number.md)

## What it actually is (from source, all under `src/Plugin/Field/`)

- **Field type** `RandomIntegerItem` (id **`random_integer`**, label *"Random Number (integer)"*,
  category *Number*), `FieldType/RandomIntegerItem.php`, extends core
  `IntegerItem`. Adds two field settings via `defaultFieldSettings()`: **`min`** (default `1`),
  **`max`** (default `10`). Its `applyDefaultValue()` sets the value to
  `mt_rand($min, $max)` for a new item, but **returns early without generating** when the current
  route matches `/entity.field_config.[a-z\_]+_field_edit_form/` (the field-settings edit form) so a
  random default is never saved as the field's stored default value.
- **Widget** `RandomNumberWidget` (id **`random_number`**, label *"Number field"*),
  `FieldWidget/RandomNumberWidget.php`, empty subclass of core `NumberWidget`.
- **Formatter** `RandomIntegerFormatter` (id **`random_number_integer`**, label *"Default"*),
  `FieldFormatter/RandomIntegerFormatter.php`, empty subclass of core `IntegerFormatter`.
- `default_widget = "random_number"`, `default_formatter = "random_number_integer"`.

## Key behaviour / caveats

- The random value is generated **once, at entity creation** (via the field default). After that it
  is a normal integer: editable, and unchanged on subsequent loads/saves.
- **No uniqueness enforcement** — two entities can get the same number.
- **README "known issue":** when configuring the field, keep the *default value* on the settings
  form **empty**; if you save a value there it becomes a fixed stored default and the random
  behaviour stops. `applyDefaultValue()`'s route guard exists to avoid this.
- Randomness is ordinary (`mt_rand`), suitable for raffle numbers / sampling / non-sequential IDs /
  test data — not for anything an attacker must not guess.
