<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Number Formatter (number_formatter) — agent index

A single **field-display formatter** that renders `integer` / `decimal` / `float` field values
through PHP's intl `NumberFormatter`. Version **2.1.0**. Core `^8 || ^9 || ^10 || ^11 || ^12`,
PHP `>=7.4`, requires the **`intl`** PHP extension (`ext-intl`). Depends on core **`field`**.

**No entities, no routes, no permissions, no services, no hooks besides `hook_requirements()`.**

- **The formatter — plugin, every setting, styles, render output, how to enable it** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is (from source)

- One plugin: `NumberFormatter` (id **`number_formatter`**, label *"Number Formatter"*) in
  `src/Plugin/Field/FieldFormatter/NumberFormatter.php`, extending core `FormatterBase` and
  implementing `ContainerFactoryPluginInterface` (injects `language_manager`).
  `field_types = { "decimal", "float", "integer" }`.
- `number_formatter.install` provides only `hook_requirements()` — flags `REQUIREMENT_ERROR` on the
  status report if `extension_loaded('intl')` is false.
- Config schema for the **formatter settings** only:
  `config/schema/number_formatter.schema.yml` →
  `field.formatter.settings.number_formatter` (`style`, `currency`, `lang_select`).

## Settings (`defaultSettings()`)

- `style` — one of eight intl `NumberFormatter` constants (PATTERN_DECIMAL, DECIMAL *(default)*,
  CURRENCY, PERCENT, SCIENTIFIC, SPELLOUT, ORDINAL, DURATION).
- `currency` — 3-letter ISO 4217 code, used only when style = CURRENCY (default `''`).
- `lang_select` — `current` *(default)* or `field`; shown only on multilingual sites.

## Correctness caveats (verify against the release before relying on them)

- **`info.yml` declares `config: entity.number_format.collection`, but this module defines no such
  entity or route.** That "Configure" link/route does not exist here — there is **no admin
  settings page**; all configuration is per field-display on *Manage display*. Earlier stub docs
  wrongly described reusable `number_format` config entities; ignore that — none exist in source.
- In `viewElements()` the language `switch` is on `$this->settings['style']` (a numeric constant),
  not on `lang_select`, so it never matches `'field'`/`'current'` and always falls through to the
  **current language**. The `lang_select` setting is effectively inert. See fields/formatter.md.
- `test_dependencies: token` is test-only; not a runtime feature.
