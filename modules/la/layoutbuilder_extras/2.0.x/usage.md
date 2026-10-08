Layout Builder Extras is a collection of opt-in UI/UX tweaks for core Layout Builder: a per-section "Change layout" action that swaps a section's layout in place, a combined section-actions off-canvas dialog (optionally integrating Section Library), icon-only add/configure/remove buttons, a drag-handle icon, empty-wrapper cleanup, "redirect to Layout Builder on node save", and role-scoped contextual-link hiding. Every feature is off by default and toggled on one settings form.

---

The module depends only on core `layout_builder` and adds no new content model. Its settings live in `layoutbuilder_extras.settings` and are edited at `/admin/config/content/layout-builder-extras-settings` (route `layoutbuilder_extras.settings_form`, permission `manage layoutbuilder_extras settings`). The headline feature is a **layout swap**: it decorates the core section configure form (via a `RouteSubscriber` that repoints `layout_builder.configure_section` to a subclassed form, plus a `LayoutBuilderExtrasLayout` layout class that adds a "Change layout" list) so an editor can convert an existing section to a different layout while preserving its components — the actual work runs in `AlterSectionController` on route `layoutbuilder_extras.alter_section`. A second controller (`layoutbuilder_extras.section_actions`) merges core's "Choose section" with Section Library's "From library" picker into one off-canvas dialog. Both custom routes are gated by `_layout_builder_access: 'view'` — the exact access check core Layout Builder uses for its own section routes, so the module does not widen who can edit a layout. Visual tweaks are attached through a `#pre_render` override (`LayoutBuilderElementOverride`) that swaps in icon-only buttons and admin CSS, a `hook_page_attachments` drag-handle library, and a `hook_preprocess_layout` that strips empty region wrappers from rendered output. Finally, a decorator over the core contextual-link manager (`ContextualLinkManager`) can hide contextual links everywhere except Layout Builder for all but a configured set of roles — a cosmetic visibility filter, not an access control (the underlying routes still enforce their own access). A `hook_alter` (`layoutbuilder_extras_allowed_layouts`) lets other modules filter which layouts appear in the "Change layout" list.

---

- Let editors change an existing section's layout in place without deleting and re-adding it.
- Preserve a section's placed blocks/components when swapping to a layout with a different set of regions.
- Combine core "Choose section" and Section Library "From library" into a single "add section" off-canvas dialog.
- Show compact icon-only add/configure/remove buttons in the Layout Builder UI instead of text links.
- Add a visible drag-handle icon to the Layout Builder off-canvas sidebar for clearer UX.
- Position each section's action buttons to the left or top of the section.
- Automatically redirect to the Layout Builder edit screen after saving a Layout Builder-enabled node.
- Remove empty `<div>` wrappers left behind by layout templates on the rendered (front-end) page.
- Apply the module's admin CSS to restyle the "Add section" affordance.
- Hide contextual links site-wide except on Layout Builder pages, for non-privileged roles.
- Allow specific roles to keep seeing contextual links everywhere while hiding them for others.
- Programmatically restrict which layouts appear in the "Change layout" list via `hook_layoutbuilder_extras_allowed_layouts_alter()`.
- Keep all layout-editing access identical to core (custom routes reuse `_layout_builder_access: view`).
- Enable live AJAX changes on the Layout Builder configure section form.
- Give content teams a faster, less cluttered Layout Builder authoring experience with no code.
- Restyle the section-actions area (top vs left) to match a site's admin theme.
- Reduce markup bloat in Layout Builder output for cleaner front-end HTML/CSS.
- Turn each individual UX enhancement on or off independently from one settings page.
- Integrate optional Section Library section templates directly into the add-section flow.
- Scope the whole feature set behind a single, non-destructive settings permission.
