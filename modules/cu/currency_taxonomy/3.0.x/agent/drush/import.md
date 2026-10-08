<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush re-import command

Registered in `drush.services.yml` as `currency_taxonomy.commands` →
`Drupal\currency_taxonomy\Commands\CurrencyTaxonomyCommands` (arg `@entity_type.manager`, tag
`drush.command`).

## Command
- `currency-taxonomy:import` (alias `cti`) — method `deletePrivateFields()` in
  `src/Commands/CurrencyTaxonomyCommands.php`.

```
drush currency-taxonomy:import
drush cti
```

## What it does
1. Prompts for confirmation (`$this->io()->confirm(...)`); a "no" throws `UserAbortException`.
2. Queries all `taxonomy_term` with `vid = currency` using `accessCheck(FALSE)` (CLI/admin context).
3. Loads and **deletes** every currency term (`$term_storage->delete($terms)`).
4. Calls `currency_taxonomy_add_terms()` to re-create terms from `currency_codes.json`.
5. Writes "All currency codes have been re-imported.".

## When to use
- After editing the bundled `currency_codes.json` to refresh the term set.
- To reset the vocabulary back to the shipped canonical list after manual edits.

Note: this **destroys and recreates** all `currency` terms, so any term ids or extra fields added to
existing terms are lost (references by tid will break). Run in a maintenance window.
