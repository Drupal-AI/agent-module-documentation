<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: the `access_scheme` config entity

Workbench Access is configured almost entirely through **access scheme** config entities.
UI: `/admin/config/workflow/workbench_access` → *Add access scheme* (entity routes under
`entity.access_scheme.*`; settings form route `workbench_access.admin` at
`/admin/config/workflow/workbench_access/settings`).

## Entity type

- **Config entity type id:** `access_scheme`
- **Config prefix / name:** `workbench_access.access_scheme.<id>`
- **admin_permission:** `administer workbench access`
- **Class:** `Drupal\workbench_access\Entity\AccessScheme`
- **List builder / forms:** add = `AccessSchemeAddForm`, edit = `AccessSchemeForm`, delete = `AccessSchemeDeleteForm`.

## Exported keys (`config_export`)

| Key | Meaning |
|---|---|
| `id` | Machine name of the scheme. |
| `label` | Human label. |
| `plural_label` | Plural label (shown when picking sections). |
| `scheme` | **AccessControlHierarchy plugin id** driving this scheme — `taxonomy` or `menu` (or a custom plugin). |
| `scheme_settings` | Per-plugin settings; schema is `workbench_access.scheme_settings.[%parent.scheme]` (validated by the named plugin). |

### `scheme_settings` by plugin

- **taxonomy** — `vocabularies` (list of vocabulary ids) and `fields` (list of
  `{entity_type, bundle, field}` mappings pointing at the term-reference field that holds the section).
- **menu** — `menus` (list of menu ids) and `bundles` (list of node bundle ids that participate).

## Example on-disk YAML (taxonomy scheme)

```yaml
# workbench_access.access_scheme.editorial.yml
id: editorial
label: Editorial
plural_label: Editorial sections
scheme: taxonomy
scheme_settings:
  vocabularies:
    - tags
  fields: {  }
```

## Create / read / delete via drush

```bash
# Create a taxonomy-based scheme
drush php:eval '\Drupal::entityTypeManager()->getStorage("access_scheme")->create([
  "id" => "editorial", "label" => "Editorial", "plural_label" => "Editorial sections",
  "scheme" => "taxonomy",
  "scheme_settings" => ["vocabularies" => ["tags"], "fields" => []],
])->save();'

# Read the plugin id + settings back
drush php:eval '$e=\Drupal::entityTypeManager()->getStorage("access_scheme")->load("editorial");
  print $e->get("scheme")." ".json_encode($e->get("scheme_settings"));'

# Or via config
drush cget workbench_access.access_scheme.editorial

# Delete (also removes its section_association entities and resets caches)
drush php:eval '\Drupal::entityTypeManager()->getStorage("access_scheme")->load("editorial")->delete();'
```

`$scheme->getAccessScheme()` returns the instantiated AccessControlHierarchy plugin;
`$scheme->getPluginCollections()` exposes it as a lazy plugin collection under `scheme_settings`.

## Module setting

`workbench_access.settings` has one key: `deny_on_empty` (bool, default `false`) — when
`true`, content not assigned to any section is denied to non-bypass users.
