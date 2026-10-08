<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Documentation generator assembles a user guide describing the site's structure and configuration and exports it to HTML, Word (.docx) or PDF.

---

Documentation generator collects information about how a Drupal site is built — content types
and their fields, block content types, menus (and where each menu block is placed), paragraph
types, taxonomy vocabularies, user roles, views and enabled modules — and combines it into a
single reference "user guide". Each area is contributed by a pluggable *chapter* plugin, and the
compiled result is emitted by a pluggable *render* plugin: an on-screen HTML overview table, or a
downloadable Word (`.docx`) or PDF file written to the private files directory. Administrators pick
which chapter plugins are active and can hide individual elements, all from admin forms under
`/admin/config/documentation-generator`. Every route is gated by the module's own
`administer documentation generator` permission. It ships two render targets (Word, PDF, via the
`phpoffice/phpword` and `dompdf/dompdf` libraries) and a sample chapter plugin developers can copy
to document additional areas. There is no settings form to fill in before use — enable it, grant
the permission, and generate.

---

- Auto-generate a written user guide for a Drupal site.
- Produce a reference of the site's content architecture for onboarding a new team member.
- Create a handover/maintenance document capturing how the site is configured.
- List all content types and their fields on one page.
- Document block content types.
- Document menus and note which region each menu block sits in and its visibility rules.
- Document paragraph types and their fields.
- Document taxonomy vocabularies.
- Document user roles.
- Document configured views.
- Document the list of enabled modules with their descriptions.
- View the compiled documentation as an on-screen HTML overview table.
- Export the documentation to a Word `.docx` file.
- Export the documentation to a PDF file.
- Choose which chapter plugins are included in the output.
- Hide specific elements (e.g. a particular content type) from the generated documentation.
- Extend the output with a custom chapter plugin based on the shipped sample.
- Add a new export format by writing a custom render plugin.
- Restrict all generation and export to a dedicated admin permission.
- Store the exported guide with a project's handover records.
- Regenerate the guide after configuration changes to keep the reference current.
