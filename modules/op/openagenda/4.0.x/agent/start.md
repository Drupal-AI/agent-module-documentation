<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OpenAgenda — agent index

Integrates the **OpenAgenda** event platform — import/display events (listings, single event
pages, filtering) from an OpenAgenda agenda identified by its UID. Depends on `node`, `field`,
`serialization`; config at `openagenda.form` (`/admin/config/services/openagenda`).
Version **4.0.0**. Core `^10.4 || ^11`.

Requires the Composer library `openagenda/sdk-php >= 1.3.1` (all API traffic goes through the SDK
to `api.openagenda.com`). Ships an OpenAgenda field (widget + formatter), a default `openagenda`
content type, and block-based filters (map, calendar, cities, keywords, favorites, relative date,
text search, additional field, sort, submit, total, active filters) plus event map and timetable
blocks. Filters use the OpenAgenda react-filters widget (Bootstrap CSS + react-filters loaded from a
CDN) driven through the module's own AJAX endpoints.

Configuration stores an OpenAgenda account **public key** (plain module config; used only
server-side by the SDK). Single permission: `administer openagenda`. Event data comes from the
external OpenAgenda service, so display availability depends on it.

## Diff 3.4.x → 4.0.x

- **Core requirement narrowed (BC break):** `^8.8 || ^9 || ^10 || ^11` → `^10.4 || ^11`. Drops
  Drupal 8, 9 and 10.0–10.3.
- **New hard Composer dependency (BC break):** `openagenda/sdk-php >= 1.3.1`. 3.x had no
  third-party Composer library requirement; 4.x routes every request through the SDK
  (`OpenAgendaSdk`), built by `OpenagendaSdkFactory` from the stored public key plus Drupal's
  `http_client_config` settings.
- **Terminology:** the settings field is now the OpenAgenda **public key** (was described as an
  "API key"). It is a read/public account key, kept server-side.
- **New settings:** search-relevance `threshold` (Off / Auto / Custom score, mirrored per-agenda on
  the field widget), `manual_submit` (disable auto-search on filter change), `daterange_simple`,
  `oac_enabled` (navigation-context prev/next links), `tracking_enabled` (sends `cms=drupal` + site
  host to OpenAgenda for usage stats), `include_embedded`, `current`, plus map/search placeholder
  defaults.
- **Autowired services** (`_defaults: autowire`), SDK factory, and a param converter
  (`openagenda_event`), inbound/outbound path processor, agenda/event processors.
- Route/permission surface otherwise stable: `openagenda.form` (needs `administer openagenda`);
  `openagenda.event`, `openagenda.ajax`, `openagenda.filters` all require `access content` +
  `_entity_access: node.view`.
