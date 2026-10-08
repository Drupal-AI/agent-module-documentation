<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Import bulk-creates (or updates) nodes of any content type from an uploaded CSV file, mapping each CSV column to a field on the chosen content type via a simple admin form.

---

The module adds one admin form at *Configuration › Content authoring › Content Import*
(`/admin/config/content/contentimport`, route `contentimport.admin_settings`, gated by the core
`administer site configuration` permission). You pick a target content type, an import type —
**Create new content** or **Update existing content** — and upload a `.csv`; a batch then runs
`contentimport_import_node()` to create/update one node per row. The CSV's first row must hold
the destination **field machine names**; every CSV needs a `title` and a `langcode` column
(missing langcode defaults to `en`), and Update mode additionally requires a `nodeid` column to
locate the node. The importer inspects the content type's field definitions and converts each
cell according to the field **type**: images are matched from `public://<content_type>/images/`,
entity-reference values map to taxonomy terms (auto-creating vocabularies/terms), users
(by email/name, auto-creating users), or nodes (by title); text fields are stored as
`full_html`; datetime, timestamp, boolean, list_string, geolocation and geofield each have their
own parsing rules. The form can generate a **sample CSV** (header only) for the selected content
type, and each run writes a human-readable log to `sites/default/files/contentimportlog.txt`.
It provides no Drush commands, no plugins, and no real configuration of its own (it depends only
on `node`), and needs write access to `sites/default/files/` for the log/sample files.

---

- Bulk-create hundreds of Article nodes from a spreadsheet exported to CSV.
- Import a product/catalog content type from a supplier CSV.
- Update existing nodes in place by including their `nodeid` and choosing "Update existing content".
- Migrate simple content from another system via a CSV export.
- Populate a new content type quickly for a demo or QA environment.
- Download a header-only sample CSV for a content type to see exactly which columns it expects.
- Auto-create taxonomy terms while importing by putting `Vocabulary: term1, term2` in a reference column.
- Import multi-vocabulary term references using the `vocabulary:term` delimiter form.
- Attach images to imported nodes by placing files in `public://<content_type>/images/` and naming them in an image column.
- Reference users on imported nodes by email, auto-creating missing user accounts.
- Reference other nodes by title using a colon-separated list in a node-reference column.
- Set the author of imported nodes via an `author` column (username).
- Import boolean fields using On/Yes/on/yes (checked) or Off/No (unchecked).
- Import date fields using `m/d/Y` (date only) or `m/d/Y H:i:s` (date + time).
- Import timestamp fields directly as epoch values.
- Import single- or multi-value geolocation/geofield coordinates (`lat,long` separated by `;`).
- Import List (text) values as comma-separated options.
- Seed a translation baseline by specifying `langcode` per row.
- Give non-developers a UI to load content without touching Migrate.
- Re-run an import to update a batch of nodes after editing the source CSV.
- Check the import log at `sites/default/files/contentimportlog.txt` to see which fields matched.
- Load body/rich-text content into `text_long`/`text_with_summary` fields as full HTML.
- Populate a staging site's content from a single CSV per content type.
- Create the vocabulary and terms on the fly for a taxonomy-driven content type during import.
