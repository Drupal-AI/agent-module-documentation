Layout Library lets site builders save reusable Layout Builder layouts as named "layout" config entities that content authors can then pick from a select list on a per-entity basis. It is a beta extension of core Layout Builder.

---

Layout Library adds a `layout` configuration entity that stores a set of Layout Builder sections (the same section/component data core Layout Builder produces), scoped to a specific target entity type and bundle. Site builders manage these at **Admin → Structure → Layout library** (`entity.layout.collection`, `/admin/structure/layouts`): add a layout, choose the entity type/bundle it applies to, then arrange its sections and blocks in the normal Layout Builder UI. To expose the library to authors, a builder edits a bundle's **Manage display** for a Layout-Builder-enabled view mode and ticks **"Allow content editors to use stored layouts"** (a `layout_library.enable` third-party setting on the view display). Doing so auto-creates a locked `layout_selection` entity-reference field (target type `layout`, using the `layout_library` selection handler) on that bundle and adds it to the default form display, so each content item gets a "Layout" select showing only the library layouts matching its type and bundle. When an author picks a layout and the entity's per-item layout has not yet been overridden, a `PrepareLayout` event subscriber copies the chosen library layout's sections onto the entity as the starting point, which the author can then further customize. The module ships no permissions file of its own; the `layout` entity is gated by its `configure any layout` admin permission, and the per-entity Layout Builder routes reuse core's `administer <entity_type> display` permission. This is a beta release with an open TODO list, so treat it as not yet production-hardened.

---

- Save a reusable "hero + two column" layout that editors can apply to any article.
- Offer content authors a menu of pre-approved page templates instead of a blank Layout Builder canvas.
- Standardize landing-page structure across a marketing team without granting full layout access.
- Create several branded layouts per content type and let authors choose the right one per node.
- Give a specific bundle (e.g. `node.page`) a library of starter layouts scoped to just that bundle.
- Seed each new content item's Layout Builder override from a stored layout as a base to customize.
- Let editors switch a page's overall structure by picking a different library layout from a select list.
- Provide a curated set of section arrangements for a media or custom entity type that uses Layout Builder.
- Keep design consistency across a large editorial team by centralizing layouts in one library.
- Manage all reusable layouts from a single admin screen at Admin → Structure → Layout library.
- Build layouts once with blocks/fields placed, then reuse them across many content items.
- Ship layouts as configuration so they deploy between environments via config export/import.
- Restrict layout authoring to trusted users via the `configure any layout` permission while authors only select.
- Filter the author's layout options automatically to only those matching the item's entity type and bundle.
- Add a "Layout" select widget to the content form so choosing a template is part of normal editing.
- Use the `options_select` widget (or autocomplete fallback) for the layout picker on the node form.
- Remove the library option from a bundle by unticking the setting, auto-cleaning up the `layout_selection` field.
- Prototype page designs as named layouts and promote the good ones for author use.
- Provide onboarding-friendly page building where non-technical editors never touch raw Layout Builder plumbing.
- Combine with Layout Builder overrides so an author starts from a template then tweaks a single page.
- Give different bundles their own independent layout libraries that never leak options between them.
- Export a tested set of layouts as config to bootstrap a new site or a client project.
- Version-control approved page structures alongside the rest of the site configuration.
- Reduce editor error by replacing free-form layout construction with a controlled pick list.
