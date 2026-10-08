<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search Replace Aliases (search_replace_aliases) — agent index
**Admin form to preview + batch search-and-replace fragments across URL path aliases.**

- **Version:** 1.0.x
- **Core:** >=10 · **Depends on:** path_alias
- **Route:** `search_replace_aliases.form` → `/admin/config/search/path/replace` (`administer site configuration`)
- **Permission:** `access search replace aliases` (restrict-access) — defined but route uses `administer site configuration`
- **Flow:** preview step → Batch API applies `str_replace` per `PathAlias`

**Security:** Admin-gated, CSRF-protected (`FormBase`). Search term is a bound LIKE placeholder (no SQL injection). Destructive bulk mutation — only a preview, no rollback; scope carefully. No findings beyond the permission/route mismatch note.
