Layout Builder Usage Reports adds an admin report listing every node that overrides its Layout Builder layout, together with the inline blocks, block types, paragraph components and paragraph types placed in those layouts, with filters.

---

The module provides a single administrative report at `/admin/reports/layout/usage` (route
`layout_builder_usage_reports.report_form`, permission `access node layout reports`, restricted).
`ReportForm` queries the `node__layout_builder__layout` field table, joins `node_field_data` for the
title/language, and `unserialize()`s each stored layout section (with an `allowed_classes` whitelist
of the Layout Builder Section/SectionComponent and Drupal markup classes) to read its components.
For each component it derives the plugin ID and classifies it: IDs starting `inline_block:` yield a
**block type**, IDs starting `component:` yield a **paragraph type** (this relies on the Layout
Paragraphs style `component:<type>` plugin IDs). The result is a table of node ID, title (linked),
bundle, language, plugin ID, label and provider. Above it, a filter fieldset lets you narrow by node
bundle, provider, language, block type and paragraph type; the selected filters are persisted in the
Drupal **State** API (`lbur_*` keys), and a Reset button clears them. When no filter is set the query
is capped at 500 rows for performance. There is no other configuration, no config schema, and no code
API — it is a read-only reporting tool for auditing Layout Builder usage across nodes.

---

- Find every node that has an overridden Layout Builder layout.
- Audit which inline block types are actually used in layouts across the site.
- See which paragraph component types appear in Layout Builder sections.
- Identify the provider module supplying each placed component.
- Filter layout usage by node bundle (content type).
- Filter layout usage by language for multilingual sites.
- Filter by a specific inline block type to find where it's used.
- Filter by a specific paragraph type to find its placements.
- Filter by provider to see all components from a given module.
- Plan a refactor by locating nodes still using a deprecated block/paragraph type.
- Assess Layout Builder adoption before a migration or redesign.
- Spot orphaned or rarely used component types worth removing.
- Jump directly to any listed node via its linked title.
- Get a quick count of layout-using nodes/components ("N results shown").
- Support content governance by inventorying custom layouts.
- Verify cleanup after deleting a block type or paragraph type.
- Give site builders visibility into where inline blocks live.
- Review Layout Builder usage as part of a site audit or handover.
- Persist a chosen filter set across page loads while investigating.
- Cap large-site reports at 500 rows when browsing unfiltered.
