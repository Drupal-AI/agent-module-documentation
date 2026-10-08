<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy Delete — Drush

Declared in `drush.services.yml` → `Drupal\taxonomy_delete\Commands\TaxonomyDelete`
(injects `entity_type.manager`, `logger.factory`).

## Command
`taxonomy-delete:term-delete` — alias `tdel`.

```
drush taxonomy-delete:term-delete <vid>
drush tdel <vid>
```

- `<vid>` is a vocabulary machine name, or a comma-separated list for several at once,
  e.g. `drush tdel tags,categories`.
- Empty argument throws `\Exception('Vocabulary name is not specified.')`.
- Prompts interactively: "Are you sure you want to delete all taxonomy terms from
  `<vid>`?" — declining throws `UserAbortException` (no deletion). Add `-y` to skip the
  prompt in scripts.
- Builds an entity query with `condition('vid', explode(',', $vid), 'IN')` and
  `accessCheck(FALSE)`, then deletes each matched term through a Drush batch
  (`BatchService::deleteTerm` → `$term->delete()`).
- Writes "All selected taxonomy terms have been removed." (and a `taxonomy_delete` logger
  info line) on success, or "No taxonomy terms found." if the vocabulary is empty.

Note: the command does not validate that `<vid>` names an existing vocabulary; a typo
simply matches no terms and reports "No taxonomy terms found."
