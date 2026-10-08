<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a Year Only field

The module has **no settings form and no permissions**. You configure it entirely on the
field: a field storage of type `yearonly`, a field instance with range settings, and the
form/view display using the `yearonly_default` widget/formatter.

## Field type / plugin ids

| Piece | id |
|---|---|
| Field type | `yearonly` |
| Default widget | `yearonly_default` (label "Select Year") |
| Default formatter | `yearonly_default` (label "Year only") |
| Storage column | single `value`, `int` (indexed) — one value per item |

Storage has **no** storage-level settings; the range lives in the **field instance** settings.

## Field instance settings (the range)

Both are stored as strings in config (`field.field_settings.yearonly`):

| Key | Meaning | Example values |
|---|---|---|
| `yearonly_from` | Minimum (start) year — must be numeric | `1900`, `530`, `1970` |
| `yearonly_to` | Maximum (end) year — a specific year **or** a PHP relative format | `2030`, `now`, `+5 years`, `-1 year` |

`yearonly_to` is resolved with `strtotime()` when it is not numeric, so `now`, `+5 years`,
`-2 years` all work (it becomes the current year ± N). Validation enforces resolved
`yearonly_from` < resolved `yearonly_to`. Both keys are **required** on the field settings
form.

## Widget setting

`yearonly_default` widget has one setting, `sort_order`:

- `asc` (default) — years ascending in the select list.
- `desc` — years descending (newest first).

The widget renders a `select` whose options are `range(from, to)` (with `now` expanded to
the current year).

## Add a field with Drush (config entities)

```bash
drush php:eval '
  \Drupal\field\Entity\FieldStorageConfig::create([
    "field_name" => "field_founded_year",
    "entity_type" => "node",
    "type" => "yearonly",
  ])->save();
  \Drupal\field\Entity\FieldConfig::create([
    "field_name" => "field_founded_year",
    "entity_type" => "node",
    "bundle" => "article",
    "label" => "Founded year",
    "settings" => ["yearonly_from" => "1900", "yearonly_to" => "now"],
  ])->save();
'
drush cr
```

Set the widget sort order on the form display:

```bash
drush php:eval '
  \Drupal::service("entity_display.repository")
    ->getFormDisplay("node", "article", "default")
    ->setComponent("field_founded_year", [
      "type" => "yearonly_default",
      "settings" => ["sort_order" => "desc"],
    ])->save();
'
```

## Inspect a configured field

```bash
# field settings (the range)
drush php:eval '
  $fc = \Drupal\field\Entity\FieldConfig::loadByName("node","article","field_founded_year");
  print_r($fc->getSettings());
'
# storage type (confirm it is yearonly)
drush php:eval '
  $fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node","field_founded_year");
  print $fs->getType();
'
```
