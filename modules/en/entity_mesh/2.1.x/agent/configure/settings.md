# Configuration

Config object `entity_mesh.settings` (schema `config/schema/entity_mesh.schema.yml`; defaults in
`config/install/entity_mesh.settings.yml`).

## Settings form — `entity_mesh.settings_form`

Route `/admin/config/system/entity-mesh`, permission `administer entity_mesh configuration`
(`restrict access: true`), form `Drupal\entity_mesh\Form\SettingsForm`.

### Global

| Key | Type | Default | Meaning |
|---|---|---|---|
| `self_domain_internal` | bool | true | Treat absolute URLs on the current domain as internal (resolve to entities). |
| `check_unmanaged_files` | bool | false | Reclassify links to physically-present but untracked public files as valid instead of broken (extra per-link storage stat — costly on remote/object storage). |
| `track_no_links` | bool | true | Record a synthetic "no-links" row for source entities that produce no links, so orphan/dead-end pages appear in reports. |
| `processing_mode` | string | `synchronous` (install) / falls back to `asynchronous` | See processing modes below. |
| `synchronous_limit` | int | 25 | In sync mode, entities with ≤ this many links are processed on save; heavier ones are deferred to cron. |
| `debug` | bool | false | Extra logging during processing. |

### Analyzer account (`analyzer_account`)

Which audience the analysis renders content as (determines which links are "accessible"). `type` is one of:
- `anonymous` (default) — render as an anonymous visitor.
- `authenticated` — authenticated plus the `roles` you check.
- `user` — a specific `user_id` (entity autocomplete; required when this type is chosen).

Stored as `{type, roles (nullable list), user_id (nullable int)}`.

### Source types (`source_types`)

Which entity types/bundles are analyzed as link **sources**. Only `node` is supported as a source
(`SUPPORTED_SOURCE_ENTITIES = ['node']`). Enable the type; optionally check specific bundles (no bundles
checked = all bundles). Shape: `source_types.<type>.{enabled: bool, bundles: {<bundle>: true}}`.

### Menus (`menu_types`)

Checkboxes of menus to analyze; each enabled menu contributes parent-page→child-page edges. Shape
`menu_types.<menu_name>: true` (default `{main: true}`). Toggling a menu re-queues its links for the
`entity_mesh_menu` consumer (`entity_mesh_mark_menu_links_for_reprocess`).

### Target types (`target_types`)

What counts as a valid link **target**:
- `internal.<entity_type>.{enabled, bundles}` — content/config entity types (and a `view` pseudo-type).
- `external.scheme.{http, tel, mailto}` — external URL schemes.
- `external.categories.{iframe}` — external content categories.

## Cron form — `entity_mesh.cron_form`

Route `/admin/config/system/entity-mesh/cron`, same permission, form `CronForm`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `cron_enabled` | bool | true | Let entity_registry process pending Entity Mesh items during cron. |
| `cron_limit` | int | 50 | Max entities processed per cron run (timeout guard). |

## Processing modes

- **asynchronous** — every save just leaves the registry row PENDING; all analysis happens on cron (fast saves).
- **synchronous** — on save, `EntityMeshConsumer::processItem()` counts links; if ≤ `synchronous_limit` it
  processes immediately, otherwise it defers to cron. Cron/batch phases always process.

## Applying config via drush

```bash
ddev drush config:set entity_mesh.settings processing_mode asynchronous -y
ddev drush config:set entity_mesh.settings source_types.node.enabled 1 -y
```

After changing what is tracked, use the entity_registry consumer detail actions (Queue all / Clear / Rebuild)
on the `entity_mesh` and `entity_mesh_menu` consumers to repopulate — see [../api/architecture.md](../api/architecture.md).
