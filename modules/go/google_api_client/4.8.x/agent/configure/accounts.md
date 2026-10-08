<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: accounts, settings, config objects

All routes require the permission `administer google api settings` (the only permission this
module defines; `restrict access: TRUE`).

## Settings page (configure route)

`google_api_client.google_api_client_settings` → `/admin/structure/google_api_client_settings`.
A single **Scan Library** button: it runs `_google_api_client_read_scope_info()`, which reads
the installed `google/apiclient` library + discovery API to enumerate available services/scopes
and caches them into two config objects:

- `google_api_client.google_api_services` — key `google_api_client_google_api_services` (service
  name list; type `ignore`).
- `google_api_client.google_api_classes` — key `google_api_client_google_api_classes` (service →
  `Google\Service\*` class map).

These populate the allowed-value option lists on the account forms (`services` / `scopes` use
`allowed_values_function` `google_api_client_google_services_names` / `..._scopes_names`). Run
Scan Library (or `drush cr`) after installing/updating the library.

## OAuth accounts — `google_api_client` (content entity)

Collection `/admin/config/services/google_api_client`, add at `.../add`. Stored in DB table
`google_api_client`. Fields: `name` (label, required), `developer_key`, `client_id` (required),
`client_secret` (required), `services` (multi), `scopes` (multi), `is_authenticated` (read-only),
`uid` (owner). The **access token is not a field** — it is kept in the State API and refreshed
automatically. Each account row shows an **Authenticate** link (starts the OAuth2 consent flow
via `google_api_client/callback`) or a **Revoke** link once authenticated.

Create programmatically:

```php
use Drupal\google_api_client\Entity\GoogleApiClient;
$account = GoogleApiClient::create([
  'name' => 'My Google account',
  'client_id' => '...apps.googleusercontent.com',
  'client_secret' => '...',
  'developer_key' => '...',
  'services' => ['calendar'],
  'scopes' => ['https://www.googleapis.com/auth/calendar'],
]);
$account->save();
```

## Service accounts — `google_api_service_client` (config entity)

Collection `/admin/config/services/google_api_service_client`. This is a **config entity**
(`config_prefix: google_api_service_client`, so config `google_api_client.google_api_service_client.<id>`),
`admin_permission: administer google api settings`. Exported keys:

| Key | Meaning |
|---|---|
| `id` | machine name |
| `label` | human label |
| `auth_config` | the service-account **JSON key** (string) |
| `services` | sequence of service names |
| `scopes` | sequence of scope strings |

For server-to-server calls with no interactive consent. Create programmatically:

```php
use Drupal\google_api_client\Entity\GoogleApiServiceClient;
GoogleApiServiceClient::create([
  'id' => 'my_service_account',
  'label' => 'My service account',
  'auth_config' => file_get_contents('/path/to/service-account.json'),
  'services' => ['drive'],
  'scopes' => ['https://www.googleapis.com/auth/drive.readonly'],
])->save();
```

Read back: `drush config:get google_api_client.google_api_service_client.my_service_account`.

Both entity collections and the settings page all sit behind `administer google api settings`.
Making real Google API requests additionally needs valid Google credentials.
