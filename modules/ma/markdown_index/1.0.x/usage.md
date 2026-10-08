<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Markdown Index adds an admin report that lists the Markdown (`.md`) files across the site's folders and displays a selected file's contents.
---
Two permission-gated routes drive the module. The settings form (`/admin/config/system/markdown-index`, permission `administer markdown_index configuration`, marked `restrict access: true`) toggles which roots are scanned: project root, `modules/contrib`, `modules/custom` and `vendor` (each stored as a boolean in `markdown_index.settings`). The report (`/admin/reports/markdown-index`, permission `access markdown_index report`, also `restrict access: true`) uses `MarkdownIndexService` to recursively find `*.md` files in the enabled folders (`RecursiveDirectoryIterator` + `RegexIterator`), lists them in a select, and — when a `file_index` is chosen — reads that file with `file_get_contents()` and renders it inside a `<pre>` block via `#markup` (admin-filtered).

Both routes are restricted-access admin permissions, so the feature is for trusted maintainers reviewing documentation. The file to display is chosen by an integer index into the discovered file list (not a raw path), so a caller cannot request an arbitrary path via traversal; the scannable folders are fixed to root/contrib/custom/vendor. Be aware the report deliberately exposes on-disk file contents (READMEs, and if enabled, vendor docs) to holders of `access markdown_index report` — grant it only to trusted roles.

Setup: enable the module, open the settings form to pick which folders to include, then read the report under Reports.
---
- Index all Markdown files in the project for quick reference.
- Browse `.md` files under `modules/contrib`.
- Include `modules/custom` READMEs in the index.
- Include project-root `.md` files.
- Optionally scan `vendor` documentation.
- Read a selected Markdown file's raw contents in the browser.
- Give maintainers a one-stop docs viewer under Reports.
- Toggle which folders are scanned on the settings form.
- Restrict the report to trusted roles (`access markdown_index report`).
- Restrict configuration with `administer markdown_index configuration`.
- Quickly locate a module's README without shell access.
- Review contrib module documentation from the admin UI.
- Audit which modules ship Markdown docs.
- Provide an internal documentation index for a team.
- Keep the scan scoped to fixed, known folders.
- Select a file from a sorted dropdown to view it.
- Use as a lightweight docs reference tool.
- Avoid exposing docs by leaving the report permission unassigned.
