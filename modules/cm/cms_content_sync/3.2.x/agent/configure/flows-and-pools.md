<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: site registration, Pools and Flows

Content Sync is configured through two config entities plus a site registration with the
external Sync Core backend. Admin UI root: `/admin/config/services/cms_content_sync`
(route `cms_content_sync.site`, permission `administer cms content sync`). Most admin
screens are iframes embedded from the content-sync.io backend (`Controller\Embed`).

## Pool — `cms_content_sync_pool`

The shared syndication channel. Config prefix `cms_content_sync.pool.<id>`. The
`@ConfigEntityType` `config_export` persists only **`id`, `label`, `backend_url`** in 3.2.x.
The schema (`config/schema/cms_content_sync.schema.yml`) also lists `authentication_type`
and `site_id`, but these are **not** in `config_export`, so passing them to
`Pool::create()` does not persist them — inspect real pools by `backend_url`.

| Key | Meaning | Persisted? |
|---|---|---|
| `id` | machine name | yes |
| `label` | human label | yes |
| `backend_url` | Sync Core URL (the content-sync.io endpoint) | yes |
| `authentication_type` | e.g. `basic_auth` (schema only) | no (dropped on save in 3.2.x) |
| `site_id` | site identifier within the pool (schema only) | no (dropped on save in 3.2.x) |

Create programmatically (safe — does **not** contact the backend):

```php
use Drupal\cms_content_sync\Entity\Pool;
Pool::create([
  'id' => 'my_pool', 'label' => 'My Pool',
  'backend_url' => 'https://example.content-sync.io',
])->save();
// convenience factory: Pool::createPool($label, $id, $backend_url, $authentication_type);
```

List/inspect: `drush cget cms_content_sync.pool.my_pool`, or
`drush ev '\Drupal\cms_content_sync\Entity\Pool::load("my_pool")->backend_url'`.

## Flow — `cms_content_sync_flow`

Declares which entity types/bundles this site pushes or pulls and to/from which pools.
Config prefix `cms_content_sync.flow.<id>`. Key mapping keys: `id`, `name`, `type`,
`variant`, `simple_settings`, `per_bundle_settings`, `sync_entities`.

- `variant` must be `simple` (`Flow::VARIANT_SIMPLE`) or `per-bundle`
  (`Flow::VARIANT_PER_BUNDLE`). **In 3.2.x only `simple` has a controller** — saving a Flow
  with an empty/unknown variant throws `Unknown Flow variant ''`.
- `type` describes direction (e.g. `both`, push, pull) as configured on the backend.
- `sync_entities` / `per_bundle_settings` hold the per-entity-type serialization config
  (which handler, which pool, push/pull mode).

Create programmatically (safe):

```php
use Drupal\cms_content_sync\Entity\Flow;
Flow::create([
  'id' => 'my_flow', 'name' => 'My Flow', 'type' => 'both', 'variant' => 'simple',
  'simple_settings' => [], 'per_bundle_settings' => [], 'sync_entities' => [],
])->save();
```

## Register the site with the backend

- UI: `/admin/config/services/cms_content_sync/site`, follow the embedded registration.
- CLI: `drush cms_content_sync:register <environment_type> <contract> <space> <token>`
  (see [../drush/commands.md](../drush/commands.md)).
- After changing Flow/Pool config, push it to the backend with
  `drush cms_content_sync:configuration-export` (alias `cse`).

## Credentials / encryption config (installed defaults)

`config/install/` ships:
- `key.key.cms_content_sync` — a `key.key` entity (`key_type: encryption`, 256-bit,
  provider `config`) used to encrypt syndication credentials. **Its default `key_value` is
  a placeholder that must be replaced**.
- `encrypt.profile.cms_content_sync` — a `real_aes` encryption profile referencing that key.
- Several `rest.resource.cms_content_sync_*` resources the backend calls to push/pull.
