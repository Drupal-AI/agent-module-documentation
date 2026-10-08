<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Term (entity_term) — agent index

**Maintains a 1:1 sync between an entity bundle and a taxonomy vocabulary (create/rename/delete terms by label), locks the term name in UI, and redirects term URLs to the source entity.**

- **Version:** 2.0.x  •  core: `^8 || ^9 || ^10`  •  configure: `entity_term.settings`  •  depends on `taxonomy`  •  permission `administer_entity_term`.
- **Sync:** `hook_entity_insert/presave/delete` → `entity_term_manager()` creates/renames/deletes term matching `$entity->label()` in the mapped vocabulary.
- **UI lock:** `hook_form_alter` disables name field, hides delete, adds `entity_term_edit_validate` on synced term forms.
- **Redirect/rewrite:** `TermViewSubscriber` (response) redirects term canonical → entity URL; `TaxonomyPathProcessor` (outbound) + `hook_link_alter` rewrite term links to entity URL. Lookups use `accessCheck(FALSE)`.

**Security (reviewed, sound):** the `accessCheck(FALSE)` label lookups only build a redirect/link to the entity's OWN canonical URL, where entity access is enforced; no protected content is rendered. Config form gated by a dedicated permission. No finding.
