<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config object & the widget-loader library

## Install & enable

```bash
composer require drupal/adaptive_interact_client
drush en adaptive_interact_client -y
```

No contrib dependencies. `composer.json` requires only `php >=8.1` and `drupal/core ^10 || ^11 || ^12`.

## The settings form

`src/Form/SettingsForm.php` — `SettingsForm extends ConfigFormBase`, form id
`adaptive_interact_client_settings`. Reached at **`/admin/config/system/adaptive-interact-client`**
(route `adaptive_interact_client.settings`, title *"Interact Client Settings"*, permission
**`administer site configuration`**; menu link *"Adaptive Interact Settings"* under
*Configuration → System*, defined in `adaptive_interact_client.links.menu.yml`).

It injects `config.factory` and `entity_field.manager` (`create()` / constructor) and edits the single
config object returned by `getEditableConfigNames()`: **`adaptive_interact_client.settings`**.

`buildForm()` fields:

| Field | Type | Notes |
|---|---|---|
| `server_url` | textfield, **required** | Base URL of the Interact server. Default value shown when unset: `https://interact.adaptive.co.uk`. |
| `widget_id` | textfield, **required** | Default widget ID used by placements that don't set their own. |
| `avatar_field` | select | Optional. Options are built by scanning `entityFieldManager->getFieldDefinitions('user','user')` and listing every field whose type is `image` (plus a *None* option `''`). |

`submitForm()` saves all three keys to `adaptive_interact_client.settings` and calls the parent.

## Config object

`adaptive_interact_client.settings` keys (no `config/install` default file and **no `config/schema`** ship
with the module, so values come entirely from the form; strict config-schema tooling will flag this object):

- `server_url` (string) — Interact base URL.
- `widget_id` (string) — default widget ID.
- `avatar_field` (string) — machine name of a user image field, or `''` for none.

Drush example:

```bash
drush cset adaptive_interact_client.settings server_url 'https://interact.adaptive.co.uk' -y
drush cset adaptive_interact_client.settings widget_id 'my-widget-id' -y
drush cset adaptive_interact_client.settings avatar_field user_picture -y
drush cr
```

## The external widget-loader library (mechanism)

There is **no `adaptive_interact_client.libraries.yml`**. The library named
`adaptive_interact_client/widget` is created at runtime in `hook_library_info_alter()`
(`adaptive_interact_client.module`):

1. Reads `server_url` from `adaptive_interact_client.settings`.
2. Builds a cache-buster `$cache_buster = date('Y-m-d-G')` (year-month-day-hour) and a loader URL
   `{server_url}/interact-chat/widget-loader?v={cache_buster}`.
3. Sets `$libraries['widget']['version'] = '1.0'` and registers the loader URL as an **external** JS asset
   with `['type' => 'external', 'attributes' => ['defer' => TRUE]]`.

So placing/attaching the widget causes the browser to load a `<script defer>` from the configured Interact
server. The hourly cache-buster (and the fact the alter re-reads config each build) means the loader URL
refreshes when `server_url` changes. The remote script is what actually renders the chat/search UI in the
browser — nothing is fetched server-side by Drupal.

Note the loader URL inherits whatever scheme the admin types into `server_url`; set an `https://` URL so the
third-party script loads over TLS.
