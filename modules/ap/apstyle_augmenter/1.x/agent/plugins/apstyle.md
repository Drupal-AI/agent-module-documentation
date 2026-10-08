<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `apstyle` Date Augmenter plugin

Source: `src/Plugin/DateAugmenter/APStyle.php`. Class `APStyle` extends
`Drupal\date_augmenter\DateAugmenter\DateAugmenterPluginBase`, implements core
`PluginFormInterface`, uses `Drupal\date_augmenter\Plugin\PluginFormTrait`.

Annotation: `@DateAugmenter(id = "apstyle", label = "Associated Press Stylebook",
description = "...", weight = 0)`.

## Install / enable

1. `composer require drupal/apstyle_augmenter` (pulls `drupal/date_augmenter:^1.0`).
2. `drush en apstyle_augmenter -y` (enables `date_augmenter` as a dependency).
3. You also need a **Date Augmenter-compatible formatter**. The README/maintainers recommend
   **Smart Date** (`drupal/smart_date`); its formatter exposes the Date Augmenter third-party
   settings UI where this plugin is toggled.
4. On a date field's **Manage display**, edit the compatible formatter's settings, enable the
   *Associated Press Stylebook* augmenter, and (optionally) tune its three checkboxes.

There is **no** admin route or config form of the module's own — configuration lives entirely in
the host formatter's third-party settings.

## The three rules

All read from `$config = $options['settings'] ?? $this->getConfiguration()`:

- **`meridian`** (default TRUE) — if the time string matches `/[ap]m/i`, `str_ireplace(['am','pm'],
  ['a.m.','p.m.'], …)`. Produces lowercase meridians with periods.
- **`word_replace`** (default TRUE) — replaces bare noon/midnight times with words. It maps
  `noon` ← `12pm|12:00pm|12 pm|12:00 pm` and `midnight` ← the `am` equivalents (string matching,
  not regex, "for performance"). The words come from `$this->t('noon')->render()` /
  `$this->t('midnight')->render()`. Special range handling: when `$part == 'start'` and the start
  string **ends with `12`/`12:00`** (no meridian yet), it reads the meridian from
  `$output['end']…['#markup']` (`am` → midnight, `pm` → noon) and substitutes the bare `12`.
- **`month_expand`** (default TRUE) — for the `date` `#markup`, formats the month as `F` (full) and
  `M` (abbrev). If `Sep` → replaces with `Sept.` (and normalizes `Sept..` → `Sept.`). Else if the
  full month name is **> 5 letters** → uses `Mabbr.` (abbreviated + period, normalizing `..` → `.`).
  Else (≤ 5 letters: March, April, May, June, July) → strips any period and expands to the full
  name. Net effect matches AP: `Jan. Feb. Aug. Sept. Oct. Nov. Dec.` abbreviated, the rest spelled
  out.

Where it reads/writes: it takes a **reference** to the markup string at
`$output[$part]['#text']['time'|'date']['value']['#markup']` (with a fallback path lacking
`#text`), for `$part` in `['start', 'end']`, and mutates it in place. `augmentOutput()` also
re-applies the whole routine to `$output['site_time']` when a site-time variant exists.

## Settings form

`buildConfigurationForm()` delegates to `configurationFields()`, which builds three checkboxes
(`meridian`, `month_expand`, `word_replace`) with `#default_value` from settings or
`defaultConfiguration()`. Note: in the shipped code the `word_replace` checkbox's `#default_value`
is (apparently mistakenly) set from `$settings['month_expand']` rather than
`$settings['word_replace']` — a cosmetic default-value quirk in the form, not the runtime logic,
which reads `$config['word_replace']`.

`defaultConfiguration()` returns `['meridian' => TRUE, 'month_expand' => TRUE, 'word_replace' => TRUE]`.

## Config schema

`config/schema/apstyle_augmenter.schema.yml` extends
`field.formatter.third_party.date_augmenter.settings` with an `apstyle` mapping of three booleans:
`meridian`, `word_replace`, `month_expand`. There is no `config/install/` for the module itself.

## Bundled Smart Date format

`config/optional/smart_date.smart_date_format.ap_stylebook.yml` defines a Smart Date format
`ap_stylebook` (label *"AP Stylebook"*): `date_format: 'M j, Y'`, `time_format: 'g:i a'`,
`time_hour_format: 'g a'`, `ampm_reduce: 1`, `date_first: 1`, `site_time_toggle: 1`, separator
`' - '`, join `', '`. Because it lives in `config/optional/`, it is imported **only if
`smart_date` is enabled**. The README recommends using it with the plugin for best AP-compliant
results.

## Caveats

- Requires a compatible formatter to do anything — enabling the module alone has no visible effect.
- Month handling is English-only (`@todo` comments in source about timezone and other languages).
- Purely a display-time transform: it never changes the stored date value.
