<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BibCite Footnotes Article with Citations (bibcite_footnotes_article_with_citations) — agent index

**Demo / example submodule of [bibcite_footnotes](../../../../agent/start.md).** Config-only (no PHP):
enabling it imports a fully-configured Reference Footnotes setup you can use or copy. Its
`.info.yml` declares `core_version_requirement: ^8 || ^9` (stale relative to the parent's `^10 || ^11`)
and mistypes the parent dependency as `bibcite_footnotees:bibcite_footnotes`.

## Dependencies (from .info.yml)

`bibcite_footnotes` (parent), `bibcite_import`, `bibcite_bibtex`, `bibcite_endnote`, `bibcite_ris`,
`bibcite_marc`, `inline_entity_form`.

## What it installs (`config/install/`)

- **Content type** `node.type.bibcite_fn_article_references` — "Article with References".
- **Fields on that type:** `field_bibcite_fn_works_cited` ("Works Cited") — an `entity_reference`
  field to `bibcite_reference` (all reference bundles as targets, handler `default:bibcite_reference`,
  sorted by title); plus `body`, `field_image`, `field_tags`.
- **Text format** `filter.format.basic_html_with_references` — "Basic HTML with References" with the
  `filter_reference_footnotes` filter enabled (weight -50) plus filter_html (allows `<bibcite-footnote>`
  implicitly via the editor), align, caption, secure image.
- **Editor** `editor.editor.basic_html_with_references` — toolbar includes the `reference_footnotes`
  button.
- **Displays** — `core.entity_form_display.*` (Works Cited uses the `inline_entity_form_complex`
  widget, allow_new + allow_existing) and `core.entity_view_display.*`.

## No routes, services, permissions, plugins, or hooks of its own

All behaviour comes from the parent module; this submodule only provides installable configuration.
See the parent's [plugins/filter.md](../../../../agent/plugins/filter.md) and
[plugins/editor-integration.md](../../../../agent/plugins/editor-integration.md).
