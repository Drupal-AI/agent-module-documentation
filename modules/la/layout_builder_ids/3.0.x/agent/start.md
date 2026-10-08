<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Ids — agent index

Adds an optional custom HTML **`id`** to Layout Builder **blocks** and **sections** (for
anchor links, CSS, JS). Depends on core `layout_builder`. Two on/off toggles in the config
object `layout_builder_ids.settings`. No plugins, no own permissions, no Drush.

- **Settings config object + the settings form (block_id / section_id)** →
  [configure/settings.md](configure/settings.md)
- **Where ids are stored, how they render, and the validation rules** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Config object **`layout_builder_ids.settings`**: `block_id` (int 0/1) and `section_id`
  (int 0/1), both default `1`. Settings UI `/admin/config/user-interface/layout-builder-ids`
  (route `layout_builder_ids.settings`, permission **`administer site configuration`**).
- Block id → stored on the `SectionComponent` (`layout_builder_id`, in its `additional` data);
  Section id → stored in the section's layout configuration (`layout_builder_id`).
- Rendered onto the block as `#attributes['id']` by `LayoutBuilderIdsRenderSubscriber`.
