Makes Drupal's draggable tables (menus, taxonomy, field/display ordering, etc.) collapsible so parent rows with large sub-trees can be folded away, making drag-and-drop reordering usable on big hierarchies.

---

Drupal's `tabledrag` powers hierarchical draggable tables (menu links, taxonomy terms, Manage
fields/display, and more), but they become unwieldy when a parent has more children than fit on
screen. Collapsible DnD attaches a JavaScript behavior (`collapsible_dnd/collapsible_draggables`)
that adds expand/collapse toggles to sub-trees, and it registers that library as a dependency of
core's `drupal.tabledrag` via `hook_library_info_alter`, so it applies automatically wherever a
draggable table appears — no per-table setup. A settings form at
`/admin/config/user-interface/collapsible-dnd` (permission "administer collapsible dnd settings")
controls where and how it runs: a newline-separated list of **route patterns** (with `*` wildcards)
that act as an **exclusion** list by default, or an **allow** list when "Enable only on matching
routes" is checked; empty patterns means everywhere. Three optional table-toolbar controls —
**Expand all**, **Collapse all**, and a **table search** box — are off by default and toggled in the
same form. The route decision and toolbar flags are passed to the browser via
`drupalSettings.collapsibleDnd` in `hook_page_attachments`; a `hook_preprocess_html` also adds an
`theme-<admin_theme>` body class so the CSS can adapt. Config lives in `collapsible_dnd.settings`.

---

- Collapse a huge menu tree so you can drag a top-level item without scrolling past all its children.
- Reorder deeply nested taxonomy terms without losing track of the row you're dragging.
- Fold sub-trees on the Manage fields / Manage display draggable tables.
- Add an "Expand all" / "Collapse all" toolbar to draggable tables for quick navigation.
- Add a search box to filter rows within a large draggable table.
- Limit the feature to specific admin screens using an allow-list of route patterns.
- Exclude the feature from certain routes where it interferes, using the default exclusion list.
- Use wildcard route patterns (e.g. `entity.entity_form_display.*`) to target a family of routes.
- Enable collapsible drag-and-drop site-wide by leaving the pattern list empty.
- Make menu administration practical on sites with very large navigation structures.
- Improve editor UX on any contrib module that renders a tabledrag table.
- Keep long draggable tables manageable on smaller/laptop screens.
- Reduce mis-drops when moving a parent row whose subtree exceeds the viewport.
- Restrict the toolbar controls to only the tables where they add value.
- Provide a consistent collapse/expand affordance across all hierarchical admin tables.
- Speed up bulk menu reorganization during content architecture work.
- Turn off the toolbar entirely (defaults) for a minimal, keyboard-friendly experience.
- Adapt styling to the active admin theme automatically via the added body class.
- Help site builders manage complex field ordering during content-type setup.
- Ship the enhancement to all editors without per-user or per-table configuration.
