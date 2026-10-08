<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BS Slider Entity Reference Revision (bs_slider_entity_reference_revision) — agent index

Integration submodule of **BS Slider**. Provides one field formatter for
`entity_reference_revisions` fields. Package `Media`. Depends on **`bs_slider`** and
**`entity_reference_revisions`**. Core `^9.2 || ^10 | ^11`. No permissions. Version 1.0.0-alpha8.

- **The formatter, its settings and render path** → [fields/formatter.md](fields/formatter.md)

## What it provides (from source)

- Formatter **`bs_slider_entity_reference_revisions`** ("BS Slider"),
  `src/Plugin/Field/FieldFormatter/BsSliderEntityReferenceRevisionFormatter.php`, extends ERR's
  `EntityReferenceRevisionsEntityFormatter` and uses the parent's `BsSliderFormatterTrait`.
  `field_types = {entity_reference_revisions}`.
- `defaultSettings()` = `['bs_slider' => 'default', 'link' => FALSE] + parent`.
- `settingsForm()` merges the parent ERR form with the trait's optionset select
  (`getSettingsFormElements()`); `settingsSummary()` appends `BS Slider: {label}`.
- `viewElements()` builds the referenced revisioned entities via `parent::viewElements()`, loads
  the optionset + plugin, and calls `$plugin->view($build, $bs_slider, ['view_mode' => viewMode])`.
- No config schema, routes, permissions, services, JS or templates of its own (relies on the
  parent's `bs_slider` theme and the selected library submodule).

Parent framework → [../../../../agent/start.md](../../../../agent/start.md).
