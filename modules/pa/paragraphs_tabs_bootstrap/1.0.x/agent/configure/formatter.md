<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the tabs formatter & widget

## Wire it up
1. Add a Paragraphs (entity reference revisions) field to a content type, allowing
   multiple values and one or more paragraph types.
2. **Manage form display** → set the field widget to **Paragraphs Tabs** (tabbed editor).
3. **Manage display** → set the field formatter to **Paragraphs Tabs** (front-end tabs).
4. Use a Bootstrap 5 theme for correct styling.

## Formatter settings (config schema keys)
- `vertical` (bool) — vertical vs horizontal tabs.
- `mode` — `tab` or `pill` presentation.
- `form_mode` — form mode used to render each paragraph for inline editing.
- `custom_class` — extra CSS class on the container.
- `bottom_text` — text appended under the tab set.
- `hide_line_operations` — which row operation buttons to hide.
- `empty` / `empty_cell_value`, `parent`, `links`, `owner` — auxiliary display flags.

## Add-component (AJAX) flow
- Route `paragraphs.add`: `/paragraphs-tabs/add/{paragraph_type}/{entity_type}/{entity_field}/{entity_id}`.
- `ComponentFormController::addForm` opens `AddComponentForm` in an 80%-width modal dialog
  (falls back to a normal page when not an AJAX request).
- On submit the form creates a new paragraph of `{paragraph_type}`, appends
  `{target_id, target_revision_id}` to `{entity_field}` on the loaded host entity,
  saves the host, and redirects back to the current page.

## Access
`ParagraphAccessController::accessAdd` decides who may add:
- if `paragraphs_type_permissions` on → needs `create paragraph content <bundle>`;
- else if `field_permissions` on → honours the field's permission_type (custom/private);
- else → requires `update` access on the parent host entity.
