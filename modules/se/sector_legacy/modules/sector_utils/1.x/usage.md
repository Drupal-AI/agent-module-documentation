Sector Utilities provides editor-experience and admin-UI tweaks for the Sector distribution: node/media form adjustments under Claro, nicer file-size and MIME-type output, an unpublished-content marker class, and a permission to control the contextual "Configure block" link.

---

Sector Utilities (`sector_utils`) is a hook-only submodule of Sector Legacy that polishes the content-editing experience on Sector sites. Under the Claro admin theme it restructures the node form (`hook_form_node_form_alter`): it moves the publishing status into the meta sidebar group, clones the form action buttons there, and relabels the page content type's status checkbox to "Published". On media delete forms it optionally adds helper text (`sector_utils_track_entity_usage`) showing whether the item is still referenced — this only runs when the `entity_usage` module is enabled. It rewrites `field_filesize` and `field_mimetype` field output into human-readable form (`ByteSizeMarkup` and a `_niceMimeType()` lookup) via `hook_preprocess_field`. It adds an `entity-status-unpublished` CSS class to non-full Display Suite view modes of unpublished entities (`hook_ds_pre_render_alter`). It attaches an admin CSS layer (`css/layout.css`) only when the active admin theme is Claro (`hook_page_attachments`). Finally it defines one permission, `configure blocks from contextual links`, and uses `hook_contextual_links_view_alter` to hide the "Configure block" contextual link from users who lack it. The module has no routes, config objects, or services of its own.

---

- Enable `sector_utils` to apply the Sector distribution's editor-UX polish on Claro-based admin themes.
- Move the node publishing status and action buttons into the meta sidebar group on the node edit form (Claro).
- Relabel the Basic page status checkbox from "Publishing status" to "Published" and drop its description for consistency across content types.
- Show a human-readable file size (e.g. "1.2 MB" instead of raw bytes) for media `field_filesize` fields.
- Display friendly MIME-type labels (PDF, DOCX, XLSX, ZIP, …) for media `field_mimetype` fields.
- Warn editors on the media delete form when the item is still referenced in published content or revisions (requires `entity_usage`).
- Link that warning to the media entity's usage page so editors can review references before deleting.
- Visually flag unpublished content in teaser/other non-full Display Suite view modes via the `entity-status-unpublished` class.
- Give theme CSS a hook to render unpublished entities distinctly for editors.
- Restrict who can open the contextual "Configure block" link by granting the `configure blocks from contextual links` permission only to trusted roles.
- Reduce contextual-menu clutter for editors who manage content but should not reconfigure blocks.
- Load a small admin layout CSS layer automatically, but only under the default Claro admin theme.
- Leave sites using a custom admin theme untouched (the Claro checks skip non-Claro themes).
- Improve the media delete confirmation with clearer, bolded wording about the consequences.
- Enable independently of `admin_ui_toggle` and `sector_blocks` when only the editor-UX tweaks are wanted.
- Pair with Display Suite (`ds`) to get the unpublished view-mode class behavior.
- Serve as a lightweight collection of `hook_*_alter` recipes for a distribution's editorial workflow.
