<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Helpers, cache context, and update-report sort

Code-level utilities for other modules/custom code to call. All are static or service-based; none
have UI.

## ArrayHelper — `Drupal\cm_tools\ArrayHelper`

Static array-manipulation helpers (all modify `$haystack` by reference; note the legacy
`cm_tools_`-prefixed method names):

- `cm_tools_array_rename_key(array &$haystack, $key, $new_key): bool` — rename a key **in place**
  (position preserved). Overwrites `$new_key` if it exists.
- `cm_tools_array_insert_at_key(array &$haystack, $insert_key, $insertions, $insert_before = FALSE, $preserve_keys = TRUE): bool`
  — insert after (or before) a given key. `$insert_key` may be an array of candidate keys; the first
  existing one wins. Strict key comparison.
- `cm_tools_array_insert_at_value(array &$haystack, $insert_value, $insertions, $insert_before = FALSE, $preserve_keys = FALSE): bool`
  — same but locate the anchor by **value** (strict, first occurrence).
- `cm_tools_array_insert_at_offset(array &$haystack, $offset, $insertions, $preserve_keys = FALSE): bool`
  — insert at a numeric offset. If `$insertions` is not an array it is given the next numeric key.
- `cm_tools_array_remove_values(array &$haystack, $values)` — remove element(s) by value (string or
  array of values; loose `array_search`).
- `cm_tools_stable_usort(array &$array, callable $cmp): int` /
  `cm_tools_stable_uasort(array &$array, callable $cmp): int` — like `usort`/`uasort` but **stable**
  (equal elements keep their original order), implemented by tagging each element with its index.

## TranslationHelper — `Drupal\cm_tools\TranslationHelper`

`ensureTranslationsOfSimpleStrings(array $translations, string $context = '')` — programmatically
create/update **locale** (interface) translations for simple source strings. Input shape:

```php
[
  'Translations are fun' => [
    'fr-fr' => 'Les traductions sont amusantes',
    'de-de' => 'Übersetzungen machen Spaß',
  ],
]
```

- Uses the `locale.storage` service. Loads existing source strings + translations, then updates
  existing translations (marked `customized => TRUE`) or creates the source string and/or
  translation as needed.
- **Validates** every target langcode against `\Drupal::languageManager()->getLanguages()` and
  throws `\InvalidArgumentException` for any language not configured on the site.
- Typical caller: an `hook_install`/`hook_update_N` or deploy hook that needs to guarantee specific
  UI-string translations exist. (Requires core `locale` to be enabled for the storage service.)

## `cm-session` cache context

Service `cache_context.cm-session` → `Cache/Context/CmSessionCacheContext` (in
`cm_tools.services.yml`), a `CalculatedCacheContextInterface`.

- `cm-session` (no parameter) → varies on **whether a session exists at all** (`request->hasSession()`).
- `cm-session:<name>` → varies on **whether a specific session key exists**, e.g. `cm-session:tracking`.
- Varies only on the **existence** of the key, never its value, and `getCacheableMetadata()` returns
  empty metadata. Use it in `#cache['contexts']` to differentiate cache variants for visitors who do
  vs. don't have a given session flag set, without leaking the value into the cache id.

## Update-report security sort

`hook_preprocess_update_report()` (`cm_tools.module`) reorders the available-updates report at
`admin/reports/updates`: for each project-type table it `uksort()`s rows by
`#project['status']` (security status) first, falling back to project machine name — surfacing
security-relevant updates at the top. Pure presentational reordering; no behaviour change.

## hook_requirements

`cm_tools_requirements($phase)` (`cm_tools.install`) adds a runtime status-report row advertising
the [monitoring endpoint](../monitoring/uptime-endpoint.md) URL. Informational only.
