<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Abstract IP Geolocation data source

This submodule is one of Smart IP's interchangeable data sources. Smart IP uses exactly one
source at a time, chosen by `smart_ip.settings:data_source`. This module contributes the source
id **`abstract_web_service`** and stores its own credentials in a separate config object.

## Activate it

1. Enable the submodule (`drush en smart_ip_abstract_web_service -y`).
2. Get an API key from abstractapi.com (the settings form links to signup).
3. Set Smart IP to use this source and store the key. In the UI: the Smart IP settings form
   (route `smart_ip.settings`, path `/admin/config/people/smart_ip`) → "Data source selection"
   → choose *Abstract IP Geolocation web service*, paste the key, save. Equivalent config:

```bash
drush config:set smart_ip.settings data_source abstract_web_service -y
drush config:set smart_ip_abstract_web_service.settings api_key 'YOUR_ABSTRACT_KEY' -y
drush config:set smart_ip_abstract_web_service.settings version 1 -y
```

Form validation (`validateFormSettings`) refuses to select this source with an empty
`abstract_api_key`, so the key is effectively required.

## Config objects & keys

| Config object | Key | Meaning |
|---|---|---|
| `smart_ip.settings` | `data_source` | must equal `abstract_web_service` for this source to run |
| `smart_ip_abstract_web_service.settings` | `version` | Abstract API version — integer, only `1` |
| `smart_ip_abstract_web_service.settings` | `api_key` | your Abstract IP Geolocation API key (required) |

Defaults shipped in `config/install`: `version: 1`, `api_key: null`.

## How a lookup works

The event subscriber `SmartIpEventSubscriber` (extends `SmartIpEventSubscriberBase`) implements
the Smart IP data-source contract. `sourceId()` returns `abstract_web_service`; `configName()`
returns `smart_ip_abstract_web_service.settings`. When Smart IP fires a location query and the
active source matches, `processQuery()` sends the visitor IP to
`AbstractWebService::V1_URL` (`https://ipgeolocation.abstractapi.com/v1/`) via `WebServiceUtility`
and maps the JSON response (`country`, `country_code`, `region`, `region_iso_code`, `city`,
`postal_code`, `latitude`, `longitude`, `timezone.name`) onto the Smart IP location object. It is
a live, per-request, billable/rate-limited HTTPS call — there is no local database and
`manualUpdate()`/`cronRun()` are intentionally empty (nothing to download).

## Implementing your own source (contract)

A concrete source is an event subscriber extending
`Drupal\smart_ip\SmartIpEventSubscriberBase` (implements `SmartIpDataSourceInterface`). It must
provide `sourceId()` and `configName()` and implement `processQuery()`, `formSettings()`,
`validateFormSettings()`, `submitFormSettings()`, `includeEditableConfigNames()`,
`manualUpdate()` and `cronRun()`. This submodule is the minimal example of that pattern.
