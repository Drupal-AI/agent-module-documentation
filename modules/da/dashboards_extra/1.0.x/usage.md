Dashboards Extra ships seven ready-made statistics widgets (Dashboard plugins) that chart aggregate entity counts on a Drupal Dashboards dashboard.

---

The module extends the contrib **Dashboards** module (`dashboards`), which provides the `@Dashboard` plugin type, the dashboard editing UI and the charting `ChartTrait`. Dashboards Extra adds nothing but plugin instances: seven classes under `src/Plugin/Dashboard/`, each annotated with category *"Dashboards: Extras"*. Every widget runs an aggregate entity query (`getAggregateQuery('AND')` with `groupBy` + `aggregate('…','COUNT')`) and hands the resulting label/count rows to `ChartTrait::renderChart()`, so an administrator gets a pie/bar/etc. chart of how many entities exist per bundle or role. Widgets are placed and configured entirely through the Dashboards UI (choose a chart type, pick which bundles to include, and — for content/block/media/vocabulary — whether to count only published entities). Two widgets scope the count to the current user (*My Content Statistics*, *My Block Statistics*). There are no routes, permissions, services, hooks, config schema or Drush commands contributed by this module; it depends solely on `dashboards`, and access is governed by the Dashboards module's own dashboard permissions. Note two shipped classes (`UsersStatistics`, `MediaStatistics`) declare a mismatched `Drupal\dashboard_extra` namespace (singular) — see the agent docs for the practical consequence.

---

- Add a per-content-type node count chart to an admin dashboard (Content Statistics).
- Show published vs. all nodes by picking the *Published Content* checkbox on the Content Statistics widget.
- Display only the content authored by the logged-in user (My Content Statistics).
- Chart how many block_content blocks exist per custom block type (Block Statistics).
- Restrict a block-count chart to blocks whose translation author is the current user (My Block Statistics).
- Visualize media items per media bundle/type (Media Statistics).
- Chart taxonomy term counts per vocabulary (Vocabulary Statistics).
- Show the number of user accounts grouped by role (Users Statistics).
- Give site administrators an at-a-glance content inventory on login via the Dashboards landing page.
- Choose the chart style (pie, bar, etc. — whatever `ChartTrait::getAllowedStyles()` offers) per widget.
- Combine several widgets on one dashboard to build a content-operations overview.
- Track growth of a specific content type by placing a single-bundle Content Statistics widget.
- Compare block-type usage across a site's custom block library.
- Audit which media bundles are actually being used and how heavily.
- Surface taxonomy sprawl by charting term counts across vocabularies.
- Provide editors a personal "how much have I published" widget with the My-* variants.
- Report user distribution across roles for governance/onboarding reviews.
- Filter statistics to the current interface language (content/block/vocabulary widgets group/filter by `langcode`).
- Build role-specific dashboards (via Dashboards' own access) that expose only the statistics widgets relevant to a team.
- Replace hand-built Views count blocks with drop-in configured statistics widgets.
- Seed a new site's admin dashboard with content-health charts without writing custom code.
