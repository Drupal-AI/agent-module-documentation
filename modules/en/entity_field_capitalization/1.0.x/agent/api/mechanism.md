<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The presave transform and CapitalizationService

## Entry point — `hook_entity_presave`

`entity_field_capitalization_entity_presave(EntityInterface $entity)` in
`entity_field_capitalization.module`:

1. Returns early unless `$entity instanceof ContentEntityBase` (config entities are ignored). The
   guard also tests `\Drupal::currentUser()->id() < 0`, which is never true (anonymous is `0`), so in
   practice the hook runs for saves by any user, including anonymous-initiated ones.
2. Loads the service `entity_field.capitalization`, reads `getEntityTypeId()` and `bundle()`.
3. If `hasEntity($entity_type, $bundle)` is TRUE, gets the configured field list via
   `getCapitalizationFields()` and, for each `$field_name`, reads `$entity->get($field_name)->getString()`,
   runs it through `capitalization()`, and writes it back with `$entity->set($field_name, $capitalized_value)`.

Because the value is set on the entity before save, the transformed string is what gets **stored** —
this is a write-time normalizer, not a formatter. Existing content is only changed when re-saved.

## `CapitalizationService` (`src/CapitalizationService.php`)

Implements `CapitalizationInterface`. Constructor takes `ConfigFactory`, loads
`entity_field.capitalization_config`, and calls `parseConfigData()`.

- `parseConfigData()` (private): splits `entity_and_fields` on line breaks
  (`preg_split("/\r\n|\r|\n/", …)`); each line is `explode(',', …)` where the first token is the
  entity type, the second the bundle, and the remainder the field names → stored as
  `$uppercaseItems[entity_type][bundle] = [field, …]`. `exclude_strings` is `explode(',', …)` into
  `$excludedStrings`.
- `hasEntity($entity_type, $bundle)`: TRUE when `$uppercaseItems[$entity_type][$bundle]` is non-empty.
- `getCapitalizationFields($entity_type, $bundle)`: returns that field array (or `[]`).
- `getExcludeList()` / `addToExcludeList(array)`: read / replace the exclusion list.
- `capitalization($value)`: the transform. Runs `preg_replace_callback('/[\pL\pM\pN][\pL\pM\pN\']*/u', …)`
  over the value; each matched "word" (Unicode letters/marks/numbers plus apostrophe) is replaced with
  its `mbUcfirst()` unless the exact match is in the exclusion list (`in_array(..., FALSE)` — loose
  compare). Only word starts are touched; the rest of each word is left as typed.
- `mbUcfirst($s)` (private): UTF-8 title case of the first character —
  `mb_convert_case(mb_substr($s,0,1), MB_CASE_UPPER, 'UTF-8') . mb_substr($s,1)`.

Net effect: first letter of every word is upper-cased (UTF-8 safe), excluded strings pass through
unchanged. It does not lower-case the rest, so `iPod` stays `IPod` unless excluded.

## Notes

- `getString()` flattens the field to a plain string, so applying this to composite fields
  (e.g. a formatted-text field with a summary/format, or multi-value fields) can lose non-value
  properties on save — intended targets are plain text fields like titles and names.
- The exclusion match is case-sensitive and matches whole words only.
