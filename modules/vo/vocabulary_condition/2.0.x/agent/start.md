<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vocabulary Condition (vocabulary_condition) — agent index

Provides two core **Condition plugins** for block/context visibility that test the taxonomy
context of the current page: match by vocabulary, by specific term, and — the distinguishing
feature — by a term's **descendants**. Works on taxonomy term pages and on content (node) pages.
Depends only on core `taxonomy`. Core requirement `^10.3 || ^11 || ^12`.

No settings page (configure: null). No routes, permissions, services, hooks, or drush. Configuration
is per-condition-instance, stored inside the host block's `visibility` config. Provides config schema.
Plugins attach to core's existing `condition` plugin type — the module defines no new plugin type.

- **Understand the two condition plugins (ids, contexts, evaluate/match logic, cache tags)** → [plugins/conditions.md](plugins/conditions.md)
- **Configure a condition on a block (form fields, config keys + schema, set via config/PHP)** → [configure/conditions.md](configure/conditions.md)

Key facts:
- Plugin ids: `vocabulary` ("Vocabulary or term", context `entity:taxonomy_term`) and
  `vocabulary_node` ("Content tagged with vocabulary", context `entity:node`).
- Base class `Drupal\vocabulary_condition\Plugin\Condition\VocabularyConditionBase`
  (extends `ConditionPluginBase`, injects `entity_type.manager`).
- Config keys: `bundles` (vocabulary machine names), `terms` (integer term ids),
  `include_descendants` (bool).
- Config schema types: `condition.plugin.vocabulary`, `condition.plugin.vocabulary_node`, both
  mapping onto `vocabulary_condition.condition` (extends `condition.plugin`).
- Selected vocabularies and terms are combined with **OR**; with neither selected the condition
  does not restrict. Multiple conditions on one block are AND-ed by the block system.
- Consume from code via `plugin.manager.condition`.
