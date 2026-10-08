<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API AZ Glossary — hooks

One alter hook (`search_api_glossary.api.php`):

## `hook_search_api_glossary_source_alter(&$source_value)`

Called by `GlossaryHelper::glossaryGetter()` on the **first letter** before grouping, so you can
normalise it — most commonly accent folding so "Über" files under **U**, "Éric" under **E**, etc.

```php
/**
 * Implements hook_search_api_glossary_source_alter().
 */
function MYMODULE_search_api_glossary_source_alter(&$source_value) {
  $replacements = [
    'À' => 'A', 'Á' => 'A', 'Â' => 'A', 'Ä' => 'A', 'Å' => 'A',
    'É' => 'E', 'È' => 'E', 'Ê' => 'E', 'Ë' => 'E',
    'Ü' => 'U', 'Ö' => 'O', 'Ñ' => 'N', 'Ç' => 'C',
    // ... lower-case variants too
  ];
  $source_value = strtr($source_value, $replacements);
}
```

`$source_value` is passed by reference; mutate it in place (no return). The module's own
`search_api_glossary.api.php` ships a full example mapping covering the Latin-1/Latin Extended-A
accented characters. This is the only hook the module invites.
