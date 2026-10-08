# Layout Builder Additions — agent index

Code-only UX tweaks for core Layout Builder. **No configuration**, no permissions, no schema, no Drush,
no plugins. Depends on core `layout_builder`. Enable to apply; uninstall to revert. Suggests
`layout_builder_modal`.

- **The three behaviours (block-form titles, form-alter tidy-ups, Layout entity operation) and how they
  are wired** → [extend/behavior.md](extend/behavior.md)

Key facts:
- `RouteSubscriber` swaps static titles on `layout_builder.add_block` / `layout_builder.update_block`
  for `_title_callback`s (`LayoutBuilderBlockFormTitle::addBlock` / `::updateBlock`).
- `hook_form_alter` hides `settings.admin_label` on the block add/update forms; for `media`-bundle inline
  blocks it moves label + view mode to the top and renames view mode to "Image size".
- `hook_entity_operation` adds a **Layout** op to nodes, gated by `Url::fromRoute(
  'layout_builder.overrides.node.view')->access($currentUser)` (respects LB permissions).
