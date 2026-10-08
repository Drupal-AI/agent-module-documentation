<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VBO Export — agent index

Provides four **Views Bulk Operations actions** that export selected view rows to CSV, XLSX, PDF, or DOCX.
Requires core `file` + `views_bulk_operations` (>=3.5); XLSX/PDF/DOCX need optional PHP libs. Version **4.2.0**, core `^9.3 || ^10 || ^11`. No admin route, no permissions of its own.

- Export actions (CSV/XLSX/PDF/DOCX), their per-view config, access model, and how to extend with a new format → [agent/plugins/actions.md](plugins/actions.md)
