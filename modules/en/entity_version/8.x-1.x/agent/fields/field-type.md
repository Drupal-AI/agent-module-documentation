<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `entity_version` field type, widget and formatter

## Install & enable

```bash
composer require drupal/entity_version
drush en entity_version -y
```

No non-core dependencies (the field type builds only on core Field API).

## Field type — `EntityVersionItem`

`src/Plugin/Field/FieldType/EntityVersionItem.php`, id **`entity_version`**, default widget
`entity_version`, default formatter `entity_version`.

- **Storage** (`schema()`): three columns — `major`, `minor`, `patch`, each `type => int`,
  `unsigned => TRUE`. So values are non-negative integers only; there is no free-text label column.
- **Properties** (`propertyDefinitions()`): `major`, `minor`, `patch` as `integer` DataDefinitions.
- **Default** (`applyDefaultValue()`): sets `major/minor/patch = 0` → new items are `0.0.0`.
- **Emptiness** (`isEmpty()`): the item is empty if **any** of the three parts is `NULL` or `''`
  (all three must be present for the item to be non-empty).
- **Mutation API** (`EntityVersionItemInterface`):
  - `increase(string $category)` → `set($category, $value + 1)`.
  - `decrease(string $category)` → `set($category, empty($value) ? 0 : $value - 1)` (floored at 0).
  - `reset(string $category)` → `set($category, 0)`.
  `$category` is one of `major` / `minor` / `patch`. These are what `entity_version_workflows` and any
  custom code call to change a number, e.g. `$node->get('field_version')->get(0)->increase('minor')`.

## Widget — `EntityVersionWidget`

`src/Plugin/Field/FieldWidget/EntityVersionWidget.php`, id **`entity_version`**,
`field_types = { entity_version }`.

- `formElement()` builds a `#type => details` titled "Version" containing three `#type => number`
  inputs — **Major**, **Minor**, **Patch** — each `#min => 0`, `#step => 1`, `#size => 5`,
  `#required => FALSE`, pre-filled from `$items[$delta]->major/minor/patch`.
- `massageFormValues()` flattens the nested `version` element back to `major`/`minor`/`patch` keys.

## Formatter — `EntityVersionFormatter`

`src/Plugin/Field/FieldFormatter/EntityVersionFormatter.php`, id **`entity_version`**, label
**"Version"**, `field_types = { entity_version }`.

- **Setting** `minimum_category` (default `patch`); config schema
  `field.formatter.settings.entity_version` (a string). `settingsForm()` offers a select of
  `major` / `minor` / `patch` ("Minimum version").
- `viewValue()` walks categories in order `major → minor → patch`, appending each integer, and
  `implode('.', …)` **stops** once it reaches the configured `minimum_category`. So with
  `minimum_category = major` a `2.1.4` value renders `2`; with `minor` → `2.1`; with `patch` → `2.1.4`.
- Output is a `#markup` string built from the **integer** column values — there is no user-supplied
  free text in the field, so the rendered version is plain digits and dots.

Note: `settingsSummary()` builds a summary line but returns `parent::settingsSummary()` (a known
no-op quirk — the composed `$summary` is not returned); this only affects the Manage-display summary
text, not behaviour.

## Add the field on a bundle

UI: *Structure → (content type) → Manage fields → Add field → "Entity version"*. Set the display
under *Manage display* to **Version** and pick the minimum category via the gear.

Programmatically (see also [../config/settings.md](../config/settings.md)):

```php
\Drupal::service('entity_version.entity_version_installer')
  ->install('node', ['article'], ['major' => 0, 'minor' => 0, 'patch' => 0]);
```

This creates a field storage named **`version`** (`type => entity_version`) if absent and a
per-bundle field config with `cardinality => 1`, `translatable => FALSE`.
