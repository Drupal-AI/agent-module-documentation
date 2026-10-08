Taxonomy Term Sidebar restructures the taxonomy term add/edit form into the same two-column "main + advanced sidebar" layout that core uses for the node edit form, so term fields sit in the main region and meta/path/relations move into a sidebar.

---

The module is a single `hook_form_alter` (plus a `hook_module_implements_alter` to run last and a `hook_preprocess_html` for a body class). It has no configuration, permissions, routes, services, schema, or dependencies. When the altered form is a taxonomy term entity form (and not the delete form), it wraps the form in a `layout-form` container, creates `main`, `advanced` (sidebar) and `footer` regions, moves every term field into the main region, builds a "Status" meta block (published state + last-saved time) and relocates the `path`, `relations` and `content_translation` groups into the advanced sidebar. It then adapts the actions/markup for the active admin theme: for **Claro** it attaches `claro/node-form` + `claro/form-two-columns` and mirrors the save buttons into a footer; for **Gin** it builds the `gin_actions` sticky bar, adds a sidebar toggle and attaches `gin/edit_form` + `gin/sidebar`, tagging the page with `gin--edit-form`. Themes that are not Gin/Claro but inherit from one are detected via base-theme extensions; unknown themes fall through with no changes. The effect mirrors the node form's editorial layout for taxonomy terms, which core does not provide out of the box.

---

- Give the taxonomy term edit page a node-form-style two-column layout with a sidebar.
- Move a term's `path` (URL alias) settings into an "Advanced" sidebar details group.
- Move term `relations` (parent/weight) into the sidebar instead of inline.
- Move `content_translation` options into the sidebar on multilingual sites.
- Show a "Status" meta block on the term form with published state and last-saved time.
- Match the term-edit UX to the node-edit UX for a consistent editorial experience.
- Provide a Gin-themed term form with a sticky actions bar and sidebar toggle.
- Provide a Claro-themed two-column term form with mirrored save actions.
- Keep custom term fields grouped cleanly in the main content region.
- Improve usability of taxonomy vocabularies that have many term fields.
- Support subthemes of Gin/Claro automatically via base-theme detection.
- Declutter the default single-column term form on content-heavy sites.
- Present term metadata separately from editable term fields.
- Offer editors a familiar sidebar for secondary term settings.
- Apply the layout to add-term and edit-term forms alike (delete form excluded).
- Enable the sidebar treatment site-wide simply by enabling the module (zero config).
