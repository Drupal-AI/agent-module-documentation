<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Next.js — config entities & settings

Admin UI: *Configuration → Web services → Next.js* (`/admin/config/services/next`). Three pieces of
config: the `next_site` entities (front ends), the `next_entity_type_config` entities (entity→site
mapping + revalidation), and the global `next.settings`.

## `next_site` config entity

One per Next.js front end. `config_prefix: next_site` → config name `next.next_site.<id>`.
Exported keys (`config_export`):

| Key | Meaning |
|---|---|
| `id`, `label` | machine id + label |
| `base_url` | front-end base URL (live site) |
| `preview_url` | endpoint the preview request is POSTed to (e.g. `<base>/api/preview`) |
| `preview_secret` | shared secret for preview auth |
| `revalidate_url` | front-end revalidation endpoint (e.g. `<base>/api/revalidate`) |
| `revalidate_secret` | shared secret for revalidation |

Routes: collection `/admin/config/services/next/sites`, add/edit/delete, plus an
`environment-variables` route (`/admin/config/services/next/sites/{next_site}/env`) that prints env
vars for the Next.js app. Create via the UI or code:

```php
\Drupal\next\Entity\NextSite::create([
  'id' => 'blog', 'label' => 'Blog',
  'base_url' => 'https://blog.example.com',
  'preview_url' => 'https://blog.example.com/api/preview',
  'preview_secret' => 'SECRET',
  'revalidate_url' => 'https://blog.example.com/api/revalidate',
  'revalidate_secret' => 'SECRET',
])->save();
```

Key methods (see [api/services-and-events.md](../api/services-and-events.md)):
`getBaseUrl/setBaseUrl`, `getPreviewUrl`, `getPreviewSecret`, `getRevalidateUrl`,
`getRevalidateSecret`, `getPreviewUrlForEntity($entity)`, `getLiveUrlForEntity($entity)`,
`buildRevalidateUrl($query)`.

## `next_entity_type_config` config entity

Maps an entity-type **bundle** to Next.js site(s) and configures revalidation/draft. The entity **id
is `"<entity_type>.<bundle>"`** (e.g. `node.article`). Config name
`next.next_entity_type_config.node.article`. Exported keys:

| Key | Meaning |
|---|---|
| `id` | `entity_type.bundle` |
| `site_resolver` | plugin id: `site_selector` or `entity_reference_field` |
| `configuration` | site_resolver plugin config (e.g. `{ sites: [<next_site id>, …] }`) |
| `draft_enabled` | bool — draft mode for this type |
| `revalidator` | plugin id: `path` or `cache_tag` (or none) |
| `revalidator_configuration` | revalidator plugin config |

```php
\Drupal\next\Entity\NextEntityTypeConfig::create([
  'id' => 'node.article',
  'site_resolver' => 'site_selector',
  'configuration' => ['sites' => ['blog']],
  'draft_enabled' => TRUE,
  'revalidator' => 'path',
  'revalidator_configuration' => ['revalidate_page' => 1, 'additional_paths' => "/blog"],
])->save();
```

Site-resolver config schema: `site_selector` → `{ sites: [string] }`; `entity_reference_field` →
`{ field_name: string }`. Revalidator `path` config → `{ revalidate_page: bool, additional_paths:
string }`.

## `next.settings` (global)

Config object `next.settings`. Defaults (from `config/install/next.settings.yml`):

```yaml
site_previewer: iframe
site_previewer_configuration:
  width: 100%
  sync_route: false
  sync_route_skip_routes: ''
preview_url_generator: simple_oauth
preview_url_generator_configuration:
  secret_expiration: 30      # minutes the preview secret is valid
debug: false
```

Settings form route: `next.settings` → `/admin/config/services/next/settings`
(`_permission: 'administer site configuration'`). Read/write with drush:

```bash
drush cget next.settings
drush cset next.settings debug true -y
```

The `*_configuration` sub-key is typed by the selected plugin id (schema uses
`[%parent.site_previewer]` / `[%parent.preview_url_generator]`), so it changes shape when you switch
previewer/generator.

## Uninstall

`NextUninstallValidator` blocks uninstall while the active preview_url_generator/previewer plugins
are in use; clear/rely on defaults before uninstalling.
