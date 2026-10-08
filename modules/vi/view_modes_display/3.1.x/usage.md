View Modes Display lets site builders preview any content entity rendered in each of its enabled view modes, from a "Preview" tab/operation added to every entity that has view modes. It is a display-debugging tool with no configuration.

---

On cache rebuild the module (`EntityTypeInfo::entityTypeAlter()`, via `hook_entity_type_alter()`) adds two
link templates to every entity type that has view modes: `vmd-preview-list`
(`/{entity_type}/{id}/view-mode/preview/list`) and `vmd-preview-render`
(`/{entity_type}/{id}/view-mode/preview/{view_mode}`). `RouteSubscriber` turns those into routes, both
requiring the `preview view modes` permission, handled by `PreviewController`. `previewList()` renders a
linked list of every enabled display mode for the entity's bundle; `previewEntity()` renders the entity in
one view mode (or `all`) wrapped in labeled `.view-mode-list-item` divs. The heavy lifting is in the
`PreviewFactory` service: `getEntityDisplays()` loads the bundle's `core.entity_view_display.*` configs,
`getEnabledDisplayModes()` returns the enabled ones (always including `full`), and `buildMarkup()` renders
the entity through its view builder — with a special case that renders `block_content` entities through the
Block plugin so blocks preview correctly. A `hook_entity_operation()` adds a "Preview" operation link on
entity list rows, and a local-task deriver (`ViewModeDisplayLocalTask`) adds a "View Mode Preview" tab on
the entity canonical route (both guarded by the `preview view modes` permission and defensive route-exists
checks to avoid WSOD during partial cache rebuilds). There is no settings form, config schema, or Drush
command. Note: the preview routes check only the `preview view modes` permission, not per-entity `view`
access — see `agent/permissions/view_modes_display.md`.

---

- Preview how a node looks in its Teaser view mode without placing it in a listing.
- Compare a piece of content across all its enabled view modes on one page.
- Preview a custom view mode (e.g. "Card", "Search result") while building its display.
- QA an entity's Full vs. Teaser rendering side by side during theme work.
- Preview `block_content` (custom block) entities in each view mode (special-cased through the Block plugin).
- Preview view modes for any content entity type — nodes, taxonomy terms, media, users, etc.
- Jump to a preview via the "Preview" operation link on an entity list (e.g. the content admin table).
- Open the "View Mode Preview" local tab on an entity's canonical page.
- Verify which display modes are actually enabled for a bundle (the list view enumerates them).
- Check field visibility/ordering differences between view modes while configuring displays.
- Debug why a field renders in one view mode but not another.
- Review responsive/image-style differences across view modes.
- Confirm a newly added view mode is picked up before wiring it into Views or Layout Builder.
- Preview an unpublished or draft entity's rendering (subject to the caveat below).
- Give a themer a quick link to every rendered display of an entity.
- Preview the default `full` view mode even when no custom display is enabled (it is always included).
- Restrict preview access to trusted builders via the `preview view modes` permission.
- Use during migration/upgrade QA to eyeball entity rendering per view mode.
