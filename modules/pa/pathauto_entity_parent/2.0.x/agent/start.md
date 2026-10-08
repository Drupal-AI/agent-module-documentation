<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pathauto entity parent (pathauto_entity_parent) — agent index

Adds a **`pathauto_entity_parent`** entity-reference base field (target: node) to nodes, and
prepends the referenced **parent node's already-stored URL alias** to the child's Pathauto
pattern, giving nested aliases like `/parent-node/child-node`. Node-only. Version **2.0.0**,
`core_version_requirement: ^11` (Drupal 11 only). Requires `pathauto` and core `node`, `path`.

## How it actually works (read this first)

- **Not a token.** The corpus's usual "parent token" guess does not apply here. There is no
  `.tokens.inc`, no `hook_token_info`.
- **Base field.** `EntityBaseFieldInfoHooks` (`hook_entity_base_field_info`) declares
  `pathauto_entity_parent`, an `entity_reference` field with `target_type: node`, on **every**
  node bundle. `hook_install`/`hook_uninstall` run an entity-definition update to install/drop it.
- **Bundle gating.** The settings form (`admin/config/search/parent`, config
  `pathauto_entity_parent.settings` key `bundles`) lists node content types. Only checked bundles
  actually use the field:
  - `FormAlterHooks` on a checked bundle **moves** the parent widget into the URL-alias (`path`)
    fieldset and disables it unless Pathauto's *generate automatic alias* checkbox is ticked; on an
    unchecked bundle it sets `#access = FALSE`.
  - `PathautoPatternAlterHooks` acts only when `$node->bundle()` is in the checked list.
- **The alias prepend.** `hook_pathauto_pattern_alter`: if the node has a parent set, load the
  parent node, `AliasRepository::lookupBySystemPath('/node/<pid>', <langcode>)`, and
  `setPattern(parentAlias . '/' . currentPattern)`. It reads the parent's **stored** alias — a
  single DB read, **no recursion**. N-level nesting comes from the parent's stored alias already
  containing its own parent's.
- **Cleanup.** Unchecking a bundle calls `StorageHelper::removeValueFromBundles()`, a parameterized
  `UPDATE node_field_data SET pathauto_entity_parent = NULL WHERE type IN (...)`.

## Consequences / gotchas

- The parent must **already have an alias** when the child is generated; the child copies the
  parent's stored alias verbatim.
- **No dependency tracking / no cache metadata** is added for the parent alias, so changing a
  parent's alias does **not** auto-update children — bulk-regenerate aliases after moving a page.
- Moving a page changes its URL and every descendant's → pair with the **`redirect`** module.
- A parent **cycle does not cause runtime recursion or DoS** (it is a stored-alias lookup, not a
  regeneration); a loop just yields stale/odd aliases.

## Solution types

- `configure/` — enabling bundles, the node-form behaviour, end-to-end setup.
- `fields/` — the `pathauto_entity_parent` base field: shape, setting it programmatically, storage.

## Files

- `src/Hook/EntityBaseFieldInfoHooks.php` — declares the base field.
- `src/Hook/FormAlterHooks.php` — relocates/gates the widget on node forms.
- `src/Hook/PathautoPatternAlterHooks.php` — prepends the parent alias to the pattern.
- `src/Hook/HelpHooks.php` — help text.
- `src/Form/ConfigForm.php` — bundle selection settings form.
- `src/StorageHelper.php` — nulls the field for de-selected bundles.
- `pathauto_entity_parent.install` — installs/removes the base field.
