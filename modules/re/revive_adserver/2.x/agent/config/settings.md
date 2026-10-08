<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & zone sync (`revive_adserver.settings`)

## Install & enable

```bash
composer require drupal/revive_adserver
drush en revive_adserver -y
```

Pulls in `szeidler/revive-xmlrpc` (XML-RPC client). Core deps: `block`, `field`.

## The config object

Form: `src/Form/ReviveAdserverSettingsForm.php` (`ConfigFormBase`, form id
`revive_adserver_settings`). Route `revive_adserver.settings` →
`/admin/config/services/revive-adserver`, permission **`administer revive_adserver`**
(menu link under *Configuration → Services*). Editable config: `revive_adserver.settings`.

Schema — `config/schema/revive_adserver.schema.yml`, type `config_object`:

| Key | Type | Meaning |
|---|---|---|
| `delivery_url` | string | Delivery host+path, e.g. `ads.example.org/delivery`. No protocol. Used to build every ad tag as `//<delivery_url>/…`. **Required.** |
| `delivery_url_ssl` | string | Optional HTTPS delivery host+path. Used to compute the Revive id and preferred for the sync request. |
| `publisher_id` | integer | Revive publisher id; the sync fetches this publisher's zones. **Required.** |
| `zones` | sequence | Synced zones. Each mapping: `id` (int), `name` (string), `width` (int), `height` (int). |

`submitForm()` writes only `delivery_url`, `delivery_url_ssl`, `publisher_id`. `zones` is written
by the sync handler. `hook_requirements()` (`.install`) shows a `REQUIREMENT_WARNING` on the
status report until all four keys are non-empty.

## Zone sync (`syncZones()`)

The form has a "Zone configuration" fieldset with **Revive username / password** fields and a
**"Sync zones now"** submit (`#submit = ['::syncZones', '::submitForm']`). `syncZones()`:

1. Builds the base URL: `https://<delivery_url_ssl>` if the SSL URL is set (ssl=TRUE), else
   `http://<delivery_url>`.
2. Derives the XML-RPC base path by cutting the URL path at `/delivery` and appending
   `/api/v2/xmlrpc/`.
3. Requires username+password (else sets form errors).
4. Calls `new OpenAdsV2ApiXmlRpc($host, $basepath, $user, $pass, 0, $ssl, 15)` then
   `getZoneListByPublisherId($publisher_id)` (from `Artistan\ReviveXmlRpc`, the
   `szeidler/revive-xmlrpc` package — a `PhpXmlRpc\Client` under the hood).
5. On success, stores each returned zone as `id/name/width/height` into `zones` and saves.
   On empty/failure it shows an error and suggests checking logs.

**Credentials are used transiently only** — the username/password are read from form state for
the single API call and are never written to config or state (the fieldset description says so).

## Config export example

```yaml
# revive_adserver.settings
delivery_url: 'ads.example.org/delivery'
delivery_url_ssl: 'ads.example.org/delivery'
publisher_id: 3
zones:
  7:
    id: 7
    name: 'Leaderboard 728x90'
    width: 728
    height: 90
```

Zones can also be entered/edited directly in config if you don't want to sync — the block/field
just need a zone `id`; the `width`/`height` are used only by the iframe method.
