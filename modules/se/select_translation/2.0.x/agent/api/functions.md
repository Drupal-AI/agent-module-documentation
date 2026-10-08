<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PHP API

Two procedural functions in `select_translation.module` implement the same selection
algorithm the Views filter uses.

## `select_translation_of_node($nid, $mode = 'default')`

Loads node `$nid` and returns the node object in the selected translation (a
`\Drupal\node\NodeInterface`), or `NULL` if the node does not exist. It never returns a
"no translation" — the original (untranslated) translation is the guaranteed final fallback.

`$mode` values:

- `'original'` — current interface language; else the node's original language.
- `'default'` (default arg) — current interface language; else site default; else original.
- a **comma-separated langcode list**, e.g. `'fr,en,current,default,original'` — returns the
  first available translation in that order. Tokens `current` (current interface language),
  `default` (site default language) and `original` (original node language) are substituted;
  `original` is always appended as the final fallback.

```php
$node = select_translation_of_node(42, 'fr,en,current');
if ($node) {
  $langcode = $node->language()->getId();
  $title = $node->label();
}
```

## `select_translation_parse_mode($mode)`

Helper that expands a mode string into an ordered, de-duplicated array of langcodes (with
`current`/`default` resolved and `'original'` appended). `'original'` → `['current','original']`;
`'default'` → `['current','default','original']`; a list is lowercased/trimmed then has
`'original'` appended. Mostly internal, but callable if you need the resolved order itself.

Note: these are **procedural functions**, not a service — call them directly (the file is
always loaded when the module is enabled). The module defines no service, no plugin manager,
and no hooks of its own for others to implement.
