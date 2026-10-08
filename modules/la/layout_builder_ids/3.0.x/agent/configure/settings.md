<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Layout Builder Ids

- **Settings form:** `/admin/config/user-interface/layout-builder-ids`
  (route `layout_builder_ids.settings`, form `LayoutBuilderIdsSettingsForm`).
- **Permission:** core `administer site configuration` (the module defines no permission).
- **Config object:** `layout_builder_ids.settings`.

## Keys

| Key | Type | Default | Effect |
|---|---|---|---|
| `block_id` | integer (0/1) | `1` | When truthy, adds a **"Block ID"** textfield to the Layout Builder *Add block* / *Update block* forms. Also gates the render subscriber that outputs the id attribute — with `block_id` off, block ids are neither collected nor rendered. |
| `section_id` | integer (0/1) | `1` | When truthy, adds a **"Section ID"** textfield to the *Configure section* form. |

The form uses checkboxes bound to these two keys via `ConfigFormBase`.

```bash
# Turn the Block ID field off, keep Section ID on:
drush cset layout_builder_ids.settings block_id 0 -y
drush cget layout_builder_ids.settings
```

## Using the fields (editor flow)

1. Edit an entity/view mode layout with Layout Builder.
2. Adding or configuring a block shows a **Block ID** field; configuring a section shows a
   **Section ID** field (when the matching toggle is on).
3. Enter an id (see validation in [../api/mechanism.md](../api/mechanism.md)); Update and Save
   the layout. The value is persisted in the layout/component config and rendered as the
   element's `id` attribute.

No per-entity or per-view-mode configuration exists — the two toggles are global.
