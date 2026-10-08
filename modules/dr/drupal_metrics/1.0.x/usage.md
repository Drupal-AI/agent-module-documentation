<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drupal Metrics adds a read-only report under **Reports > Metrics** that shows database table sizes (plus the total database footprint) and a structural overview of every content entity type, its bundles and their fields.

---

The module ships one controller (`MetricsController`) with four routes, all under `/admin/reports/metrics` and all gated by a single custom permission `view metrics`. The **Database** page (`metricsPage()`) queries `information_schema.tables` for the current database, computes each table's size as `data_length + index_length`, renders a sortable table of table names and human-readable sizes (`ByteSizeMarkup`), and prints the summed total. The **Entities** page (`entityOverview()`) walks `entityTypeManager()->getDefinitions()`, keeps content entity types, and lists each with its bundle count (linking to a per-entity-type drill-down). Drilling into an entity type (`entityBundles()`) lists each bundle with its base-field and additional-field counts, and drilling into a bundle (`bundleFields()`) shows entity count, translation count, base fields and configurable fields with their labels, types and cardinality. Entity/bundle/field counts are read with `accessCheck(FALSE)`, so they are raw totals regardless of the viewing user's content access. There is no settings form, no config, no config schema, no Drush command, no dependency beyond Drupal core; the report is registered on the core Reports menu with **Database** and **Entities** local-task tabs and styled by one CSS library (`drupal_metrics/drupal_metrics.styles`). Because it exposes schema names and aggregate counts, the `view metrics` permission is administrative operational data — grant it only to trusted roles.

---

- See the total on-disk size of the site's database at a glance to track growth over time.
- Identify the largest database tables (by data + index length) that may need optimization or archiving.
- Spot runaway tables (e.g. `cache_*`, `watchdog`, `queue`, revision or log tables) bloating the database.
- Give a non-technical stakeholder a plain view of how big the site's data has become.
- Sort tables by size (descending by default) to prioritize cleanup work.
- Audit which content entity types exist on a site you have inherited.
- Count how many bundles each content entity type has (e.g. number of node content types, media types, taxonomy vocabularies).
- Drill into a single entity type to see each bundle's base-field vs additional (configurable) field counts.
- Review a bundle's exact field list — machine name, label, type and cardinality — without opening Field UI page by page.
- Distinguish base (code-defined) fields from configurable (Field UI) fields on a bundle.
- See how many entities exist in a specific bundle (e.g. number of Article nodes) as a raw count.
- Check translation coverage for a bundle via its translation count on translatable entity types.
- Plan a content-migration or audit by mapping out entity types, bundles and fields quickly.
- Support capacity planning and hosting/database sizing decisions with concrete table-size numbers.
- Detect unexpectedly large tables after installing or misconfiguring a contrib module.
- Provide a lightweight, dependency-free alternative to opening a DB client just to check table sizes.
- Document a site's data model for onboarding new developers.
- Verify that a field or bundle you expected to exist is actually present.
- Confirm field cardinality (single vs unlimited) for a bundle before building views or exports.
- Keep an eye on database size on staging vs production environments.
