<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Change (entity_change) — agent index

Developer **plugin framework** for detecting arbitrary changes on updated **content entities** by
comparing an updated entity to its `original` (pre-update) copy. Package `Other`. Version
**3.0.0-beta2**. Core `^10 || ^11`. License GPL-2.0-or-later.

**No dependencies** (info.yml declares none), no routes, no permissions, no forms, no config,
no config schema, no Drush, no `.module`/hooks. It "does nothing on its own" (README) — other
code calls the manager. Node example plugins reference `Drupal\node`, but node is not a declared
dependency.

- **The plugin type, manager API, base class/trait, and the three example plugins** →
  [plugins/entity-change.md](plugins/entity-change.md)

## What it actually is

- Defines one plugin type **`EntityChange`**, namespace `Plugin/EntityChange`, discovered by both
  the PHP attribute `src/Plugin/Attribute/EntityChange.php` and the legacy annotation
  `src/Annotation/EntityChange.php`.
- Service **`plugin.manager.entity_change`** → `Drupal\entity_change\Plugin\EntityChangeManager`
  (parent `default_plugin_manager`), in `entity_change.services.yml`.
- Plugin contract: `EntityChangeInterface::changed(): bool`; base class `EntityChangeBase`
  (context-aware, provides cached `changed()` + abstract `applies()` and `hasChanged($new,$old)`);
  reusable type/bundle matching via `EntityChangeTrait::applies()`.
- Ships three example node plugins in `src/Plugin/EntityChange/`: `NodeJustPublished`,
  `NodeJustUnpublished`, `ReTitled`.
