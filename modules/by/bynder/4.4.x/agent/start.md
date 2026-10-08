# Bynder — agent index

Integrates the Bynder cloud DAM with Drupal core Media: a `bynder` media source, two Entity Browser
widgets (search/upload), field formatters, metadata sync, and usage tracking, all over the
`bynder/bynder-php-sdk` via the `bynder_api` service. Configure at `/admin/config/services/bynder`
(`bynder.configuration_form`). Depends on `media` + `entity_browser`.

- **Admin config: credentials (permanent token / OAuth), account domain, usage restrictions, caching,
  every `bynder.settings` key, permissions, OAuth callback setup** → [configure/settings.md](configure/settings.md)
- **Services: `bynder_api` (SDK wrapper, auth, caching) and `bynder` (metadata/usage), key methods** →
  [api/service.md](api/service.md)
- **Plugins: media source, Entity Browser search/upload widgets, field formatters/type/widget, action,
  queue worker, controllers/routes** → [plugins/media.md](plugins/media.md)
- **Alter hooks (`bynder.api.php`): search query & media-update** → [hooks/hooks.md](hooks/hooks.md)

Submodules (own docs):
- `bynder_select2` (Select2 tag/metaproperty widgets) → [../../modules/bynder_select2/4.4.x/agent/start.md](../../modules/bynder_select2/4.4.x/agent/start.md)
- `bynder_sns` (Amazon SNS push updates) → [../../modules/bynder_sns/4.4.x/agent/start.md](../../modules/bynder_sns/4.4.x/agent/start.md)
- `bynder_usage` (Entity Usage → Bynder usage tracking) → [../../modules/bynder_usage/4.4.x/agent/start.md](../../modules/bynder_usage/4.4.x/agent/start.md)
- `bynder_demo` (demo content/config) and `bynder_lightning` (Lightning distro config) are non-code
  packages requiring absent deps (dropzonejs / lightning) — not separately documented.

Key facts:
- Media source `bynder`, source field types `string`/`string_long`; a metadata field
  (`BynderMetadataItem::METADATA_FIELD_NAME`) and `bynder_transformations` field are auto-created on new
  Bynder media types (`bynder_media_type_insert`).
- Auth: permanent token (global) OR OAuth2 (session-stored `AccessToken`); OAuth callback route
  `bynder.oauth` = `/bynder-oauth`.
- Caching: metaproperties/derivatives/tags cached (`cache_lifetime`, default 86400s), refreshed by
  `bynder_cron()` and on connect.
- Permissions: `administer bynder configuration` (restricted), `view bynder media usage`.
