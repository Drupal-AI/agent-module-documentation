<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Atomic Content-Addressable Storage (atomic_cas) — agent index

Deduplicates Drupal file uploads by **SHA-256 content hash**: each unique file's bytes are stored
once in an on-disk blob store, while every Drupal file entity keeps a logical URI
`cas-public://{fid}/{filename}` or `cas-private://{fid}/{filename}`. Package `Storage`. Depends only
on core **`file`**. Core `^10.2 || ^11`, PHP `>=8.1`. License GPL-2.0-or-later. Version 1.0.0-beta3.

## What it actually is (NOT CAS single-sign-on)

"CAS" here = **content-addressable storage**, not the CAS auth protocol. There is no login,
ticket, or SSO. It is a file-deduplication layer under core's File module.

- **Blob store on disk**, sharded at `{root}/{scheme}/{hash[0:2]}/{hash[2:4]}/{hash}`. Roots are set
  in **settings.php** (`atomic_cas_public_root`, `atomic_cas_private_root`) — not Drupal config.
- Two DB tables (`hook_schema` in `atomic_cas.install`): **`atomic_cas_blob`** (hash, scheme,
  filesize, mimetype, created; PK `hash+scheme`) and **`atomic_cas_map`** (fid → hash+scheme; PK fid).
- Blob identity is **(hash, scheme)** — public and private never cross-deduplicate.

## Provides

- **Service `atomic_cas.manager`** → `AtomicCasManager` (all blob writes, ingest, dedup, URL
  generation, stats, GC helpers). Also `atomic_cas.settings` (`CasSettings` value object).
- **Hooks** in `src/Hook/AtomicCasHooks.php` (file_presave/insert/delete auto-ingest,
  entity_type_alter). Procedural shims + `atomic_cas_queue_ingest()` in `atomic_cas.module`.
- **Stream wrappers** `cas-public` (`CasPublicWrapper`, READ_VISIBLE) and `cas-private`
  (`CasPrivateWrapper`, READ) — read-only virtual overlays; all writes go through the manager.
- **Serve route** `atomic_cas.serve` at `/files/cas/{fid}/{short_hash}/{filename}`
  (`CasServeController`) — 3 modes: X-Accel-Redirect, X-Sendfile, readfile() fallback.
- **Admin report** route `atomic_cas.admin` at `/admin/reports/atomic-cas` (`CasAdminController`),
  permission **`administer atomic cas`** (`atomic_cas.permissions.yml`); menu link under Reports.
- **Image-style override** `AtomicCasImageStyle` (swapped in via entity_type_alter) — dedups
  derivatives of CAS-backed images.
- **Drush commands** (`src/Commands/CasCommands.php`): `atomic-cas:migrate`, `:gc`, `:audit`.
- `hook_requirements()` (`atomic_cas.install`) validates blob roots on the Status Report.

## Solution docs

- **Configure blob roots, acceleration, requirements, admin report** →
  [config/settings.md](config/settings.md)
- **Ingest lifecycle, the AtomicCasManager API, developer entry points** →
  [api/manager.md](api/manager.md)
- **Stream wrappers, the serve route/controller, DB schema, image-style dedup** →
  [storage/stream-wrappers-and-serve.md](storage/stream-wrappers-and-serve.md)
- **Drush: migrate / gc / audit** → [drush/commands.md](drush/commands.md)
