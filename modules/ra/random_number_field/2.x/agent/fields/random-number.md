<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Random Number (integer) field type

## Install & enable

```bash
composer require drupal/random_number_field
drush en random_number_field -y
```

No dependencies beyond core. No permissions, Drush commands, routes, services or config schema of
its own. Everything lives in three plugins under `src/Plugin/Field/`.

## The three plugins

| Kind | Class / file | Plugin id | Extends |
|---|---|---|---|
| Field type | `RandomIntegerItem` (`FieldType/RandomIntegerItem.php`) | `random_integer` | core `IntegerItem` |
| Widget | `RandomNumberWidget` (`FieldWidget/RandomNumberWidget.php`) | `random_number` | core `NumberWidget` (empty subclass) |
| Formatter | `RandomIntegerFormatter` (`FieldFormatter/RandomIntegerFormatter.php`) | `random_number_integer` | core `IntegerFormatter` (empty subclass) |

The type declares `default_widget = "random_number"` and
`default_formatter = "random_number_integer"`, label *"Random Number (integer)"*, category
*Number*. The widget and formatter add nothing to core behaviour — they exist only to bind the
`random_integer` type to a number-input widget and the standard integer display.

## Field settings (`defaultFieldSettings()`)

Only two, both inherited-style integer bounds:

| Setting | Default | Meaning |
|---|---|---|
| `min` | `1` | Lower bound passed to `mt_rand()`. |
| `max` | `10` | Upper bound passed to `mt_rand()`. |

They are merged with core `IntegerItem::defaultFieldSettings()` (`unsigned`, `size`, etc.), so the
underlying storage/validation is core's integer field. Set `min`/`max` on the field's *settings* tab
when creating the field.

## How the random value is produced

`RandomIntegerItem::applyDefaultValue($notify = TRUE)`:

1. Calls `parent::applyDefaultValue($notify)`.
2. **Route guard:** if the current route name matches
   `/entity.field_config.[a-z\_]+_field_edit_form/` (i.e. you are on the field-settings edit form),
   it `return $this;` **without** generating — so the field-config *default value* is never populated
   with a random number and therefore never persisted as a fixed default.
3. Otherwise it sets the item value to
   `['value' => mt_rand($this->getSetting('min'), $this->getSetting('max'))]` and returns.

Because this runs as the field's *default value*, generation happens **once, when a new entity is
created**. After the entity is saved the number is an ordinary stored integer: editable in the form,
returned unchanged on later loads, and re-saved as-is.

## Add the field via UI

1. *Structure → Content types → (bundle) → Manage fields → Add field*.
2. Choose field type **Random Number (integer)** (grouped under *Number*).
3. On the field **settings** tab set `min` and `max`.
4. **Leave the "Default value" empty** (README known issue): saving a value there stores a fixed
   default and disables the random behaviour. The route guard above prevents the form itself from
   auto-filling it, but do not type one in.
5. Save. New entities of the bundle now get a random integer in `[min, max]`.

## Display

The formatter is core's integer formatter, so *Manage display* offers the usual options
(*Thousand marker*, *Prefix and suffix*). Select **Default** (`random_number_integer`). The value is
rendered by core, HTML-escaped like any integer.

## Operating notes / gotchas

- **Generated once.** The value does not re-randomise on edit or view. To re-roll, clear the field
  and let a fresh default apply, or set a new value manually.
- **No uniqueness.** Nothing checks for collisions; a small `[min, max]` range across many entities
  will repeat values. Add your own uniqueness handling if you need distinct IDs.
- **Non-cryptographic.** `mt_rand()` is a general-purpose PRNG. Use for raffle numbers, sampling,
  non-sequential display IDs or test data — not for tokens, secrets or anything guess-sensitive.
- **Views / API.** After creation it is a plain integer column, so it works with Views integer
  handlers, entity queries and the Field API exactly like a core integer field.
- **No config schema.** The module ships no `config/schema/`; the `min`/`max` settings ride on core's
  integer field-type schema, so strict schema tooling should not flag them.
