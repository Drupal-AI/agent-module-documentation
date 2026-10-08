<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin Form Alter — agent index

Replaces `hook_form_alter()` with **FormAlter plugin classes** discovered under
`src/Plugin/FormAlter/`. No config, UI, permissions, or Drush. Defines three plugin
managers/types.

- **Write a FormAlter plugin (form_id / base_form_id, weight, wildcards, matching)** →
  [plugins/form-alter-plugin.md](plugins/form-alter-plugin.md)
- **Paragraphs and Inline Entity Form variants** →
  [plugins/paragraphs-ief.md](plugins/paragraphs-ief.md)

Plugin managers / annotations:
- `plugin.manager.form_alter` — `@FormAlter` (keys: `form_id[]`, `base_form_id[]`, `weight`).
- `plugin.manager.form_alter.paragraphs` — `@ParagraphsFormAlter` (key: `paragraph_type[]`).
- `plugin.manager.form_alter.ief` — `@InlineEntityFormAlter` (keys: `type`, `entity_type`,
  `bundle`, `parent_entity_type`, …).

All plugins extend `Drupal\pluginformalter\Plugin\FormAlterBase` and implement
`formAlter(array &$form, FormStateInterface $form_state, $form_id)`.

**Deprecation:** on Drupal ≥ 11.2 every invoked plugin triggers `E_USER_DEPRECATED`; these
plugins stop being called in Drupal 12. Prefer core OOP Hooks for new code.
