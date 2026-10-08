# Taxonomy Term Sidebar — agent index

Single-purpose UX module: reshapes the taxonomy term add/edit form into the core node-form-style
two-column "main + advanced sidebar" layout. Pure `hook_form_alter`; no config UI (`configure` null),
no permissions, no routes, no services, no schema, no dependencies. Enable it and it works.

- **What the form_alter does, the regions/groups it builds, and Gin/Claro theme handling** →
  [theming/layout.md](theming/layout.md)

Key facts:
- `term_sidebar_form_alter` acts only on `taxonomy_term` entity forms (skips form mode `delete`).
- Moves all term fields into a `main` region; moves `path`, `relations`, `content_translation` and a
  built "Status" meta block into an `advanced` sidebar region; adds a `footer` region.
- Theme-specific branches for `claro` and `gin` (subthemes detected via base-theme extensions);
  attaches `claro/node-form`, `claro/form-two-columns`, `gin/edit_form`, `gin/sidebar` as appropriate.
- `hook_module_implements_alter` reorders its `form_alter` to run last; `hook_preprocess_html` adds a
  `gin--edit-form` body class on term add/edit routes under Gin.
