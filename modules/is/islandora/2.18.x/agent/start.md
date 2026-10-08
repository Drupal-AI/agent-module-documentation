# Islandora Core — agent index

Foundation of the Islandora digital-repository framework on Drupal. Objects = nodes linked by
`field_member_of`, typed by `field_model`; binaries = media tagged by `field_media_use`. Behavior is
**Context-driven**: Conditions + Reactions fire Actions that emit STOMP/AMQP events to microservices and
index to Search API, with JSON-LD/RDF output and optional Fedora sync. Configure at
`/admin/config/islandora/core` (`system.islandora_settings`). Large dependency set (context, ctools, media,
jwt, jsonld, flysystem, search_api, eva, filehash, migrate_*…).

- **Core settings form (broker, JWT, Fedora URL, upload location/mimetypes, header links), RDF report** →
  [configure/settings.md](configure/settings.md)
- **The Context integration: Conditions, Context Reactions, and Actions (emit events / generate
  derivatives / index / delete) — Islandora's automation engine** → [plugins/context.md](plugins/context.md)
- **Services & code API (`islandora.utils`, MediaSourceService, EventGenerator) + the media/REST routes** →
  [api/services.md](api/services.md)
- **Permissions (`view checksums`, `manage members`, `manage media`)** →
  [permissions/permissions.md](permissions/permissions.md)
- **Drush: the `--userid` option added to `migrate:import`/`migrate:rollback`** → [drush/migrate.md](drush/migrate.md)

Submodules documented here (own docs):
- Derivative actions: [islandora_image](../../modules/islandora_image/2.18.x/agent/start.md),
  [islandora_audio](../../modules/islandora_audio/2.18.x/agent/start.md),
  [islandora_video](../../modules/islandora_video/2.18.x/agent/start.md),
  [islandora_text_extraction](../../modules/islandora_text_extraction/2.18.x/agent/start.md) (OCR).
- [islandora_iiif](../../modules/islandora_iiif/2.18.x/agent/start.md) — IIIF manifests / image tiles.
- [islandora_breadcrumbs](../../modules/islandora_breadcrumbs/2.18.x/agent/start.md) — `field_member_of` breadcrumbs.
- Not separately documented (config/glue or absent deps): `islandora_core_feature` (config feature),
  `islandora_text_extraction_defaults` (default config), `islandora_advanced_search` (deprecated; needs
  Solr/facets), `islandora_microservice_rewrite` (URL-rewrite settings).

Key facts:
- Key fields (constants on `IslandoraUtils`): `field_member_of`, `field_model`, `field_media_use`,
  `field_media_of`, `field_external_uri`.
- Default broker `tcp://activemq:61613`; JWT expiry `+2 hour`; both in `islandora.settings`.
- Config object `islandora.settings`; configure route `system.islandora_settings`
  (`/admin/config/islandora/core`, requires `administer site configuration`).
- Media source REST: `PUT /media/{media}/source`, `PUT /node/{node}/media/{media_type}/{taxonomy_term}`,
  `GET|PUT /media/add_derivative/{media}/{destination_field}` (auth: basic_auth, cookie, jwt_auth).
