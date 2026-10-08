# Gatsby — agent index

Decoupled integration: sends Drupal content-entity changes to a GatsbyJS front end for live preview
and incremental/full builds, and serves an incremental "Fastbuilds" sync feed. Depends on core
`path_alias`, `content_moderation`, and `jsonapi_extras`. Config route `gatsby.gatsby_admin_form`
(`/admin/config/services/gatsby/settings`, permission `administer gatsby`). Provides permissions, a
Drush command, a `gatsby_log_entity` content entity, and config schema. No plugin types of its own.

- **All `gatsby.settings` keys, the admin form, per-node-type preview toggle, iframe preview display component** →
  [configure/settings.md](configure/settings.md)
- **How changes reach Gatsby: entity hooks, `GatsbyPreview` webhooks, `PathMapping`, the Fastbuilds log +
  `/gatsby-fastbuilds/sync` endpoint, permissions, auth, Drush purge** → [api/preview-and-sync.md](api/preview-and-sync.md)

Submodules (own docs):
- `gatsby_extras` (JSON:API menu/link enhancer) → [../../modules/gatsby_extras/2.0.x/agent/start.md](../../modules/gatsby_extras/2.0.x/agent/start.md)
- `gatsby_fastbuilds` (hidden legacy stub, folded into main module) → [../../modules/gatsby_fastbuilds/2.0.x/agent/start.md](../../modules/gatsby_fastbuilds/2.0.x/agent/start.md)
- `gatsby_instantpreview` (hidden legacy stub, replaced by Fastbuilds) → [../../modules/gatsby_instantpreview/2.0.x/agent/start.md](../../modules/gatsby_instantpreview/2.0.x/agent/start.md)

Key facts:
- Change detection is `hook_entity_insert/update/delete` in `gatsby.module`, gated by
  `GatsbyPreview::isSupportedEntity()` (entity type must be checked in `supported_entity_types`).
- Published entities produce "build" log records; every change also produces a "preview" record.
  The two are separated by the `sync gatsby fastbuild [preview] log entities` permissions.
- Webhook POSTs use a 1-second timeout (`GatsbyPreview::triggerRefresh`) and are fire-and-forget.
