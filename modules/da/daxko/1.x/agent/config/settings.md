<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Daxko — configuration & settings form

## Install / enable

```
drush en daxko -y
```

Pulls in hard deps `openy_socrates` and `openy_mappings` (both are Open Y / YMCA Website
Services modules; Daxko is meant to run inside that distribution). No composer requirements,
no external libraries — the HTTP client is core Guzzle.

## Config object: `daxko.settings`

Default install values (`config/install/daxko.settings.yml`) are all empty strings:

| Key | Meaning | Form element (`Form\SettingsForm`) |
|---|---|---|
| `client_id` | Daxko account id (a short number, e.g. `1234`); appended to the base URI as a path segment | `#type => textfield` |
| `base_uri` | Daxko API base URI, e.g. `https://api.daxko.com/v1/` | `#type => url` |
| `user` | Daxko API username (HTTP Basic-auth user) | `#type => textfield` |
| `pass` | Daxko API password (HTTP Basic-auth password) | `#type => password` |

There is **no** `config/schema/*` file in this module, so these keys are untyped (declare a
schema if you extend it). `provides_config_schema` is therefore false.

## Settings form

- Class: `Drupal\daxko\Form\SettingsForm` (extends `ConfigFormBase`), form id
  `daxko_admin_settings`, editable config `daxko.settings`.
- Route: `daxko.settings`, path `/admin/openy/integrations/daxko/daxko`, requirement
  `_permission: 'administer daxko'`.
- Menu link `daxko.admin` ("Daxko settings") sits under
  `openy_system.openy_integrations_daxko`, weight 100.
- `buildForm()` disables form caching (`$form_state->setCached(FALSE)`) and groups `user`/`pass`
  in an `auth_fieldset`.
- `submitForm()` details worth knowing:
  - `base_uri`: if the entered value has no `http(s)://` scheme it is prefixed with `https://`
    (via `preg_match("#https?://#", …)`), then it is stored as `rtrim($base_uri,'/') . '/'`.
    An explicitly `http://` value is preserved as entered.
  - `pass`: the password field has no `#default_value` (so the stored secret is never rendered
    back into the form). On submit, an **empty** `pass` falls back to the previously stored
    value — i.e. leaving it blank keeps the existing password rather than clearing it.

## Permission

- `administer daxko` (`daxko.permissions.yml`) — gates the settings form only.

## How the config is consumed

`DaxkoClientFactory::get()` reads `daxko.settings` and builds the Guzzle client base URL as
`base_uri . client_id . '/'`, with `auth => [user, pass]` (HTTP Basic) and
`Accept: application/json`. See [../api/client-and-datawrapper.md](../api/client-and-datawrapper.md).
