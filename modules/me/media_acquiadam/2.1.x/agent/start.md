# Media: Acquia DAM — agent index

Integrates Acquia DAM (Widen) with Drupal Media: an `acquiadam_asset` media source, an Entity Browser
widget (`acquiadam`), OAuth auth (per-user + site-wide token), background asset sync, and — in this 2.x
line — a migration path to the newer **acquia_dam** module. Config UI `/admin/config/media/acquiadam`
(route `media_acquiadam.config`, permission `administer site configuration`). Depends on core media/file/image,
`fallback_formatter`, and `acquia_dam`.

- **Config keys, DAM domain/token auth, sync/transcode settings, CSV update, migration routes** →
  [configure/settings.md](configure/settings.md)
- **Services, media source / entity browser / Linkit plugins, queue workers, auth flow, API client** →
  [api/services-and-plugins.md](api/services-and-plugins.md)
- **Drush commands (sync, CSV update, migration)** → [drush/commands.md](drush/commands.md)

Submodules (own docs):
- `media_acquiadam_example` → [../../modules/media_acquiadam_example/2.1.x/agent/start.md](../../modules/media_acquiadam_example/2.1.x/agent/start.md)
- `media_acquiadam_report` → [../../modules/media_acquiadam_report/2.1.x/agent/start.md](../../modules/media_acquiadam_report/2.1.x/agent/start.md)

Key facts:
- Config object `media_acquiadam.settings`: `domain`, `token` (background), `sync_interval`, `sync_method`,
  `transcode`, `size_limit`, `image_quality`, `image_format`, `sync_perform_delete`, `num_assets_per_page`,
  `report_asset_usage`, `exact_category_search`, `debug`.
- Routes: config + update-assets + migration (perm `administer site configuration`);
  `/user/acquiadam/auth` and `/acquiadam/asset/{assetId}` require only `_user_is_logged_in: TRUE`.
- Plugins: media source `acquiadam_asset`, entity browser widget `acquiadam`, Linkit substitution `dam_asset`;
  queue workers `media_acquiadam_asset_refresh`, `media_acquiadam_integration_link_report`.
- Auth: OAuth authorization-code against Widen; app client_id/secret are constants in
  `AcquiadamAuthService`. Per-user token in `user.data`; site token in config.
- API client base `https://api.widencollective.com/v2`. Drush: `acquiadam:sync|update|migrate|migrate-data|post-migrate`.
- No own permissions; no new plugin types.
