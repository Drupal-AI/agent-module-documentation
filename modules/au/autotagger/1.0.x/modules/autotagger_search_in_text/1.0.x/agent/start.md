<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search in text fields (autotagger_search_in_text) — agent index

Submodule of **autotagger**. Provides the single Autotagger plugin `search_in_text_fields` — the only
tagging implementation shipped with the project. It scans a node's configured **source** text fields
for **taxonomy term labels** and appends the matching terms to a configured **destination**
`taxonomy_term` entity_reference field, on node presave. Pure **local literal string matching** — no
AI, no network, no external services. Depends on core **`taxonomy`** and **`autotagger`**. Core
requirement `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.5. No routes, no permissions,
no services, no config schema of its own.

- **Plugin config, the presave tagging pipeline, matching rules, and the misconfig caveats** →
  [plugins/search-in-text-fields.md](plugins/search-in-text-fields.md)
- **Parent framework / plugin type** →
  [../../../../agent/start.md](../../../../agent/start.md)

## What it actually is (from source)

- One class: `SearchInTextFields` (`src/Plugin/Autotagger/SearchInTextFields.php`),
  `@Autotagger(id="search_in_text_fields", configurable=false)`, extends `AutotaggerPluginBase`,
  implements `ContainerFactoryPluginInterface`. Injects `entity_field.manager`,
  `entity_type.manager`, and `node_type` storage.
- **`addFormOptions()`** — only acts on `node_type_add_form` / `node_type_edit_form`; adds an
  `additional_settings` details group **"Autotagger : Search in Text fields"** with:
  `autotagger_source_field` (checkboxes), `autotagger_destination_field` (select),
  `autotagger_tag_on_create_only` (checkbox). Saved via an `#entity_builders` callback
  (`entityBuilder()`) as node-type third-party setting `autotagger.search_in_text_fields`.
- **`entityPresave()`** — reads that third-party setting; if empty, returns. Tags when the node is new,
  or when create-only is off. Delegates to `tagNode()`.
- **`tagNode()`** — collects text from source fields (text/string fields directly; text fields on
  referenced node/media via `processReferencedEntity()`; text fields on referenced paragraphs and
  nested paragraphs via `processParagraphEntity()`), then loads every possible destination term
  (`getOptionsProvider()->getPossibleValues()` → `loadMultiple`) and appends each whose label matches.
- **`search()`** — NFC-normalizes both strings, collapses non-letter/digit runs to spaces, lowercases,
  wraps in spaces, and does a whole-word `strpos()` substring test. `tag()` appends
  `['target_id' => tid]` only if not already present.

## Security / trust

No routes, permissions, network calls, or raw SQL. Runs inside `node_presave` under the node's own
save access. Only appends `target_id`s of terms that already exist in the destination field's allowed
vocabularies; it never renders term or node text as markup. Clean.
