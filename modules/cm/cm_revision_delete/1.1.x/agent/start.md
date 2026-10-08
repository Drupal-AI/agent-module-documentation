<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Agent orientation: cm_revision_delete

**What:** Prunes old node revisions, respecting Content Moderation default/latest states.

**Key files:**
- `src/Form/AdminSettingsForm.php` — retention settings.
- `src/Form/DevelForm.php` — developer/testing form.
- `cm_revision_delete.routing.yml` / `.permissions.yml` — both routes gated by `administer cm_revision_delete`, `_admin_route: TRUE`.

**Deps:** `node`, `content_moderation`.

**Security:** admin-permission-gated FormBase forms (CSRF tokens apply); no anonymous routes. Deletes only revisions, never current published content.
