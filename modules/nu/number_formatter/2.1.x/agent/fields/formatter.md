<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Number Formatter" field formatter

Everything the module does lives in one class:
`src/Plugin/Field/FieldFormatter/NumberFormatter.php`.

## Install & enable

```bash
composer require drupal/number_formatter
drush en number_formatter -y
```

Requires the **`intl`** PHP extension (`ext-intl`, composer `require`). If it is missing,
`number_formatter_requirements()` (in `number_formatter.install`) reports
`REQUIREMENT_ERROR` on `/admin/reports/status`. Only Drupal dependency is core **`field`**.
There is **no admin settings page** (despite `info.yml`'s `config:` line — see the caveat at the
bottom).

## Enable it on a field

Plugin id **`number_formatter`**, label **"Number Formatter"**,
`field_types = { "decimal", "float", "integer" }` — i.e. core Number (integer / decimal / float)
fields only.

UI: *Structure → (bundle) → Manage display* → set the number field's format to **Number
Formatter** → click the gear to choose the options below.

Config equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_amount.type number_formatter -y
drush cr
```

## Settings

`defaultSettings()` returns three keys (plus the parent's `label`):

| Key | Default | Meaning |
|---|---|---|
| `style` | `(string) \NumberFormatter::DECIMAL` (`"1"`) | Which intl NumberFormatter style to apply. |
| `currency` | `''` | 3-letter ISO 4217 code; used **only** when `style` is Currency. |
| `lang_select` | `'current'` | `field` = field language, `current` = current UI language. Shown only when `languageManager->isMultilingual()`. |

Schema: `config/schema/number_formatter.schema.yml` →
`field.formatter.settings.number_formatter` (`style` int, `currency` string, `lang_select`
string).

### Style options (`styleOptions()`)

Keyed by the intl `\NumberFormatter` class constants:

| Option label | Constant |
|---|---|
| Pattern Decimal | `PATTERN_DECIMAL` |
| Decimal Format *(default)* | `DECIMAL` |
| Currency | `CURRENCY` |
| Percent | `PERCENT` |
| Scientific | `SCIENTIFIC` |
| Spell out | `SPELLOUT` |
| Ordinal | `ORDINAL` |
| Duration | `DURATION` |

### Settings form (`settingsForm()`)

- `style` is a `select`. It has an **AJAX** callback (`ajaxCallback()`) that re-renders the
  `currency` element so the currency textfield appears/disappears when Currency is (de)selected.
  The AJAX wrapper id is a copy-paste leftover: `private_message_thread_member_formatter_settings_wrapper`
  (cosmetic only).
- `currency` becomes a `textfield` (`#size` 8, `#maxlength` 3) with a link to the ISO 4217 page,
  **only** when the chosen style is Currency (`isCurrencyStyle()`); otherwise it renders as empty
  markup just to keep the AJAX wrapper present.
- `lang_select` (`radios`: Field language / Current language) is added **only on multilingual
  sites**.

`settingsSummary()` shows `Style: …`, plus `Currency: …` when applicable, plus `Language: …` on
multilingual sites.

## Render output (`viewElements()`)

1. Picks `$language` (see the bug note below), then builds
   `new \NumberFormatter($language, $this->settings['style'])`.
2. For each field item:
   - **Currency style** → `#markup => $numberFormatter->formatCurrency($item->value, $currency)`.
   - **Any other style** → reads the number field's own `prefix` / `suffix` field settings
     (`getFieldSettings()`), splits each on `|` and maps every part through
     `Drupal\Core\Field\FieldFilteredMarkup::create` (core's allowed-tags/XSS filter). With two
     parts, `formatPlural($item->value, …)` picks singular/plural. Output is
     `#markup => $prefix . $numberFormatter->format($item->value) . $suffix`.

The formatted number itself comes straight out of intl `NumberFormatter` (a numeric string), and
the prefix/suffix are admin-defined field settings passed through `FieldFilteredMarkup`, so the
markup is composed of filtered/safe pieces.

## Bugs / caveats (grounded in source)

- **`lang_select` is inert.** `viewElements()` does `switch ($this->settings['style'])` and
  compares against `LANGUAGE_SELECT_FIELD`/`LANGUAGE_SELECT_CURRENT` (`'field'`/`'current'`).
  `style` is a numeric constant, so no case matches and it always falls to `default` → current
  language. The intended check is on `lang_select`. Net effect: formatting always uses the current
  language regardless of the setting.
- **No `entity.number_format` anything.** `info.yml` declares
  `config: entity.number_format.collection` and `dependencies: field`, but the module ships **no**
  entity type, routing, or config/install — that "Configure" route does not resolve. There are no
  reusable format config entities; each display carries its own `style`/`currency`/`lang_select`.
- Styles like SPELLOUT/ORDINAL/DURATION use ICU rule-based formatting; output depends on ICU data
  for the resolved language.
