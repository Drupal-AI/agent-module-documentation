<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API AZ Glossary — GlossaryHelper service

Service id: **`search_api_glossary.helper`**
(class `Drupal\search_api_glossary\Service\GlossaryHelper`). Args: `@config.factory`,
`@module_handler`. It computes the glossary letter/group for a value; the `glossary` Search API
processor uses it to fill the `glossaryaz_<field>` fields.

```php
$helper = \Drupal::service('search_api_glossary.helper');

// First letter or group for a value, given which groupings are enabled:
$label = $helper->glossaryGetter($sourceValue, $grouping);
//   $grouping is an array that may contain: 'grouping_az', 'grouping_09', 'grouping_other'
```

## What `glossaryGetter()` does

1. Takes the uppercased first character of the trimmed value
   (`mb_strtoupper(mb_substr(trim($v),0,1))`).
2. Invokes `hook_search_api_glossary_source_alter($first_letter)` so modules can normalise it
   (e.g. accent folding À→A — see hooks/hooks.md).
3. Maps to a group label via `glossaryGroupName()`:
   - alpha letter + `grouping_az` enabled → `group_prefix['alpha']` (default "A-Z")
   - numeric + `grouping_09` enabled → `group_prefix['numeric']` (default "0-9")
   - other + `grouping_other` enabled → `group_prefix['special']` (default "#")
   - otherwise returns the bare first letter.

## Helper predicates & getters

- `isAlpha($c)` — `preg_match('/^\p{L}+$/u', …)`
- `isNumeric($c)` — `preg_match('/^\p{N}+$/u', …)`
- `isSpecial($c)` — not alpha and not numeric
- `glossaryGetGroupNamePrefix()` — returns the `group_prefix` array from
  `search_api_glossary.settings`.

Group labels come from the `search_api_glossary.settings` config object (see configure/settings.md).
