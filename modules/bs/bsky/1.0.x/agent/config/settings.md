<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BlueSky settings & credentials

## Install / enable

```
composer require drupal/bsky        # pulls potibm/phluesky, nyholm/psr7, php-http/guzzle7-adapter
drush en bsky -y                     # also enable key; enable eca to use the action plugins
```

`bsky.info.yml` declares only `dependencies: [key:key]` and `core_version_requirement: ^10 || ^11`.
The library requires PHP 8.2. ECA is not declared but is required for the action plugins.

## The settings form

`Drupal\bsky\Form\SettingsForm` (`final class`, extends `ConfigFormBase`), form id `bsky_settings`.

- Route `bsky.admin.config` → path `/admin/config/services/bsky`, permission
  **`administer site configuration`** (`bsky.routing.yml`). Menu link `bsky.admin.config` under
  `system.admin_config_services` (`bsky.links.menu.yml`).
- `getEditableConfigNames()` = `['bsky.settings']`.
- Two fields (`buildForm()`):
  - **`handle`** — `textfield`, the BlueSky handle without the leading `@`.
  - **`app_key`** — `#type => key_select` (from Key module). Stores the **Key entity id**, not the
    secret itself. Description tells the admin to create an App Password on their BlueSky profile
    and add it to the Key module.
- `validateForm()` loads the selected key via `keyRepository->getKey($key)->getKeyValue()` and sets
  an error if the value is empty.
- `submitForm()` saves `handle` and `app_key` into `bsky.settings`.

## Config object & schema

Config object **`bsky.settings`** (`config/schema/bsky.schema.yml`, type `config_object`):

| key       | type   | meaning |
|-----------|--------|---------|
| `handle`  | string | BlueSky handle (no `@`). |
| `app_key` | string | **Key entity id** holding the BlueSky app password. |

Because `app_key` stores only the Key id, the actual app password lives wherever the Key provider
puts it (env var, file, etc.) and is **not** written into `bsky.settings` or config exports. Use a
Key provider that keeps the secret out of the database/VCS.

The schema file also defines four ECA action config mappings —
`action.configuration.bsky_create_post` (`message`, `token_name`),
`action.configuration.bsky_send_post` (`post`, `token_name`),
`action.configuration.bsky_add_facets` (`post`),
`action.configuration.bsky_add_image` (`post`, `image`, `alt_text`).

## How credentials reach the API

`PostService::__construct()` reads `handle` and `app_key` from `bsky.settings`; if either is empty,
or the Key cannot be loaded, it sets `isConfigured = FALSE` and returns (calls to `createPost()`
then throw `InvalidPluginDefinitionException`). Otherwise it builds
`new BlueskyApi($handle, $app_key->getKeyValue())`. The secret is used only to construct the API
client — it is not logged or rendered anywhere in module code.
