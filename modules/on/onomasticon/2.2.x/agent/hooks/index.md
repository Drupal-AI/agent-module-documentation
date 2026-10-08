<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks & module functions

Everything here is in `onomasticon.module` and `src/Plugin/Filter/FilterOnomasticon.php`.

## Alter hook — the glossary term set

```php
/**
 * Alter the terms Onomasticon will match against for a text.
 *
 * @param \Drupal\taxonomy\Entity\Term[] $terms
 *   Published terms loaded from the configured vocabulary, keyed by term id.
 */
function hook_onomasticon_terms_alter(array &$terms) {
  // e.g. remove, add, or reorder terms; order affects match precedence.
}
```

Invoked as `\Drupal::moduleHandler()->alter('onomasticon_terms', $terms)` in
`FilterOnomasticon::getTaxonomyTerms()` (`FilterOnomasticon.php:431`), right after
`loadByProperties(['vid' => vocabulary, 'status' => TRUE])` and before translation/synonym handling.
Term order in the array determines match precedence (see the "stone wall" tip in
[../configure/filter.md](../configure/filter.md)).

## Theme hook

`onomasticon_theme()` registers the theme hook **`onomasticon`** → `templates/onomasticon.html.twig`,
with variables `tag`, `needle`, `description`, `implement`, `orientation`, `cursor`, `termlink`,
`termpath`, `term` (all default `NULL`). Override the template in your theme to change the rendered
tooltip markup. See the three implementation modes in [../configure/filter.md](../configure/filter.md).

## `hook_help`

`onomasticon_help()` provides help text on `help.page.onomasticon` (create a vocabulary → enable the
filter on a format → pick the vocabulary).

## Request-static caches (page-repetition mode)

Used only when `onomasticon_repetition` is `'page'`, to suppress repeat annotations across the whole
page render:

- `onomasticon_get_term_cache(): array` — returns the `drupal_static` list of term ids already
  annotated this request.
- `onomasticon_set_term_cache($term_id): void` — marks a term id as annotated.

For `'text'` (per-block) repetition the filter uses its own private `$termCache` property instead.
