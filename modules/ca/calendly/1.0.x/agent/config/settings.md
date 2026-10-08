<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Embed Calendly — configuration, routes & block generation

Everything in this module lives under `/admin/config/calendly` and is gated by the (undefined)
permission `administer calendly configuration`. Source: `calendly.routing.yml`,
`src/Form/ApiConfigurationForm.php`, `src/Controller/DataController.php`,
`calendly.links.menu.yml`, `calendly.links.action.yml`.

## Install / enable

```
composer require drupal/calendly   # (project ships no composer.json; require by project name)
drush en calendly -y
```

Also enable core **Block Content** (`drush en block_content -y`) and make sure a **basic** block
type exists — the module creates `block_content` "basic" blocks but does not declare the dependency.

## Access (important)

All four working routes require `_permission: 'administer calendly configuration'`. The module ships
**no `calendly.permissions.yml`**, so this permission is never defined. Consequences:

- It cannot be granted to any role through the UI (it does not appear on `/admin/people/permissions`).
- `hasPermission()` returns FALSE for every account, so the pages fail closed — reachable **only by
  uid 1** (the super-user, who bypasses all permission checks).

The index route `calendly.admin_index` (`/admin/config/calendly`) instead uses core
`access administration pages` and just renders the admin-menu block.

## Config form — `ApiConfigurationForm`

- Route `calendly.admin_settings` → `/admin/config/calendly/api`; form id `calendly_admin_settings`;
  extends `ConfigFormBase`; editable config = `calendly.settings`.
- Fields (built in `buildForm()`):
  - `api_key` — `textarea`, required. The Calendly **personal access token / API key** (used as a
    bearer token). Copy from `https://calendly.com/integrations/api_webhooks`.
  - `org_id` — `textfield`, required. Your Calendly **organization id** (the org URI/id used as the
    `organization` query parameter).
- `submitForm()` writes both values into `calendly.settings` (`->set('api_key', …)`,
  `->set('org_id', …)`). The values are held in the config object and used to authenticate the
  Calendly API call in `fetchdata()`.

## Config object `calendly.settings`

| Key | Set by | Meaning |
|-----|--------|---------|
| `api_key` | config form | Calendly API bearer token |
| `org_id` | config form | Calendly organization id |
| `events_info` | `fetchdata()` | Raw JSON string of the last `event_types` API response |

No `config/schema/` is shipped, so these keys are untyped/schemaless (config-inspector will warn).

## Fetch / sync — `DataController::fetchdata()`

- Route `calendly.fetchdata` → `/admin/config/calendly/fetchdata`; exposed as the **"Event Sync"**
  local action on the events-list page (`calendly.links.action.yml`).
- Reads `api_key` + `org_id` from `calendly.settings`, then via raw **cURL**:
  `GET https://api.calendly.com/event_types?organization={org_id}&count=20`, header
  `Authorization: Bearer {api_key}`, `Content-Type: application/json`, `CURLOPT_TIMEOUT => 30`,
  `CURLOPT_RETURNTRANSFER => TRUE`. Standard cURL TLS verification is left at its secure default
  (no `CURLOPT_SSL_VERIFYPEER` override).
- Stores the raw response into `calendly.settings:events_info` (`getEditable(...)->set(...)->save()`),
  shows a messenger message ("Updated Event list") or, on cURL error, `echo`es the error and adds an
  error message, then `RedirectResponse` to `calendly.eventslist`.
- Note: this action writes `events_info` and performs the outbound API call on request. Reachable
  only by uid 1 per the access note above.

## Events list — `DataController::eventslist()`

- Route `calendly.eventslist` → `/admin/config/calendly/eventslist`.
- `json_decode(events_info)` → builds a `#type => table` with columns name / scheduling_url /
  created_at / type / type description / event type / link, plus a `#type => pager`.
- Each row's `#markup` is a **"Generate Block"** link to `calendly.generateblock` with the event's
  `name` and `scheduling_url` **base64-encoded** into the path args. If `events_info` is empty it
  prints "Currently No Events are available, please check the Api Key."

## Generate block — `DataController::generateblock($id, $url)`

- Route `calendly.generateblock` → `/admin/config/calendly/generateblock/{id}/{url}`.
- base64-decodes `{id}` → block **label** (`info`) and `{url}` → the scheduling URL, then creates a
  `block_content` entity of type **basic**, langcode `en`, whose `body.value` is the Calendly
  inline-widget snippet and `body.format` = **`full_html`**:
  ```
  <div class="calendly-inline-widget" data-url="{decoded-url}"></div>
  <script src="https://assets.calendly.com/assets/external/widget.js" async></script>
  ```
- Saves the block, shows "Block Created Successfully!", redirects to the events list. This action
  creates a custom block entity on request (uid-1-only in practice).
- The created block is a normal custom block — place it via **Block Layout** (`/admin/structure/block`)
  or reference it wherever custom blocks are usable.

## Operating it (typical flow)

1. As uid 1, open `/admin/config/calendly/api`, paste the Calendly API key + organization id, save.
2. Go to `/admin/config/calendly/eventslist`, click **Event Sync** to pull event types.
3. Click **Generate Block** on the desired event → a `full_html` custom block is created.
4. Place that block through Block Layout; visitors then see the Calendly inline widget.

## Menu / actions

- `calendly.links.menu.yml`: "Calendly" under Configuration (`system.admin_config`), plus child links
  "Calendar Api Key" (the settings form) and "Calendly Event List".
- `calendly.links.action.yml`: "Event Sync" action, `appears_on: calendly.eventslist`.
