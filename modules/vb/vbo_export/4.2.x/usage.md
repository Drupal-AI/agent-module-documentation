<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VBO Export adds four Views Bulk Operations actions that turn the fields of selected view rows into a downloadable CSV, XLSX, PDF, or DOCX file.

---

The module registers four VBO action plugins (`vbo_export_generate_{csv,xlsx,pdf,doc}_action`) that consume the Views Bulk Operations framework rather than defining a plugin type of their own. Each action reads the rendered value of every visible field on the view for the selected rows, builds a header from the field labels, and writes a temporary file to a chosen stream wrapper, then messages the operator a download link. Actions are enabled and configured per view in the VBO field's "Selected actions" settings, where a preliminary config form exposes the destination file scheme, an HTML-tag-stripping toggle, and a per-field override table (choose which fields are included and relabel them). CSV adds a separator choice; PDF adds paper size and orientation and renders through a Twig template (`vbo_export_pdf`) via Dompdf. XLSX (PhpSpreadsheet) applies auto-filter, bold header, wrapped text, and min/max column widths; DOCX uses PhpWord with each field printed as a bold label plus value. Row data is streamed through the private tempstore in batches so large selections do not exhaust memory, and the file is generated only after the last batch. Access is delegated to `view` access on each entity, so the actions expose nothing an operator could not already read through the view. The XLSX, PDF, and DOCX libraries are optional at runtime: missing ones produce a warning on the status report and an error message instead of a file.

---

- Export selected nodes from an admin content view to CSV for spreadsheet analysis.
- Produce an XLSX report of filtered content with auto-filter and bold headers for stakeholders.
- Generate a print-ready PDF listing of selected view rows.
- Create a DOCX document from selected content for editorial or offline review.
- Let editors download a subset of nodes (multi-selected) rather than the whole view.
- Export a customer or member list built as a view to CSV for a mailing tool.
- Give non-technical staff a one-click "download as Excel" action on any view.
- Export event registrations or form submissions surfaced through a view.
- Relabel and reorder exported columns per view using the field-override table.
- Strip HTML tags from rendered field markup to get clean plain-text cell values.
- Choose a CSV separator (semicolon, comma, or pipe) to match a target import format.
- Emit a UTF-8 BOM CSV so Excel opens accented/non-Latin characters correctly.
- Export taxonomy terms or users (any entity a view lists) to a file.
- Save export files to a private stream so downloads respect file access control.
- Save export files to public storage for shareable links.
- Produce landscape or portrait PDFs sized letter/A4/etc. for different print needs.
- Export multilingual content, matching each selected row to its langcode.
- Bulk-export search or faceted results captured in a view.
- Provide an ad-hoc data extract without building a custom export module.
- Hand off a CSV/XLSX snapshot of content to an external analytics or BI pipeline.
- Archive a point-in-time copy of selected records as a document.
- Override the default field set to export only a few columns from a wide view.
- Extend `VboExportBase` to add a custom export format (e.g. JSON) by implementing `generateOutput()`.
- Customize PDF layout by overriding the `vbo-export-pdf.html.twig` template in a theme.
