<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins: AccessControlHierarchy

Workbench Access defines one plugin type — **AccessControlHierarchy** — that turns some
existing hierarchy into editorial *sections*. An `access_scheme` config entity picks one via
its `scheme` key.

- **Plugin type id (in `data.json`):** `AccessControlHierarchy`
- **Plugin namespace:** `Plugin/AccessControlHierarchy`
- **Manager service:** `plugin.manager.workbench_access.scheme` (`WorkbenchAccessManager`)
- **Annotation:** `@AccessControlHierarchy` (`Drupal\workbench_access\Annotation\AccessControlHierarchy`)
- **Interface:** `AccessControlHierarchyInterface`
- **Base class:** `AccessControlHierarchyBase`

## Bundled plugins

| Plugin id | Required module | Section source | `scheme_settings` keys |
|---|---|---|---|
| `taxonomy` | taxonomy | Terms of one or more vocabularies | `vocabularies`, `fields` |
| `menu` | menu_ui | Items in one or more menu trees | `menus`, `bundles` |

List them live:

```bash
drush php:eval 'echo implode(",", array_keys(
  \Drupal::service("plugin.manager.workbench_access.scheme")->getDefinitions()));'
# => taxonomy,menu
```

## Annotation fields

```php
/**
 * @AccessControlHierarchy(
 *   id = "taxonomy",
 *   module = "taxonomy",
 *   entity = "taxonomy_term",
 *   label = @Translation("Taxonomy"),
 *   description = @Translation("Uses a taxonomy vocabulary as an access control hierarchy.")
 * )
 */
```

- `id` — plugin id used as a scheme's `scheme` value.
- `module` — module that must be present for the plugin to work.
- `entity` — (optional) the entity type that provides an access-control item (term / menu link).
- `label`, `description` — shown when adding/configuring a scheme.

## Writing a custom hierarchy

Extend `AccessControlHierarchyBase`, put the class in
`src/Plugin/AccessControlHierarchy/`, and implement the key methods (the base provides most
plumbing): `getTree()` (build the section tree), `getPluginScheme()` / config-form methods,
`getEntityValues()` (which sections a piece of content belongs to), and
`applies()`/`checkEntityAccess()`. Override `defaultConfiguration()` to declare your
`scheme_settings`. Add a matching schema entry `workbench_access.scheme_settings.<id>` in
`config/schema` so the settings validate. Once discovered, your plugin id appears in the
*Add access scheme* form. See `Taxonomy` and `Menu` as working references.
