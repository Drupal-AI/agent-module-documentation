<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Markdown Index (markdown_index) — agent index

**Admin report that indexes `.md` files across root/contrib/custom/vendor and displays a chosen file's contents.**

- **Version:** 1.0.x
- **Core:** `^9 || ^10`
- **Routes:** `markdown_index.settings_form` → `/admin/config/system/markdown-index` (perm: `administer markdown_index configuration`, restricted); `markdown_index.report` → `/admin/reports/markdown-index` (perm: `access markdown_index report`, restricted)
- **Config:** `markdown_index.settings` (`files_root/contrib/custom/vendor` booleans).
- **Service:** `markdown_index.service` (`MarkdownIndexService`: `rsearch()`, `getPath()`).

**Security:** both routes require restricted-access admin permissions. The displayed file is selected by an integer index into the discovered list (no raw path → no traversal); scannable roots are fixed. The report intentionally exposes on-disk file contents to `access markdown_index report` holders (via `<pre>` `#markup`, admin-filtered) — grant only to trusted roles. See [configure/markdown-index.md](configure/markdown-index.md).
