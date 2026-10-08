<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

Two config objects, two admin routes, one permission (`administer meta_conversions_api`).

## `meta_conversions_api.settings`
Schema `config/schema/meta_conversions_api.schema.yml`. UI at
`/admin/config/system/meta-conversions-api` (route `meta_conversions_api.settings`, form
`SettingsForm`). Defaults from `config/install/meta_conversions_api.settings.yml`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enabled` | bool | `0` | Master off switch. When false, no events are sent (`MetaClient::isEnabled()` returns false; the SDK is not even initialised unless this is true and a token exists). |
| `access_token` | string | `''` | Meta Graph API access token (Page/User token). **Required** in the form. Stored in plaintext in config. |
| `pixel_id` | string | `''` | Meta pixel/dataset ID. **Required**. Used as the target of `EventRequest($pixel_id)` → `graph.facebook.com/v15.0/{pixel_id}/events`. |
| `default_action_source` | string | `website` | Options come from the SDK's `ActionSource::getValues()`. Applied by callers that read it; `sendRequest()` itself defaults an unset `action_source` to `website`. |
| `test_event_code` | string | `''` | Meta Events Manager test code ("TEST1234"). If set, every event is sent as a test event. |
| `enable_logging` | bool | `0` (not in install config) | Turns on the Facebook SDK logger (`FacebookLogger`), which writes request and response params to the Drupal log channel `meta_conversions_api`. Leave off in production. |

Set via drush (read/verify only on shared sites):
```
drush config:get meta_conversions_api.settings
```

## `meta_conversions_api.events`
Written by `EventsForm` at `/admin/config/system/meta-conversions-api/events` (route
`meta_conversions_api.events`). No install file — created on first save.

| Key | Type | Meaning |
|---|---|---|
| `event_toggles` | mapping (name → bool) | Per-event enable flags. Default behaviour: any event not explicitly set to false is enabled. `MetaClient::isEventEnabled()` only blocks an event whose toggle is explicitly false. New events appear here after a cache clear (names are cached under `meta_conversions_api_event_names`). |

## Menu / tasks
- `meta_conversions_api.links.menu.yml` — admin-config link (note: its machine key is
  `meta_conversions_apis.settings`, a stray plural, but it points at the correct route).
- `meta_conversions_api.links.task.yml` — "Settings" and "Events" local tabs under the settings route.

## Access
Both forms require `administer meta_conversions_api` (`meta_conversions_api.permissions.yml`). Both
routes are `_admin_route: TRUE`. Standard Drupal form CSRF protection applies.
