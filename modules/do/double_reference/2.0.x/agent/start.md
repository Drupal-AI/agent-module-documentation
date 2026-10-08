<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Double Reference (double_reference) — agent index

**A field type whose one item holds two entity references: a primary and an "added" reference.**

- **Version:** 2.0.x (2.0.0-alpha5)
- **Core:** ^9 || ^10 || ^11 (no non-core dependencies)
- **Field type:** `double_reference` (extends core EntityReferenceItem; adds ar_target_id/ar_entity, ar_target_type storage setting)
- **Widgets:** `double_reference_autocomplete`, `double_reference_autocomplete_select`
- **Formatter:** `double_reference_label` (extends EntityReferenceLabelFormatter)
- **Integrations:** hook_field_views_data_views_data_alter; EntityUsage Track plugin
- **Config schema:** field.storage_settings / field.field_settings / widget / formatter for double_reference

**Security:** No routes, permissions, or mutating endpoints — a field plugin only. Output is escaped (`#plain_text` / `#type => link`). Minor note: the label formatter loads the added-reference entity with `entityTypeManager->getStorage()->load()` and prints its label without an explicit access check (DoubleReferenceLabelFormatter::viewElements), a low-impact label disclosure for the second reference.

See [configure/double_reference.md](configure/double_reference.md)