<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extending the term list

Only Polish (`pl`) terms ship by default. Add terms for other languages (or extend `pl`) by implementing the alter hook — the array is keyed by langcode, each value a list of terms/patterns fed into `preg_replace`.

```php
/**
 * Implements hook_hanging_conjunction_filter_terms_alter().
 */
function MYMODULE_hanging_conjunction_filter_terms_alter(array &$terms) {
  $terms['en'] = ['a', 'an', 'the', 'of', 'to', 'in', 'on', 'and', 'or'];
  // Extend the existing Polish list.
  $terms['pl'][] = 'ków';
}
```

Notes:
- Terms are injected into `/\s(TERM)(\s)/i` style regexes, so regex metacharacters in a term are interpreted as patterns (the built-in `pl` list even includes `[a-z]`). Escape literals if needed.
- The filter only processes text whose langcode has an entry, so a language with no list is passed through unchanged.
