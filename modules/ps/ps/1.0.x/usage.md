Paragraphs Stats builds a report at Administration → Reports showing how each Paragraph type is used across content types (node, block_content, and nested paragraphs), with drill-down to the specific entities and a CSV export.

---

The module (machine name `ps`) adds a "Paragraphs stats Report" under `/admin/reports/paragraphs-stats-report`. A matrix table lists each Paragraph type against every content-type/entity bundle that can hold it, with usage counts colour-coded into five levels (relative to the min/max counts). An admin first clicks "Update the data structure" (`/update-structure`, gated by `administer paragraphs stats configuration`) which scans all fields whose `target_type` is `paragraph` and records the paragraph/bundle/field structure into the `paragraphs_stats_inuse` table; the report then runs SQL over `paragraphs_item_field_data` (joined to `node_field_data` / `block_content_field_data` / itself) to count real usage. Cells link to a drill-down report (`/drill-down/{contentType}/{paragraph}/{bundle}`) listing the parent entities and edit links, and a per-paragraph usage report (`/drill-down/paragraph/{paragraph}`, a routed `entity:paragraph`). A CSV export (`/export/csv`) serves the same tabular data (link cells become spreadsheet `=HYPERLINK()` formulas). All data-reading routes require `access paragraphs stats report`; both permissions are `restrict access: true`. There is no config UI (`configure` null); the service `ps.service` (`ParagraphsStats`) holds all logic. Requires the Paragraphs module.

---

- See at a glance which Paragraph types are actually used and which are dead weight.
- Audit paragraph usage per content type before removing or refactoring a paragraph type.
- Find every node that uses a given paragraph type via the drill-down report.
- Trace where a specific paragraph entity is embedded (per-paragraph usage report), including nested paragraphs.
- Export the full usage matrix to CSV for a stakeholder spreadsheet.
- Identify heavily-used vs rarely-used paragraphs via the five-level colour coding.
- Support a content model review / information architecture audit.
- Locate content that must be migrated when deprecating a paragraph type.
- Distinguish "not available" (n/a) vs "available but zero uses" (0) per content-type/paragraph pair.
- Give content managers a lens on component reuse across the site.
- Include admin/router pages context indirectly (report focuses on node/block_content/paragraph parents).
- Get edit links to each parent node/block straight from the drill-down table.
- Rebuild the metrics structure after adding new paragraph fields ("Update the data structure").
- Report on paragraphs nested inside other paragraphs (parent_type = paragraph).
- Report on paragraphs used inside custom blocks (block_content).
- Provide a reporting surface without writing a custom View.
- Quantify component adoption after a design-system rollout.
- Spot content types that over-use a single paragraph type.
- Produce a downloadable inventory of paragraph usage for documentation.
