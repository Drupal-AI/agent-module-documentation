Display Suite Extras is an optional submodule of Display Suite that bundles less-frequently-used display features such as block regions, extra fields, per-field view permissions, and hidden regions.

---

Display Suite Extras extends the main Display Suite module with functionality that not every site needs, kept out of core DS to stay lean. It lets you expose Display Suite layout regions as placeable blocks, surface "extra fields" that other modules declare on an entity, and apply view permissions to individual DS fields so different roles see different fields. It adds a "hidden" region whose fields are still built (useful for tokens or side effects) but never printed, and an inline "switch view mode" field. Its options are toggled at the Display Suite settings page (`/admin/structure/ds/settings`). It provides dynamic per-field permissions generated from the entities and fields present on the site. Enable it only if you need one of these specific capabilities.

---

- Expose a Display Suite region as a block you can place in any theme region.
- Show "extra fields" (like the node links or submitted-by) that modules declare.
- Restrict viewing of a specific DS field to certain roles via field permissions.
- Compute fields in a hidden region without printing them (e.g. for token side effects).
- Let editors switch a node's view mode inline with the switch-view-mode field.
- Reuse an entity's rendered region as block content in a sidebar.
- Grant a role access to see a "price" or "internal notes" DS field while hiding it from others.
- Keep a metadata field populated for other logic while keeping it invisible on the page.
- Move node contact/author links into a specific layout region.
- Selectively expose Views or module-provided extra fields on a display.
- Build role-differentiated displays without cloning view modes.
- Combine block regions with a custom layout to inject dynamic blocks per entity.
- Provide a "read more" or admin-only region gated by permission.
- Surface RSS/links pseudo-fields in a DS layout.
- Toggle only the extras features you need from one settings page.
