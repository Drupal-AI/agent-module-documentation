<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings form & config object

## Install / enable

```
composer require drupal/unstructured
drush en unstructured -y
```

Pulls `drupal/key` (`^1.18`). `ai:ai_automators` (from `drupal/ai`) is a test dependency — enable it
only if you want the four AI Automator plugins; the `unstructured.api` service and formatters work
without it.

## Route & form

- Route `unstructured.settings` → `/admin/config/unstructured/settings`, form
  `\Drupal\unstructured\Form\UnstructuredConfigForm` (`unstructured.routing.yml`).
- Requirement `_permission: 'administer site configuration'`.
- Menu link `unstructured.settings_menu` under `system.admin_config_services`
  (Configuration → Development/Services).
- `info.yml` `configure: unstructured.settings` puts a *Configure* link on the modules page.

## Config object `unstructured.settings`

`UnstructuredConfigForm::CONFIG_NAME = 'unstructured.settings'`. Two keys, written by
`submitForm()`; the module ships **no** `config/install` defaults and **no** `config/schema`
(both keys are unset until the form is first saved).

| Key | Form element | Meaning |
|-----|--------------|---------|
| `api_key` | `#type => 'key_select'` (from the Key module) | Stores the **id of a Key entity**, not the secret itself. Needed for the hosted `api.unstructuredapp.io`; leave empty for a self-hosted/DDEV container. |
| `host` | `#type => 'textfield'` | Base host of the Unstructured API, e.g. `https://api.unstructuredapp.io` (default), an org Base URL, or `http://unstructured:8000` for the DDEV add-on. Host only — no path/trailing slash. |

`validateForm()` runs `parse_url($host)` and rejects any value whose `path` is non-empty (a bare `/`
or a real path) so only a scheme+host is stored.

## How the values are consumed

`UnstructuredApi::__construct()` reads `unstructured.settings`: it takes `api_key`, and if set
resolves the secret with `keyRepository->getKey($id)->getKeyValue()`; `host` falls back to
`https://api.unstructuredapp.io` when empty. See [../api/service.md](../api/service.md).

## Backends

- **Hosted SaaS** — set `host` to your Unstructured URL and select a Key holding the API key.
- **Self-hosted / DDEV** — run the `unstructured-api` container (README gives a
  `docker-compose.unstructured.yaml` recipe), set `host` to e.g. `http://unstructured:8000`, leave
  `api_key` empty.
