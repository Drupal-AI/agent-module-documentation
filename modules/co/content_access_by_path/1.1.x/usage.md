<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Access by Path confines an editor to the parts of a site whose URL aliases begin with a configured path, so a news team edits `/news/…` and nothing else.

---

Delegating editing by section is one of the most common requirements on a large site and one Drupal has no native answer for: permissions are per content type and per ownership, and neither expresses "this team owns this branch of the site". The usual workarounds are a content type per section, which distorts the content model, or Organic Groups, which is a large piece of machinery for a simple rule. Keying on the path alias is a neat idea, because the alias is already the site's structure. The implementation uses **`hook_node_access()` and `hook_entity_field_access()`** — Drupal's entity access layer, so update/delete decisions apply to the edit form and to JSON:API/REST writes, not only to the rendered page. Version **1.1.3** on core `^10 || ^11`. An editor's allowed sections are stored as a multi-value taxonomy field on their user account; a user with no sections set is unaffected and keeps whatever access Drupal would otherwise give. As a matter of design the module also always lets an editor edit content they authored, so that a wrong alias never locks an author out of their own node — factor that into how you scope roles. The optional `content_access_by_path_admin_content` submodule additionally filters the `/admin/content` listing to the sections a user may edit.

---

- Confine a news team to /news.
- Delegate a section to a department.
- Restrict editing by URL branch.
- Give a team ownership of a site area.
- Avoid a content type per section.
- Delegate editing without Organic Groups.
- Restrict a microsite's editors.
- Scope editing to a directory.
- Support a devolved editorial model.
- Restrict a campaign team's reach.
- Delegate a policy section.
- Limit editors to their department's pages.
- Scope access by path prefix.
- Support a large site's editorial teams.
- Restrict a language section's editors.
- Delegate a product area.
- Limit editing to a documentation branch.
- Support section-based content ownership.
