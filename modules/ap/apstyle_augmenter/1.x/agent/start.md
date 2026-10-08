<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Associated Press Stylebook Augmenter (apstyle_augmenter) — agent index

A single **Date Augmenter plugin** that rewrites already-rendered date/time markup to follow
**Associated Press (AP) Stylebook** conventions. Package `Date Augmenter`. Depends on the
contrib **`date_augmenter`** module (`date_augmenter:date_augmenter`, composer `drupal/date_augmenter:^1.0`).
Core requirement `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.x
(installed `1.0.0-beta1`). Not an AI/"augmentor" plugin and makes no external calls.

- **The plugin, its three rules, settings, schema, and the bundled Smart Date format** →
  [plugins/apstyle.md](plugins/apstyle.md)

## What it actually is

- One plugin: `APStyle` (id **`apstyle`**, label *"Associated Press Stylebook"*, weight 0), in
  `src/Plugin/DateAugmenter/APStyle.php`, extending `date_augmenter`'s
  `DateAugmenterPluginBase` and implementing core `PluginFormInterface`.
- It is a **Date Augmenter**, not a field formatter: the `date_augmenter` API invokes
  `augmentOutput()` on the render array a compatible formatter (e.g. **Smart Date**) already
  built, and this plugin does in-place **string replacements** on the `#markup` text.
- **No** routes, permissions, services, hooks, Drush commands, install/update hooks, or its own
  field formatter/widget/field type. Provides config **schema** only (third-party settings on the
  date_augmenter formatter).
- Ships an optional Smart Date format `ap_stylebook` in
  `config/optional/smart_date.smart_date_format.ap_stylebook.yml` (installed only when
  `smart_date` is present).

## Mechanism (from source)

- `augmentOutput(&$output, $start, $end, $options)` calls `applyApStylebook()` on `$output`, and
  again on `$output['site_time']` if present.
- `applyApStylebook()` reads its flags from `$options['settings']` or `getConfiguration()` and
  applies three independent rules to the `time`/`date` `#markup` strings it finds under
  `$output[$part]['#text'][...]['value']['#markup']` (or without `#text`): **`meridian`**
  (`am`/`pm` → `a.m.`/`p.m.`), **`word_replace`** (12:00 → "noon"/"midnight", with range logic
  taking the meridian from the end time when the start is bare `12`), and **`month_expand`**
  (short months → full name; `Sep` → `Sept.`; AP's short months kept without a period).
- Operates only on strings the formatter already produced from the entity's date value — no
  request/config-supplied input, no markup construction. Details in
  [plugins/apstyle.md](plugins/apstyle.md).

## Config

- `defaultConfiguration()`: `meridian`, `month_expand`, `word_replace` all **TRUE** (AP-compliant
  by default; each can be turned off per formatter instance).
- Schema `field.formatter.third_party.date_augmenter.settings` in
  `config/schema/apstyle_augmenter.schema.yml` adds an `apstyle` mapping (the three booleans).
