<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Preview (project `all_entity_preview`, machine name `preview`) brings core Node's "Preview before saving" feature to **any** content entity type and bundle, letting editors preview an unsaved entity in a chosen view mode and switch view modes on the preview page before returning to the edit form.

---

Modelled on core's node preview, the module adds a **Preview** button to the entity edit form of any
entity type/bundle you enable at *Configuration › Content › Entity preview* (`preview.settings`,
gated by `administer site configuration`). Enabled bundles are stored in config as
`enabled[<entity_type>][<bundle>] = <default_view_mode>`. Clicking Preview stashes the in-progress
`$form_state` in the **per-user private tempstore** keyed by the entity UUID and redirects to
`/preview/{entity_preview}/{view_mode_id}`; a param converter (`entity_preview`) rehydrates the
unsaved entity from that private tempstore, and `PreviewController` (extending core
`EntityViewController`) renders it uncached. A `PreviewForm` on the preview page lets the editor
switch view modes, and `hook_page_top()` adds a "Back to content editing" link (whose URL other
modules can alter via the `preview.back_link` event). Access to the preview page is enforced by the
`_entity_preview_access` check: it requires the current user's **create** access (new entities) or
**update** access (existing entities) on the entity — combined with the private, per-user tempstore,
an editor can only preview entities they are already permitted to create/edit, and cannot load
another user's staged preview. On save, the tempstore entry is cleaned up.

---

- Preview an unsaved node, taxonomy term, media item, or custom entity before saving.
- Enable preview for a specific content entity type and bundle.
- Set the default view mode used when previewing each bundle.
- Switch between view modes on the preview page to check different displays.
- Give non-node content the same preview UX editors expect from nodes.
- Return to the edit form from preview via the "Back to content editing" link.
- Preview how an entity looks in a "full" vs "teaser" view mode.
- Let editors verify layout/field rendering before publishing.
- Preview media entities in their configured display before saving.
- Preview taxonomy term pages before committing changes.
- Preview commerce/product or other custom entities pre-save.
- Alter the preview back-link destination via the `preview.back_link` event.
- Restrict preview to trusted content types by only enabling selected bundles.
- Keep preview data private per user via the private tempstore.
- Avoid caching stale previews (the controller strips cache metadata).
- Reduce publish-then-fix cycles by checking rendering up front.
- Preview unpublished/draft entities the editor can already edit.
- Provide preview without granting extra permissions (uses create/update access).
- Standardize preview behavior across all entity types on a site.
- Support editorial review workflows with a consistent preview step.
