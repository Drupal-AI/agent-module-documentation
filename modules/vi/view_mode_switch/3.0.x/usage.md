<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
View Mode Switch Field provides a `view_mode_switch` field type that lets content editors choose, per entity, which view mode one or more of the entity's "origin" view modes should be rendered as.

---

You add a `view_mode_switch` field to a bundle and configure two things: on the field **storage** settings, `origin_view_modes` — the set of view modes this field takes over; and on the field **instance** settings, `allowed_view_modes` — the view modes an editor is permitted to switch to. When an editor edits the entity, the field's widget offers a choice among the allowed view modes; the chosen value is stored on the entity. At render time the module's `hook_entity_view_mode_alter()` implementation (via the `ViewModeSwitch` service's `getViewModeToSwitchTo()`) checks whether the entity is being displayed in one of the field's origin view modes and, if so, swaps the active view mode to the editor's chosen one — so the same node can be shown with different display configurations depending on the per-entity selection. The module ships the field type, a widget (`view_mode_switch`), two formatters (`view_mode_switch_default` and `view_mode_switch_machine_name`), a Diff field builder plugin for revision comparison, and a set of attribute-based hooks (including a status-report/runtime-requirements check and cleanup when a view mode is deleted). It requires Drupal 11.3+ (core `field`), has no configure route, no permissions, and no Drush commands.

---

- Let an editor pick whether a specific node renders using the "Full", "Teaser", or a custom view mode.
- Give one hero node a different layout from all others without a new content type.
- Allow authors to switch a promoted article to a richer display mode on the homepage.
- Constrain editors to a curated set of allowed view modes via the field instance settings.
- Take over the "Full content" view mode and redirect it to an editor-chosen alternative.
- Take over multiple origin view modes with a single switch field (storage `origin_view_modes`).
- Offer a per-entity display toggle inside a Paragraph (with the Paragraphs module).
- Show revision diffs of the chosen view mode via the bundled Diff integration.
- Present a machine-readable value of the chosen view mode using the machine-name formatter.
- Display the human-readable chosen view mode with the default formatter.
- Build editorial "display variants" that non-developers can select on the edit form.
- Switch a media entity's rendering per item without cloning displays.
- Let editors demote a node to a compact display for archive listings.
- Keep display selection as structured field data (exportable, revisionable).
- Automatically clean up a switch field's options when a referenced view mode is deleted.
- Warn on the status report when a switch field references a removed view mode.
- Drive different Layout Builder / display configurations from a single per-entity choice.
- Give marketing control over which of several approved layouts a landing node uses.
- Avoid custom preprocess/theme code just to vary a single entity's view mode.
- Combine origin + allowed view modes to model "default vs featured" rendering.
- Support translation-aware, per-entity display selection as a normal field.
