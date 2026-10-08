<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CBP configuration, routes & watchlist UI

## Install & enable

```bash
composer require drupal/cbp
drush en cbp -y   # pulls in core `ban` (the only dependency)
```

`cbp.install` creates the `cbp_watchlist` table (`ip` varchar(45) pk, `threat_score` int,
`added` int). No sub-modules, no permissions defined by the module, no Drush commands.

## Config object `cbp.settings`

- Single key **`api_key`** (schema `cbp.schema.yml`: `type: config_object` → mapping `api_key`
  string). Install default (`config/install/cbp.settings.yml`) is the placeholder string
  `SIGN_UP_FOR_A_FREE_API_KEY_-_SEE_README_DOCUMENTATION`.
- Edit via **`CbpSettingsForm`** (`getFormId` = `cbp_settings_form`, `ConfigFormBase`).
  `validateForm()` requires the key to match `/^[a-f0-9]{64}$/i` (64 hex chars) or the form
  errors with "The API Key appears invalid." The form shows a sign-up call-to-action linking to
  `https://responsiveweb.io/cbp/signup`.
- Drush equivalent:

```bash
drush cset cbp.settings api_key <64-hex-key> -y
```

Without a valid key the reporting paths return early — the module runs as **local-only**
flood/404 detection.

## Routes & permissions (`cbp.routing.yml`)

| Route | Path | Handler | Permission |
|---|---|---|---|
| `cbp.settings` | `/admin/config/services/cbp` | `_form` CbpSettingsForm | `administer site configuration` |
| `cbp.reports` | `/admin/config/services/cbp/reports` | `CbpReportController::watchlist` | `administer site configuration` |
| `cbp.watchlist_delete` | `/admin/config/services/cbp/watchlist/delete/{ip}` | `_form` CbpWatchlistDeleteForm | `administer site configuration` |

Menu: `cbp.links.menu.yml` puts a "Crowd Bruteforce Protection" link under
*Configuration → System / Services* (`system.admin_config_services`) pointing at `cbp.reports`.
`cbp.links.task.yml` adds two local tabs on the settings page: **Settings** (`cbp.settings`,
weight 0) and **Local Watchlist** (`cbp.reports`, weight 10). `cbp_help()` (`cbp.module`) adds
the admin help text.

## Watchlist UI

- `CbpReportController::watchlist()` renders a `#type => table` of up to 100 rows from
  `cbp_watchlist` ordered by `added` DESC — columns IP, Threat Score, Date Added (via
  `date.formatter` 'short'), and an Operations link "Remove & Unban". Empty text:
  "No threats currently in the local watchlist."
- **`CbpWatchlistDeleteForm`** (`ConfirmFormBase`, id `cbp_watchlist_delete_form`) takes `{ip}`,
  asks for confirmation, then on submit `DELETE`s the row, calls `ban.ip_manager->unbanIp($ip)`
  if banned, logs a notice, and redirects back to `cbp.reports`. This is the only supported way
  to lift a CBP-issued ban plus its watchlist entry together.
