<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Agent orientation: cna

**What:** Emails a node's author on comment insert/update.

**Key files:**
- `cna.module` — `hook_comment_insert`/`update`, `cna_mail`, `_cna_send_mail`.
- `src/Form/CNAConfig.php` — two toggles (`cna_new`, `cna_update`).

**Config:** `cna.settings` at `/admin/config/system/cna`. **Permission:** `administer cna configuration`.

**Deps:** `comment`. **Security:** admin-only config route; sends only to the node owner's validated email. No anonymous endpoints.
