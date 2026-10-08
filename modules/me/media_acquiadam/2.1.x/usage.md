Media: Acquia DAM integrates Acquia DAM (Widen) with Drupal's Media ecosystem — providing an `acquiadam_asset` media source, an asset browser, per-user and site-wide OAuth authentication, background asset syncing, and (in the 2.x line) tooling to migrate to the newer `acquia_dam` module.

---

The module defines a media source plugin `acquiadam_asset` so DAM assets become Media entities, an Entity
Browser widget (`acquiadam`) and asset-details pages for browsing/selecting assets, and a Linkit
substitution (`dam_asset`) for deep-linking. Authentication is OAuth against Widen: the module's built-in app
client_id/secret drives an authorization-code flow; individual editors link their Drupal account to a DAM
account (token stored in `user.data` under `media_acquiadam`), while an optional site-wide "background" token
in config is used for cron/CLI sync. The `Client` service talks to `https://api.widencollective.com/v2`;
helper services download asset binaries, map DAM metadata to media fields, refresh assets on a queue
(`media_acquiadam_asset_refresh`), and report integration-link usage. Admins configure the DAM domain, tokens,
sync interval/method, transcode/size/format and reporting options at `/admin/config/media/acquiadam`
(permission `administer site configuration`), and can bulk-update asset references from a CSV. This 2.x
release depends on the newer **acquia_dam** module and adds a migration workflow (controllers, forms, and
Drush commands `acquiadam:migrate*`) to move existing Media: Acquia DAM sites onto acquia_dam. Two submodules
ship alongside: `media_acquiadam_example` (example media types + field/display config) and
`media_acquiadam_report` (a Views-based DAM asset usage report). Drush commands cover sync, CSV update, and
the migration steps. No permissions of its own beyond core's `administer site configuration`.

---

- Use Acquia DAM (Widen) assets as Drupal Media entities via the `acquiadam_asset` media source.
- Let content editors browse and pick DAM assets through the Acquia DAM Entity Browser widget.
- Authenticate each editor's Drupal account to their DAM account with an OAuth authorization-code flow.
- Use a site-wide background DAM token for unattended cron/CLI asset syncing.
- Configure the DAM domain, sync interval and sync method (updated-date based) for asset refresh.
- Download and cache DAM asset binaries locally as managed files with mapped metadata.
- Map DAM asset metadata (name, description, etc.) onto media-type fields.
- Choose transcode/download options (original vs derivative), size limit, image quality and format.
- Refresh assets in the background via the `media_acquiadam_asset_refresh` queue worker.
- Run a full or incremental asset sync from Drush (`acquiadam:sync`).
- Bulk-update stored asset references from a CSV file (`acquiadam:update` / Update Assets Reference form).
- Deep-link to DAM assets in body text using the Linkit `dam_asset` substitution.
- View a per-asset details page at `/acquiadam/asset/{assetId}` for authenticated users.
- Optionally delete Drupal media when the corresponding DAM asset is removed (sync delete).
- Report DAM asset usage across the site with the reporting submodule's Views report.
- Track integration-link usage back to DAM via the report queue worker.
- Bootstrap a working setup with the example submodule's media types, fields and displays.
- Migrate an existing Media: Acquia DAM site to the newer `acquia_dam` module (guided forms + Drush).
- Run migration steps from the CLI: `acquiadam:migrate`, `acquiadam:migrate-data`, `acquiadam:post-migrate`.
- Limit the number of assets shown per page in the asset browser.
- Toggle exact vs fuzzy DAM category search.
- Clean up asset-reference fields left over from removed media types (FieldCleanupService).
