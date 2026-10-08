<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Find External Links — agent orientation

D8.8/9/10 module that scans node fields for external links and reports them.

- Admin routes under `/admin/config/system/find-external-links` (settings form) and `/list` (report), both gated by permission `administer find external links` (restrict access: TRUE).
- Batch (`batch.inc`) parses node field HTML with `DOMDocument`, extracts `<a href>`, and inserts external ones into the `find_external_links` table.
- Report controller (`FindExternalLinksController::displayExternalLinks`) reads the table into a sortable/paged `#type => table` (auto-escaped).
- SECURITY REVIEW NOTE: despite the name, it does NOT perform any server-side HTTP request to the discovered/request-supplied URLs — it only parses stored content. No SSRF. Admin-only. No findings. (Minor logic bug: `if (!$ignore_strings)` inverts the ignore-string check, non-security.)
