# Configuration

Configuring this module is mostly one thing: **set a shared secret**, and then
register the same secret (and this site's URL) in the central Status Dashboard
site.

## Set the shared secret (do this first)

1. Log in as a user with the **Administer status_dashboard_client configuration**
   permission.
2. Go to **Configuration → Development → Status dashboard client**
   (`/admin/config/development/status-dashboard-client`).
3. Enter a long, random string in the **Secret** field and save. This value is
   stored in `status_dashboard_client.settings:secret`.

Or set it from the command line:

```bash
drush config:set status_dashboard_client.settings secret 'SOME-LONG-RANDOM-STRING' -y
```

The endpoint's access check compares the secret in the incoming request header
against the stored secret. The module ships with no secret set, so set one after
enabling. You can rotate the secret at any time by editing this one field.

## The reporting endpoint

The module adds one endpoint:

- **URL:** `/status_dashboard/check` (route `status_dashboard_client.check`),
  `GET` only, and never cached.
- **Access:** the caller must send an HTTP header
  **`x-dashboard-secret: <your secret>`** matching the value you saved. There's no
  permission on this route; the shared secret is the gate.

On a matching request the module runs core's Update Manager and returns a JSON
document with these keys:

| Key | What it contains |
|-----|------------------|
| `date` | The current timestamp. |
| `core` | The Drupal core version. |
| `modules` | A map of module display name → version, for every extension in the list. |
| `security_updates` | Projects with pending **security** updates → recommended version. |
| `feature_updates` | Projects with a newer recommended (non-security) release → recommended version. |
| `sitename` | The site name. |
| `url` | The site's scheme and host. |
| `error_count` | The number of status-report requirement **errors** (severity above warning). |

## Connect the central dashboard

On your separate **Status Dashboard** monitoring site, register this client with
its base URL and the **same secret** you set above. The dashboard then polls
`/status_dashboard/check` on a schedule, aggregating each client's update and
security status and — if you've configured it there — emailing daily/weekly/monthly
notifications. Reporting is pull-based: the dashboard fetches from each client; the
client never pushes.

## Extending the payload (optional, for developers)

Modules can add to or adjust the JSON before it's returned, via
`hook_status_dashboard_json_response_alter(&$json_response, $projects_data)` — for
example to append the PHP version or the last cron run time. Keys you add appear
verbatim in the JSON, so keep them JSON-serializable. See the sibling
[`agent/`](../agent/hooks/alter.md) docs for an example.
