<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Markdown Index — configuration & report

## Settings form
`/admin/config/system/markdown-index` (`markdown_index.settings_form`, permission `administer markdown_index configuration`, `restrict access: true`). `MarkdownIndexAdminSettingsForm` toggles four booleans in `markdown_index.settings`:
- `files_root` — project root `.md` files (root is one level up from docroot).
- `files_contrib` — `<docroot>/modules/contrib`.
- `files_custom` — `<docroot>/modules/custom`.
- `files_vendor` — `<docroot>/../vendor` (off by default).

Each checkbox description shows the resolved path from `MarkdownIndexService::getPath()`.

## Report
`/admin/reports/markdown-index` (`markdown_index.report`, permission `access markdown_index report`, `restrict access: true`). `MarkdownIndexSelectForm`:
- Builds the file list with `MarkdownIndexService::rsearch()` (`RecursiveDirectoryIterator` + `RegexIterator` on `/.*\.md/`) for each enabled folder; root files use a `glob('../*.md')`.
- Renders a sorted select; picking an option submits `file_index` (an integer index).
- With a `file_index`, reads `file_get_contents($list[$file_index - 1])` and shows it inside `<pre>` via `#markup`.

## Security notes
- File selection is by numeric index into the discovered array — not a caller-supplied path — so there is no path-traversal parameter; folders scanned are fixed to root/contrib/custom/vendor.
- The report exposes file contents to anyone with `access markdown_index report` (a restricted permission). Assign it only to trusted maintainers, and leave `files_vendor` off unless needed.
