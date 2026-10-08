<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bibliography & Citation - Export lets you export bibcite Reference entities in any registered format (BibTeX, RIS, EndNote, MARC), both as per-reference download links on a citation and as bulk export of selected or all references.

---

The submodule adds export capability on top of `bibcite_entity`, using the `bibcite_format`
plugins to serialize references. A single-reference export route
`/bibcite/export/{bibcite_format}/{entity_type}/{entity}` (controller `ExportController::export`,
permission `access bibcite export`, plus entity `view` access) streams a reference in the chosen
format; the `{bibcite_format}` slug is resolved to a format plugin. It provides two bulk **Action**
plugins over `bibcite_reference` — `bibcite_export_multiple` ("Export reference", used by the
export-multiple confirm form) and `bibcite_export_multiple_vbo` ("Download Selected Citations",
for Views Bulk Operations) — and admin forms to **export all** references
(`/admin/content/bibcite/reference/export`, needs `administer bibcite`+`access bibcite export`) or
**export a selection** (`/admin/content/bibcite/reference/export-action`), writing a file that is
then downloaded via a private-file access-checked download route. It also registers `export:*`
derivatives on the `bibcite_link` plugin list so each enabled format shows as an export link on a
rendered reference. It ships one permission, `access bibcite export`, and the
`system.action.bibcite_export_multiple` action config entity.

---

- Download a single reference as BibTeX / RIS / EndNote / MARC from its citation.
- Bulk-export selected references from the admin listing.
- Export the entire reference library to a file in one action.
- Offer per-format export links on each rendered reference display.
- Let researchers grab a citation in their reference-manager's format.
- Provide a "Download Selected Citations" Views Bulk Operation.
- Restrict who can export with the `access bibcite export` permission.
- Export references to BibTeX for use in LaTeX documents.
- Export to RIS for import into Zotero / Mendeley / EndNote.
- Export to MARC for library catalog systems.
- Build a public "download this citation" affordance on a bibliography page.
- Combine with format submodules to control which export formats are available.
- Generate an export file and serve it through the access-checked download route.
- Export a filtered Views result set of references via VBO.
- Give editors a one-click export-all backup of the bibliography.
- Stream a reference export by hitting the /bibcite/export/{format}/{entity_type}/{id} URL.
- Add export links only for formats whose submodule is enabled.
- Support citation portability between systems using standard formats.
- Let anonymous users (with the permission) export public references.
- Integrate reference export into custom admin workflows via the export actions.
