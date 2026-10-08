<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enhanced language switcher — block settings reference

There is **no admin config route**. Configuration lives on the block itself: place the "Enhanced
language switcher" block (Block layout → Place block, or a Context block reaction) and edit its
settings. The core language switcher rows are hidden from those two placement listings by the
module's kernel VIEW subscriber, so you will normally only see the enhanced one.

Config object: `block.block.<id>` → `settings` (schema
`block.settings.language_switcher_enhanced_block:*` in
`config/schema/language_switcher_enhanced.schema.yml`).

## Settings

### display  (string, required)
Label shown for each language link.
- `translated` — translated language name (default). Uses `LanguageManager::getLanguages()`; you
  must translate the language names in config for these to be localized.
- `id` — the langcode (`en`, `nl`, `fr`).
- `native` — native name via `LanguageManager::getNativeLanguages()` (`English`, `Nederlands`).

### structure  (string, required)
HTML structure, selects the `language_switcher__<structure>` template.
- `list` — flat `<ul>` of all languages (`language-switcher--list.html.twig`).
- `nested` — Bootstrap dropdown, active language as the toggle, active language **removed** from the
  menu list (`language-switcher--nested.html.twig`).
- `nested_active` — dropdown, active language as the toggle and **also** repeated in the menu, with
  an `active` class (default; `language-switcher--nested-active.html.twig`).

### use_bootstrap  (boolean, default TRUE)
Attaches the bundled `language_switcher_enhanced/bootstrap` library (trimmed Bootstrap CSS/JS from
`lib/`) so the dropdown functions with no theme CSS. Disable to style/behave from your own theme.
Only meaningful for the `nested` / `nested_active` dropdown structures.

### hidden_languages  (sequence of langcodes)
Languages checked here are **filtered out of the switcher** for any user WITHOUT the
`see hidden languages switcher` permission. Users with the permission see them. This is a
soft/cosmetic hide only — the form explicitly warns it "Will not redirect unauthorized users"; the
translations themselves remain fully accessible by URL. Do not treat it as access control.

### not_translated  (string, required)
What to do when a language has **no translation** of the current entity. The check only runs on
routes named `entity.*.canonical` whose route parameter is a `ContentEntityInterface`; on every
other route the links are left exactly as core built them.
- `default` — leave core's link unchanged (may point at the untranslated original / another
  language).
- `homepage` — repoint the link to that language's front page (`Url('<front>', …, ['language' => …])`).
  Labelled "Redirect to homepage" in the form but it is a **link URL change, not an HTTP redirect**.
- `disabled` — replace the link with `Url('<nolink>')` so it renders as non-clickable text.

Note: `defaultConfiguration()` seeds `not_translated` as boolean `FALSE`; until the block is saved
this behaves like `default` (no rewriting).

## Example: set via drush (illustrative)
Block settings are ordinary block config; edit through the UI, or in exported config:

```yaml
# block.block.<yourblock>.yml (settings excerpt)
settings:
  id: language_switcher_enhanced_block:language_interface
  display: native
  structure: nested_active
  not_translated: disabled
  hidden_languages:
    de: de
  use_bootstrap: false
```
