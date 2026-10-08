<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Tree — agent index

Provides the `entity_reference_tree` field widget: a jsTree modal with a searchable,
checkbox hierarchy for picking entity-reference values (great for deep taxonomies).
Selected on a field's *Manage form display*. No settings page, permission, or Drush.

- **Enable the widget on a reference field + its settings (config schema keys)** →
  [configure/widget.md](configure/widget.md)
- **Tree data services (`entity_reference_tree_builder` tag) and adding your own builder** →
  [extend/tree-builders.md](extend/tree-builders.md)
- **Customize a taxonomy term's tree label** →
  [hooks/term-label.md](hooks/term-label.md)

Key facts: widget id `entity_reference_tree` (`EntityReferenceTreeWidget`, extends
`EntityReferenceAutocompleteWidget`, `multiple_values = TRUE`), for `entity_reference`
fields. Settings schema `field.widget.settings.entity_reference_tree` (`theme`, `dots`,
`label`, `dialog_title`, `match_limit`, `match_operator`, `worker`, `disable_animation`,
`force_text`, `placeholder`, `size`, `autocomplete_maxlength`). Tree JSON at
`/admin/entity_reference_tree/json/{entity_type}/{bundles}`. Depends on core `field`.
