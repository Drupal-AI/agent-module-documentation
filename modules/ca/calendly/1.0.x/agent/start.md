<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Embed Calendly (calendly) — agent index

Admin-only integration that stores a **Calendly API key + organization id**, syncs your Calendly
**event types** via the Calendly REST API, and one-click generates a **custom block** containing the
Calendly inline-widget embed for a scheduling page. Package `Calendly`. Core requirement
`^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.3 (dir `1.0.x`).

No composer requirements, **no declared module dependencies** (but it uses core **`block_content`**
at runtime — see caveats). No fields, formatters, plugins, Drush, hooks, `.module`/`.install`, or
`config/schema`.

- **Config form, routes, the fetch/sync flow, block generation, and how to operate it** →
  [config/settings.md](config/settings.md)

## What it actually is (from source)

- One config form: `Form\ApiConfigurationForm` (`ConfigFormBase`, form id `calendly_admin_settings`)
  at route `calendly.admin_settings` → **`/admin/config/calendly/api`**. Two fields, `api_key`
  (textarea) and `org_id` (textfield), saved into config object **`calendly.settings`**.
- One controller: `Controller\DataController` (extends `ControllerBase`, injects core `http_client`)
  with three actions:
  - `fetchdata()` — route `calendly.fetchdata` (`/admin/config/calendly/fetchdata`). Uses raw
    **cURL** to `GET https://api.calendly.com/event_types?organization={org_id}&count=20` with header
    `Authorization: Bearer {api_key}`, stores the raw response JSON into `calendly.settings:events_info`,
    then redirects to the events list.
  - `eventslist()` — route `calendly.eventslist` (`/admin/config/calendly/eventslist`). Decodes
    `events_info` and renders a `#type => table` of event types, each row carrying a "Generate Block"
    link.
  - `generateblock($id, $url)` — route `calendly.generateblock`
    (`/admin/config/calendly/generateblock/{id}/{url}`). base64-decodes the two path args and creates
    a `block_content` **basic** block with a **full_html** body holding the Calendly inline-widget
    snippet, then redirects.
- Menu/actions: `calendly.links.menu.yml` (Configuration → Calendly, plus the API-key form and event
  list) and `calendly.links.action.yml` ("Event Sync" action on the events list). Index route
  `calendly.admin_index` (`/admin/config/calendly`) is a system admin-menu block page.

## Routes & access

- All four functional routes (`admin_settings`, `fetchdata`, `eventslist`, `generateblock`) require
  `_permission: 'administer calendly configuration'`. **The module ships no `*.permissions.yml`, so
  that permission is undefined** — no role can hold it and it fails closed to everyone except uid 1
  (the super-user, who bypasses permission checks). In practice only the Drupal root user can reach
  these pages. The index route uses core `access administration pages`.

## Config object

- **`calendly.settings`** — keys: `api_key` (Calendly API bearer token, set on the config form),
  `org_id` (Calendly organization id), `events_info` (raw JSON string of the last event-types
  API response). No `config/schema/` ships (config is schemaless / untyped).

## Caveats

- Uses `\Drupal\block_content\Entity\BlockContent` and creates a **basic** block, but `block_content`
  is **not declared** as a dependency in `calendly.info.yml`; if `block_content` (or a `basic` block
  type) is absent, `generateblock()` fails. Enable Block Content and ensure a `basic` block type.
- `fetchdata()` also `echo`es the cURL error string directly on failure (before the redirect).
- The whole feature set is admin/uid-1 only; there is no visitor-facing route — visitors only ever see
  the generated block once you place it via Block Layout.
