<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration Read-only Taxonomy UI (config_readonly_taxonomy_ui) — agent index

Add-on for **`config_readonly`** that carves a narrow exception so **taxonomy terms** can still
be **reordered** on a vocabulary's term-overview page while a site runs with
`$settings['config_readonly'] = TRUE`. Vocabulary **configuration** (settings edit, delete) stays
frozen. Requires `config_readonly` and core `taxonomy`. Version **1.0.0-alpha1**.
Core requirement `^11.1`. Ships no permissions, routes, services or config schema.

## The problem it solves
From Drupal 11.3 onward the taxonomy term-overview (reorder) form was reworked to extend
`EntityForm`. Because that form now behaves like a config form, `config_readonly` blocks it, so
editors can no longer reorder terms on a locked-down (production) site. Term ordering is an
editorial, content-adjacent operation that should stay available even when config editing is
locked.

## Mechanism (read the source — one form class, one hooks class)
- **`src/Hook/ReadonlyTaxonomyUiHooks.php`** (attribute-based hook implementations):
  - `hook_entity_type_alter()` — swaps the `taxonomy_vocabulary` `default` form class to
    `Drupal\config_readonly_taxonomy_ui\Form\VocabularyForm`, **unconditionally** (so the cached
    form definition is correct whenever read-only mode is later toggled on).
  - `hook_config_readonly_whitelist_patterns()` — returns `['taxonomy.vocabulary.*']`, adding that
    pattern to `config_readonly`'s whitelist so vocabulary-config writes (which the overview save
    path triggers) are not blocked by the lock.
  - `hook_entity_access()` — when `Settings::get('config_readonly')` is true and the entity is a
    `taxonomy_vocabulary` with operation `delete`, returns `AccessResult::forbidden()`; otherwise
    `AccessResult::neutral()`. This re-closes the vocabulary-delete path that the whitelist would
    otherwise open.
- **`src/Form/VocabularyForm.php`** (extends core `Drupal\taxonomy\VocabularyForm`) — in
  `form()`, when `Settings::get('config_readonly')` is true it sets `$form['#disabled'] = TRUE` on
  the whole vocabulary add/edit form and adds a warning that the vocabulary configuration cannot be
  edited. Core `FormBuilder` ignores incoming input for `#disabled` elements and restores their
  defaults, so this keeps vocabulary-settings editing blocked while read-only is on.

## Two things to understand
1. **Term weights are content, not config** — a term reorder made on production does not travel
   with a config export; it stays on the environment where it was made.
2. **The exception is scoped to reordering** — creating/editing vocabulary settings via the UI is
   disabled and deleting a vocabulary is forbidden while read-only is on; only term reordering is
   re-enabled.

## Files
- `data.json` — metadata.
- `usage.md` — orientation + use cases.
- `human-docs/` — manual (human) install/usage guide.
- No permissions, Drush commands, routes, services or config schema.
