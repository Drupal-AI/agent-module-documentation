<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Current Language (entity_reference_current_language) — agent index

One **Entity Reference Selection** plugin, `current_language`, that filters the candidates offered by
a reference field to the **current interface language**. Package `Field types`. Depends only on core
**`language`**. Core `^10 || ^11`. License GPL-2.0-or-later. Version-dir 1.0.x (installed release
`1.0.0-beta1`, pre-release).

- **The selection plugin, its setting, how to enable it per field, and the query it builds** →
  [plugins/selection.md](plugins/selection.md)

## What it actually is

- One class: `CurrentLanguageSelection`
  (`src/Plugin/EntityReferenceSelection/CurrentLanguageSelection.php`), plugin id **`current_language`**,
  label *"Current Language"*, group `current_language`, extending core
  `Drupal\Core\Entity\Plugin\EntityReferenceSelection\DefaultSelection`.
- No routes, no permissions, no services, no hooks, no config schema, no submodules, no Drush, no
  `composer.json`, no libraries. It provides a plugin instance of an existing core plugin type — it does
  not define a new plugin type.
- Choose it as the **Reference method** on a reference field's settings; the "Filter by current
  language" checkbox (default on) toggles the langcode filter.

## Mechanism (from source)

- `buildConfigurationForm()` adds a `current_language` checkbox (`$this->configuration['current_language']
  ?? TRUE`) to the standard Default-selection settings form.
- `buildEntityQuery()` calls `parent::buildEntityQuery()`, then — only when
  `$this->configuration['current_language']` is truthy — adds
  `->condition('langcode', \Drupal::languageManager()->getCurrentLanguage()->getId())`. It only narrows
  the core Default handler's already access-filtered query; it never widens it.
