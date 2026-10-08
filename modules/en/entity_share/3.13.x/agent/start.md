# entity_share — agent start

Share **content entities between separate Drupal sites over JSON:API**. A site can be a
**server** (exposes content via `channel` config entities) and/or a **client** (pulls content
via `remote` + `import_config` config entities). The base `entity_share` module is a **shell**:
its only surface is the landing page **Admin → Config → Web services → Entity Share**
(`/admin/config/services/entity_share`, route `entity_share.admin_config_page`, permission
`entity_share_access_config_pages`). All real config lives in the submodules.

- The config entities (`channel`, `remote`, `import_config`) — fields, drush, creation → [configure/config-entities.md](configure/config-entities.md)
- Create/read config entities & trigger a pull programmatically → [api/programmatic.md](api/programmatic.md)

Submodules (each documented / listed separately):
- **entity_share_server** — defines the `channel` config entity (the server side).
- **entity_share_client** — defines the `remote` + `import_config` config entities, the Pull form, and Drush (the client side).
- **entity_share_async** — queued/asynchronous import (depends on client).
- **entity_share_lock** — lock imported content against local edits (depends on client).
- **entity_share_diff** — local vs remote field diff (depends on client).

Limitation: a real end-to-end sync needs **two sites**. On a single site you can still create
and introspect the `channel` / `remote` config entities (that is what the evals ground on).
