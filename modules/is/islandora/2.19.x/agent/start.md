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
- Derivative actions: [islandora_image](../../modules/islandora_image/2.19.x/agent/start.md),
  [islandora_audio](../../modules/islandora_audio/2.19.x/agent/start.md),
  [islandora_video](../../modules/islandora_video/2.19.x/agent/start.md),
  [islandora_text_extraction](../../modules/islandora_text_extraction/2.19.x/agent/start.md) (OCR).
- [islandora_iiif](../../modules/islandora_iiif/2.19.x/agent/start.md) — IIIF manifests / image tiles.
- [islandora_breadcrumbs](../../modules/islandora_breadcrumbs/2.19.x/agent/start.md) — `field_member_of` breadcrumbs.
- Not separately documented (config/glue or absent deps): `islandora_core_feature` (config feature),
  `islandora_text_extraction_defaults` (default config), `islandora_microservice_rewrite` (URL-rewrite settings).

Key facts:
- Key fields (constants on `IslandoraUtils`): `field_member_of`, `field_model`, `field_media_use`,
  `field_media_of`, `field_external_uri`.
- Default broker `tcp://activemq:61613`; JWT expiry `+2 hour`; both in `islandora.settings`.
- Config object `islandora.settings`; configure route `system.islandora_settings`
  (`/admin/config/islandora/core`, requires `administer site configuration`).
- Media source REST: `PUT /media/{media}/source`, `PUT /node/{node}/media/{media_type}/{taxonomy_term}`,
  `GET|PUT /media/add_derivative/{media}/{destination_field}` (auth: basic_auth, cookie, jwt_auth).

## Diff 2.18.x → 2.19.x

2.19.0 (packaged 2026-09-01) is a maintenance minor over the 2.18 line — no new routes, permissions, config
keys, or dependencies; the module info, `islandora.routing.yml`, `islandora.services.yml`,
`islandora.permissions.yml`, and `composer.json` are unchanged from what the 2.18 docs describe. Notable
changes (from the upstream 2.18.0…2.19.0 changelog and confirmed against the 2.19.0 source):

- **`islandora_advanced_search` submodule removed.** It had been deprecated for several years; it is gone from
  `modules/` in 2.19.0. Sites that enabled it must uninstall it before/along with the update. The submodule
  list in `data.json` drops it accordingly.
- **Type-specific media-derivative attachment fixed.** `MediaSourceService::putToNode()` now skips any
  pre-existing media whose bundle does not match the target `media_type` ("Media unrelated to the target
  derivative; skip it") rather than updating a mismatched media — so a microservice PUT-back lands on the
  correct media bundle. See [api/services.md](api/services.md).
- **Media-source write path validates the `Content-Location` destination.** The 2.19.0
  `MediaSourceService::validateContentLocation()` rejects null bytes, requires a valid stream-wrapper URI with
  a filename, and blocks path-traversal / non-canonical targets before any bytes are written; the persisted
  MIME type is re-derived from the written bytes (`determinePersistedMimeType()`) instead of trusting the
  client-supplied `Content-Type`.
- **IIIF manifest output updated for IIIF Image API v3** (`islandora_iiif`), with regression tests.
- **Node deletion refactored** to track and report failures (a `nondeleteable_nodes` set is now carried into
  the confirm-delete submit handler).
- **File-checksum view** gained display extenders; the old Matomo display extender was removed and is no
  longer enabled by default.
- **`islandora_microservice_rewrite`** URL rewriting fixed for canonical event URLs.
- **Drupal 11.4 compatibility** for `IslandoraImageFormatter`; a `funding.json` was added. Core requirement
  stays `^10.3 || ^11`.
