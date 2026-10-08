A submodule that reports where Acquia DAM assets are used across the site, built on Entity Usage and a Views-based usage report under the Media admin listing.

---

`media_acquiadam_report` adds an "Acquia DAM Usage" report (Views view `acquia_dam_reporting`, display
`asset_report`) as a local task beside the Media collection (`/admin/content/media`). A
`hook_views_query_alter()` limits that view to DAM media bundles (resolved via
`media_acquiadam_get_bundle_asset_id_fields()`), and a `hook_views_data_alter()` exposes an
`acquiadam_source_id` Views field showing each asset's DAM source id from the configured mapping. An
`AcquiadamUsageSubscriber` listens to Entity Usage `USAGE_REGISTER` events to keep DAM asset usage data
current, and a `RouteSubscriber` wires the report route. It requires `entity_usage` and `views`, plus the
parent `media_acquiadam`. No settings page, permissions, or Drush of its own — reporting relies on Views and
core Media permissions.

---

- See which content references each Acquia DAM asset (usage report).
- Audit DAM asset usage from a Views report under the Media admin listing.
- Add an "Acquia DAM Usage" local task tab to `/admin/content/media`.
- Filter the media usage report to DAM-sourced media bundles only.
- Expose each asset's DAM `source id` as a Views field for reporting.
- Track asset usage automatically via Entity Usage `USAGE_REGISTER` events.
- Identify orphaned or unused DAM assets before cleanup.
- Support content governance by showing where licensed DAM assets appear.
- Feed DAM usage back to Acquia DAM (with the parent module's usage reporting).
- Customize the report by cloning/editing the `acquia_dam_reporting` view.
- Combine with `media_acquiadam_example` for a complete DAM demo setup.
- Provide editors a single place to check asset reuse across the site.
- Report on all DAM media types (asset, audio, document, image, video) together.
- Use standard Views tooling (filters, exports) on top of the DAM usage data.
- Keep usage data fresh as entities are created/updated without manual recalculation.
