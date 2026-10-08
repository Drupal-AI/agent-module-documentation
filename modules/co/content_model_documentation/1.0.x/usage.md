<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Model Documentation turns a site's architecture into browsable admin reports and Mermaid diagrams, and adds a `cm_document` content entity for recording *why* each part of the model exists — kept next to the generated view of what it actually is.

---

The module has two halves. The generated half reads the live site — content types, block/paragraph/media types, vocabularies, fields, entity references, workflow states — and renders them as sortable report tables (with CSV download), a filterable Content Model Fields view, a faceted field search, entity-relationship diagrams, and workflow state/transition diagrams under `/admin/reports/content-model` and `/admin/reports/system`. It leans on `config_views` to expose configuration entities to Views, Better Exposed Filters for the filtering UI, `views_data_export` for downloads, and `mermaid_diagram_field` to draw the diagrams. The authored half is the `cm_document` entity: one revisionable, publishable document per content type, field, module, view, vocabulary, menu, block or paragraph type, holding the freeform rationale that introspection cannot recover. A settings form at `/admin/config/system/cm_document` picks which entity types are documentable and names a local module to house exported documents; two Drush commands (`cm-doc-export`/`cm-doc-import`) plus static movers callable from `hook_update_N` let those documents ride along with code between environments. Permissions are granular and the document entity uses a proper access-control handler. Core requirement is `^10 || ^11`; note the six-module dependency footprint (four contrib).

---

- Document why each content type exists, not just that it does.
- Hand a site's architecture to a new team at project handover.
- Draw a Mermaid entity-relationship diagram for a bundle and its references.
- Diagram a content-moderation workflow's states and transitions.
- Download a report of node/block/paragraph/vocabulary counts as CSV.
- Browse every field on the site in one filterable list.
- Search fields by type, description, or setting across all bundles.
- Inspect a single field's full definition in an off-canvas panel.
- Record the rationale behind a field nobody dares delete.
- List all enabled modules with links to their project and help pages.
- Break down user counts by role.
- Export a Content Model Document to YAML with Drush and commit it.
- Import documentation on deploy via a hook_update_N call.
- Keep architecture notes versioned in git alongside code.
- Give auditors a read-only view of the data model.
- Add a "Documentation" tab to content-type and vocabulary manage pages.
- Attach rationale to a migration's structural decisions.
- Reduce onboarding time for new developers.
- Publish selected documentation to a stakeholder role while hiding drafts.
- Track how the model changed over time via document revisions.
- Explain a legacy bundle kept only for backwards compatibility.
- Customise the Content Model Fields view in Views UI.
- Control which entity types can be documented from one settings form.
- Visualise how paragraphs and media reference each other.
- Justify a refactor with documented history.
