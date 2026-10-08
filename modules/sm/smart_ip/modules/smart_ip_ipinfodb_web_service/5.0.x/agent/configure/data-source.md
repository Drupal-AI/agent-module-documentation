<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the IPInfoDB data source

This submodule is one of Smart IP's interchangeable data sources. Smart IP uses exactly one
source at a time, chosen by `smart_ip.settings:data_source`. This module contributes the source
id **`ipinfodb_web_service`** and stores its own credentials in a separate config object.

## Activate it

1. Enable the submodule (`drush en smart_ip_ipinfodb_web_service -y`).
2. Get an API key from ipinfodb.com (the settings form links to signup).
3. Set Smart IP to use this source and store the key. In the UI: the Smart IP settings form
   (route `smart_ip.settings`, path `/admin/config/people/smart_ip`) → "Data source selection"
   → choose *IPInfoDB web service*, paste the key, save. Equivalent config:

```bash
drush config:set smart_ip.settings data_source ipinfodb_web_service -y
drush config:set smart_ip_ipinfodb_web_service.settings api_key 'YOUR_IPINFODB_KEY' -y
drush config:set smart_ip_ipinfodb_web_service.settings version 3 -y
```

Form validation (`validateFormSettings`) refuses to select this source with an empty
`ipinfodb_api_key`, so the key is effectively required.

## Config objects & keys

| Config object | Key | Meaning |
|---|---|---|
| `smart_ip.settings` | `data_source` | must equal `ipinfodb_web_service` for this source to run |
| `smart_ip_ipinfodb_web_service.settings` | `version` | IPInfoDB API version — `2` (has region code) or `3` (default, no region code) |
| `smart_ip_ipinfodb_web_service.settings` | `api_key` | your IPInfoDB API key (required) |

Defaults shipped in `config/install`: `version: 3`, `api_key: null`.

## How a lookup works

The event subscriber `SmartIpEventSubscriber` (extends `SmartIpEventSubscriberBase`) implements
the Smart IP data-source contract. `sourceId()` returns `ipinfodb_web_service`; `configName()`
returns `smart_ip_ipinfodb_web_service.settings`. When Smart IP fires a location query and the
active source matches, `processQuery()` builds the request URL in `WebServiceUtility` — for
`version` 2 it calls `IpinfodbWebService::V2_URL` (`http://api.ipinfodb.com/v2/ip_query.php`), for
`version` 3 `V3_URL` (`http://api.ipinfodb.com/v3/ip-city`) — and maps the JSON response
(country, country code, region, city, zip, latitude, longitude, time zone) onto the Smart IP
location object. It is a live, per-request, rate-limited HTTP call: there is no local database and
`manualUpdate()`/`cronRun()` are intentionally empty.

## Choosing the version

Pick `2` only if downstream code still needs the region code; IPInfoDB removed the region code in
`3`, which is the shipped default.
