<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Unrestricted Label (entity_reference_unrestricted_label) — agent index

A single **entity-reference field formatter** that renders the label of every referenced entity
**without any entity access check** — so it shows labels the current user could not otherwise view.
Titled **"Label (access bypass)"**; the bypass is the deliberate, advertised feature. Version dir
`2.x` (info.yml version `2.0.0`). Package `Custom`. License GPL-2.0-or-later.
Core `^8.8 || ^9 || ^10 | ^11`. No module or Composer dependencies beyond core.

- **The formatter — id, what it renders, how it drops the access check, escaping, settings, when to
  use it** → [fields/formatter.md](fields/formatter.md)

## What it actually is

- One plugin: `EntityReferenceUnrestrictedLabelFormatter` (id
  **`entity_reference_unrestricted_label_formatter`**, label *"Label (access bypass)"*), in
  `src/Plugin/Field/FieldFormatter/EntityReferenceUnrestrictedLabelFormatter.php`, extending core's
  `EntityReferenceLabelFormatter`. `field_types = { "entity_reference" }`.
- No widget, no field type, no routes, no services, no hooks, **no permissions**, no config schema,
  no settings form. Selected per view-display on *Manage display*.

## Mechanism (from source)

- Overrides `getEntitiesToView()` to return **all** loaded referenced entities, omitting the
  `checkAccess()` / `$access->isAllowed()` gate that core's `EntityReferenceFormatterBase` applies.
  Core filters out entities the user cannot view; this formatter does not.
- Renders **only** the entity `label()`, inherited from core `EntityReferenceLabelFormatter::viewElements()`.
- `defaultSettings()` and `settingsForm()` both return `[]`, so the parent's `link` setting is
  unset — output is core's `#plain_text` (escaped) label, **not** a link to the entity.
- `settingsSummary()` prints a caution that the formatter can expose sensitive labels.
