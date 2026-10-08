<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Rest Extra (entity_rest_extra) — agent index

Three read-only **`@RestResource` plugins** that expose entity **configuration** (not content) for
headless/decoupled discovery: a type's **bundles**, a bundle's **fields**, and a bundle's **view
modes**. No settings form, no config objects, no permissions.yml, no services, no hooks except
`hook_help`. Package `Web services`. Depends on core `serialization` and contrib `restui`.
Core `^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version-dir `8.x-2.x` (release 8.x-2.4).

- **The three REST resources — ids, URIs, methods, what each returns, source classes** →
  [plugins/rest-resources.md](plugins/rest-resources.md)
- **Enabling the resources, the REST permission/auth/format model, serialization** →
  [config/enable-and-access.md](config/enable-and-access.md)

## What it actually is (from source)

- `src/Plugin/rest/resource/EntityBundlesResource.php` — plugin id **`entity_bundles`**,
  GET `/entity/{entity_type}/bundles`.
- `src/Plugin/rest/resource/EntityBundleFieldsResource.php` — plugin id
  **`Entity Bundle Resource Label`** (label *"Fields by entity bundle"*),
  GET `/entity/{entity_type}/{bundle}/fields`.
- `src/Plugin/rest/resource/EntityBundleViewModesResource.php` — plugin id **`bundle_view_modes`**,
  GET `/entity/{entity_type}/{bundle}/view_modes`.
- All three extend core `Drupal\rest\Plugin\ResourceBase` and return a
  `Drupal\rest\ResourceResponse`. Only a `get()` method is implemented — no POST/PATCH/DELETE.
- `entity_rest_extra.module` implements only `hook_help()`. No `.routing.yml`, `.permissions.yml`,
  `.services.yml`, `.links.*.yml`, `.install`, or `config/` in the project.

## Operate it

Resources are enabled through Drupal's REST layer (the `restui` UI or a `rest_resource_config`
config entity), which is where authentication provider, serialization format (JSON recommended),
and the auto-generated `restful get <plugin_id>` permission are configured. Details in
[config/enable-and-access.md](config/enable-and-access.md).
