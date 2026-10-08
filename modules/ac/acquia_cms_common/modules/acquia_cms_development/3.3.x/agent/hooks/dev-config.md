<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Development config: overrides & install

## Config override service `acquia_cms_development.config_overrider`

`Config\ConfigOverrider` implements `ConfigFactoryOverrideInterface` (tagged `config.factory.override`,
priority 5). Overrides are computed at runtime by environment — nothing is written to active config:

| Config overridden | Condition | Effect |
| --- | --- | --- |
| `acquia_search.settings` | Acquia **IDE** env AND `getenv('CONNECTOR_ID')` set | `override_search_core = <CONNECTOR_ID>.dev.orionacms` (points search at an internal dev Solr core). |
| `system.performance` | Acquia IDE env OR local env | `cache.page.max_age = 0`, `css.preprocess = false`, `js.preprocess = false` (no caching/aggregation while developing). |

`getCacheSuffix()` returns `AcmsExampleOverrider`; `createConfigObject()` returns NULL.

## `hook_install()` (`acquia_cms_development_install`)

Runs only when not syncing config. Reads environment variables and pre-configures dev integrations:

| Env var(s) | Action |
| --- | --- |
| `CONNECTOR_KEY` + `CONNECTOR_ID` | Calls internal helpers to seed `acquia_connector.settings` (subscription name "Acquia Engineering", `hide_signup_messages`) and state, and to seed `acquia_search.settings` (`api_host = https://api.sr-prod02.acquia.com`) + state. |
| `SEARCH_UUID` | Required for the Acquia Search seeding branch. |
| `SHIELD_USER` + `SHIELD_PASS` | On Acquia non-IDE envs only: installs `shield` and sets its `credentials.shield.user/pass`. |
| `GMAPS_KEY` | Sets `geocoder.geocoder_provider.googlemaps` API key, and (when cohesion is present) submits the Site Studio Google Map API key form so map elements render. |

All external hosts referenced (the Acquia Search `api_host`) are hard-coded HTTPS URLs; credentials come
from the environment, never from committed values.
