<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Sync — agent index

Exports/imports **content entities** as UUID-keyed YAML, the way core config management handles
config. UI at `/admin/config/development/content` (route `content.sync`, permission
`synchronize content`); CLI via `drush content-sync:export|import` (`cse` / `csi`).
Only hard dependency: core `serialization`.

> **Broken on Drupal 11.4 — verified.** With `content_sync` enabled on Drupal 11.4.4, every
> container build fatals:
>
> ```
> PHP Fatal error: Declaration of Drupal\content_sync\Normalizer\ContentEntityNormalizer::normalize(
>   $object, $format = null, array $context = []): ArrayObject|array|string|int|float|bool|null
> must be compatible with Drupal\serialization\Normalizer\ContentEntityNormalizer::normalize(
>   $entity, $format = null, array $context = []): array
> in .../content_sync/src/Normalizer/ContentEntityNormalizer.php on line 90
> ```
>
> Core `serialization` narrowed its normalizer return type; the module's override still declares
> the wider Symfony signature. The failure is **total** — `drush cr`, `drush en <anything>` and
> web requests all die, and because the fatal happens during bootstrap you cannot even uninstall
> it with Drush. Recovery is to remove `content_sync` from `core.extension` directly in the
> `config` table and truncate the cache tables. Everything below is documented from source and
> was **not** verifiable on a live 11.4 site. The `^10.1 || ^11` constraint in `info.yml` is
> optimistic; treat this branch as Drupal ≤ 11.3 only until the signature is fixed.

- **Sync directory setup (`$content_directories`), settings form, the UI routes, tables** →
  [configure/setup.md](configure/setup.md)
- **Drush `content-sync:export` / `content-sync:import` and every option** →
  [drush/commands.md](drush/commands.md)
- **Services to call from code (manager, exporter, importer) and the YAML format** →
  [api/export-import.md](api/export-import.md)
- **`sync_normalizer_decorator` plugins + the normalizer stack you can override** →
  [plugins/normalizer-decorators.md](plugins/normalizer-decorators.md)
- **The four permissions and what each route needs** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Export target directory is **not** a config value: it is the global
  `$content_directories['sync']` in `settings.php` (falls back to `['staging']`). If unset,
  the module shows an error message instead of throwing —
  `content_sync_get_content_directory()` returns NULL and the run produces nothing.
- One YAML file per entity, named `{entity_type}.{bundle}.{uuid}.yml`, written to
  `entities/{entity_type}/{bundle}/` (plus a top-level `entities/site.uuid.yml` stamping the
  source site). References between entities are stored as **UUIDs**, so numeric ids never travel
  between environments; translations are nested under a `_translations:` key.
- Two schema tables (`content_sync.install`): `cs_db_snapshot` (last-known content state, used
  for the diff/change list; kept current by `hook_entity_update`) and `cs_logs` (rows written by
  the module's own `logger.cslog` channel, shown at `/admin/config/development/content/logs`).
- Import matches on UUID: existing entity → updated in place, unknown UUID → created. Order is
  resolved by `ImportQueueResolver` so referenced entities are imported first.
- `site_uuid_override: "0"` in `content_sync.AdminSettings` — when enabled, content exported from
  a *different* site is accepted. Off by default (matching core's config-import safety check).
- Files: `--files=none|base64|folder` (default `folder`). `base64` inlines file contents in the
  YAML; `folder` copies them beside the YAML.
- Node bulk action `node_export_action` ("Export content") sends the selected nodes to
  `content.export_multiple_confirm`.
