<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# String Overrides — how the translation override works

## The translator service

`stringoverrides.services.yml` registers:

```yaml
services:
  string_translator.stringoverrides:
    class: Drupal\stringoverrides\StringOverridesTranslation
    tags:
      - { name: string_translator, priority: 15 }
```

`StringOverridesTranslation extends \Drupal\Core\StringTranslation\Translator\StaticTranslation`.
It is added to the chain of translators consulted by the string translation service, so
**every `t()` / `TranslatableMarkup` lookup passes through it**. The `priority: 15` places it
ahead of the default translators, so a matching override wins over the untranslated source.

## Lookup logic

`getLanguage($langcode)` builds the translation map for a language:

1. Cache id `stringoverides:translation_for_<langcode>` (note: the module spells it
   "overides" with one r) — returned directly on a cache hit.
2. On a miss it reads config `stringoverrides.string_override.<langcode>`, walks its
   `contexts`, and builds `$translations[$context][$source] = $translation`.
3. The result is cached and returned.

Matching is **exact** on the source string within a context. Most overrides use the empty
context `''`; supply a context only to target a string that core translates with one (the
second argument to `t()` `['context' => '...']`).

## Consequences for agents

- Overrides apply to **interface strings routed through the translation system** — labels,
  buttons, messages built with `t()`. They do not rewrite raw HTML, field values, or content.
- After writing `stringoverrides.string_override.<langcode>` config directly, delete the
  cache id `stringoverides:translation_for_<langcode>` (or run `drush cr`) so the new map is
  rebuilt; the admin form does this for you on save.
- Enabled overrides are in `stringoverrides.string_override.<langcode>`; disabled ones are
  parked in `..._disabled` and are **not** consulted by the translator.
- No plugin types, hooks, or Drush commands are provided — the whole surface is the one
  service plus the per-language config object.
