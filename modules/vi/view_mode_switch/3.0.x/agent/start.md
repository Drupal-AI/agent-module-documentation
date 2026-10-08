<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# View Mode Switch Field — agent index

Provides a `view_mode_switch` **field type**. An editor picks, per entity, which view mode the
entity's "origin" view mode(s) should render as; at display time a hook swaps the active view
mode to the chosen one. No configure route, no permissions, no Drush. Requires Drupal **11.3+**.

- **Add/configure the field: storage `origin_view_modes`, instance `allowed_view_modes`,
  widget & formatters** → [configure/field.md](configure/field.md)
- **Runtime switch mechanism (`hook_entity_view_mode_alter`, `ViewModeSwitch` service) &
  the plugins it ships** → [api/mechanism.md](api/mechanism.md)

Key facts: field type `view_mode_switch` (default widget `view_mode_switch`, default formatter
`view_mode_switch_default`; also `view_mode_switch_machine_name`). Storage setting
`origin_view_modes` = which view modes the field overrides; field setting `allowed_view_modes` =
which the editor may choose. Depends on core `field`; integrates optionally with Diff and
Paragraphs.
