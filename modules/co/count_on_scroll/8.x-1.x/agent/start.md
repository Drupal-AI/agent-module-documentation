<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Count on Scroll (count_on_scroll) — agent index

Field formatter for **integer** fields that animates the value counting up from zero when the
element scrolls into the viewport (animated-statistics effect). Package *User interface*.
Version **8.x-1.4** (version-dir `8.x-1.x`). Core `^8.8 || ^9 || ^10 || ^11`.

## What it provides

- **Field formatter plugin** `count_on_scroll_formatter` (label "Count on Scroll"), class
  `Drupal\count_on_scroll\Plugin\Field\FieldFormatter\CountOnScrollFormatter`, extends core
  `NumericFormatterBase`. Applies to `field_types = { integer }` only.
- **One setting**: `duration` (ms, default `6000`), configured on the field's Manage display.
- **Asset library** `count_on_scroll/count_on_scroll` (`js/count_on_scroll.js`, depends on
  `core/drupalSettings`; uses the jQuery global).
- **Config schema** `field.formatter.settings.count_on_scroll_formatter` (`config/schema/`).

## What it does NOT provide

No routes, no permissions (`*.permissions.yml` absent), no services, no submodules, no Drush
commands, no `.module`/`.install`, no config/install defaults, no external/composer dependencies.
Pure display: the stored integer is unchanged; no access-control role.

## Solution docs

- [Field formatter & settings](fields/formatter.md) — enable, select on a field, the `duration`
  setting, view-display config, and how the render + JS animation work.
