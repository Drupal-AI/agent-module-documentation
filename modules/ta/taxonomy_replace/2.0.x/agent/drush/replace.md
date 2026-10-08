<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Replacing terms: UI and Drush

## UI flow
1. Open a taxonomy term; use the **Replace** tab or the **Replace** operation (`/taxonomy/term/{tid}/replace`).
2. Access requires the `replace taxonomy terms` permission **and** delete access to that term.
3. The form (a delete-confirm form) shows the current term, lists the nodes that will be updated, and offers an **entity-autocomplete** limited to the same vocabulary — you may enter **multiple** replacement terms (comma-separated).
4. Submit: `TaxonomyReplaceService::replace()` runs, a status message reports how many references changed, the **old term is deleted**, and you are redirected to the first replacement term.

Validation blocks choosing the same term as its own replacement.

## What replace() does (per affected node)
- Finds affected nodes via the `taxonomy_index` table (`getNidsByTid()`).
- Locates the entity-reference field on the node that targets `taxonomy_term`.
- Appends each new term (skipping any already referenced), removes the old term, and `save()`s the node.
- Logs `References to %old_term have been replaced by references to %new_term`.

## Drush command
Registered via `drush.services.yml` (`TaxonomyReplaceCommand`, tag `drush.command`):

```
drush taxonomy:replace <oldTid> <newTid>
drush taxonomy:replace <oldTid> <newTid> --delete
```
- `--delete` deletes the old term after updating nodes.
- The command first reports the affected node count and asks for confirmation.

**Caveat:** in this branch the command body calls `replace($oldTerm, $newTerm, $limit)` with an undefined `$limit` and passes a single term where the service expects an array — so the Drush path can error. Prefer the UI, or verify on a copy before scripting bulk replacements.

## Security
Both the route and the entity operation enforce `replace taxonomy terms` **and** per-term `delete` access. Queries against `taxonomy_index` use the database API with bound conditions (no SQL string concatenation).
