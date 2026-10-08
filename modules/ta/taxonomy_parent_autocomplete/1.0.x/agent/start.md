<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy Parent Autocomplete (taxonomy_parent_autocomplete) — agent index

Replaces the taxonomy term form **Parent** multi-select with an **entity_autocomplete**. Version **1.0.3**, core `^9 || ^10`. No dependencies.

**Shape:** `hook_form_alter` on `taxonomy_term_form` base form → swaps `$form['relations']['parent']` for `entity_autocomplete` (`#target_type: taxonomy_term`, `#tags: TRUE`, `target_bundles` = current `vid`); `#after_build` `taxonomy_parent_autocomplete_process` normalizes empty → `[]`. `hook_install()` sets core `taxonomy.settings:override_selector = TRUE`.

**Surface:** pure form alteration; no routes/services/permissions/config entities. Governed by existing taxonomy edit permissions. Nothing security-relevant.
