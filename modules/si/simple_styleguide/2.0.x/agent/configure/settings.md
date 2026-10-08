<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings: built-in patterns + colour palette

Configure route `simple_styleguide.styleguide_settings` → `/admin/config/styleguide/settings`
(permission `administer site configuration`). Form `StyleguideSettings` (ConfigFormBase).

**Config object: `simple_styleguide.styleguidesettings`** (one word — this is what the form
reads/writes; the shipped `simple_styleguide.patterns` install file is an unused near-empty stub).

## `default_patterns` — the eleven built-ins

A checkboxes value: a map of pattern key → key-or-0. The eleven selectable keys are:

```
headings, text, lists, blockquote, rule, table, alerts, breadcrumbs, forms, buttons, pagination
```

An enabled pattern stores its key as the value (e.g. `headings: headings`); a disabled one
stores `0`. The controller treats any truthy value as "show this pattern" on `/simple-styleguide`.

## `default_colors` — the colour palette

Stored as an **array of strings**, one per palette colour, each in the pipe format:

```
#hex|class|description        e.g.  #FF0000|red|Primary error colour
```

In the form it is one textarea, newline-separated; on save the module `explode`s on `\r\n` into
the array. The controller splits each line on `|` into `hex`, `class`, `description` and also
derives an `rgb` string from the hex for display.

## Example (drush)

```bash
# Enable headings + buttons, disable the rest:
drush cset simple_styleguide.styleguidesettings default_patterns.headings headings -y
drush cset simple_styleguide.styleguidesettings default_patterns.buttons buttons -y
# Colour palette (array):
drush cset simple_styleguide.styleguidesettings default_colors.0 '#FF0000|red|Error' -y
drush cget simple_styleguide.styleguidesettings
```

Programmatic:

```php
\Drupal::configFactory()->getEditable('simple_styleguide.styleguidesettings')
  ->set('default_patterns', ['headings' => 'headings', 'buttons' => 'buttons'])
  ->set('default_colors', ['#FF0000|red|Error'])
  ->save();
```

Note: `simple_styleguide.styleguidesettings` has **no config schema** (only the
`styleguide_pattern` config entity is schema'd), so `drush cset` may warn about schema; the
values still save and the controller reads them.
