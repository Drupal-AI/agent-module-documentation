<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Ids lets editors give a custom HTML `id` to individual blocks and sections in Layout Builder, so they can be targeted by anchor links (`#my-id`), CSS, or JavaScript.

---

The module adds an optional **"Block ID"** field to the Layout Builder add/update-block forms
(`layout_builder_add_block`, `layout_builder_update_block`) and a **"Section ID"** field to the
configure-section form (`layout_builder_configure_section`), controlled by the two booleans in
its config object `layout_builder_ids.settings` (`block_id`, `section_id`, both default `1`).
Entered ids are validated (must start with a letter; only letters, numbers, hyphens and
underscores; unique across the page) by the static helpers in `LayoutBuilderIdsService`. A
block's id is stored on the section component (`SectionComponent::set('layout_builder_id', …)`,
i.e. in the component's `additional` data), and a section's id is stored in the layout
configuration (`layout_builder_id`). At render time an event subscriber
(`LayoutBuilderIdsRenderSubscriber`, listening on `SECTION_COMPONENT_BUILD_RENDER_ARRAY`) sets
`#attributes['id']` on each block that has an id, so the chosen value becomes the real DOM id.
The settings form lives at `/admin/config/user-interface/layout-builder-ids` and requires the
core `administer site configuration` permission. There are no plugins, permissions of its own,
or Drush commands.

---

- Give a Layout Builder block a stable HTML `id` so you can link to it with `#section-name`.
- Add anchor targets to a long landing page built with Layout Builder.
- Assign a section its own `id` for a "jump to" table-of-contents link.
- Target a specific block with custom CSS using its id selector.
- Hook JavaScript behaviour onto a particular Layout Builder block by id.
- Build in-page navigation ("Back to top", "Skip to pricing") that points at section ids.
- Ensure ids are unique per page (the module rejects duplicates during validation).
- Enforce valid id syntax (must start with a letter; letters/numbers/hyphens/underscores only).
- Turn off the Block ID field site-wide while keeping Section IDs (toggle `block_id`).
- Turn off the Section ID field while keeping Block IDs (toggle `section_id`).
- Let content editors set anchors without touching code or custom block classes.
- Create deep links to specific promotional blocks for marketing campaigns.
- Provide accessible landmark ids for assistive-technology navigation.
- Give an embedded form block an id so an external link can scroll straight to it.
- Reference a section id in analytics or scroll-tracking scripts.
- Coordinate smooth-scroll libraries with editor-chosen ids.
- Keep anchor ids consistent across content revisions (stored in layout config).
- Disable the whole feature quickly by unchecking both toggles in settings.
- Add an id to a hero section so a "Get started" button can scroll to it.
- Link support docs directly to a specific FAQ block by its id.
