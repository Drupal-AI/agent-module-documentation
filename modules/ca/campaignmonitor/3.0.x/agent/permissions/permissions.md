# Campaign Monitor — permissions

From `campaignmonitor.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer campaignmonitor` | All admin routes: settings form, lists overview, list enable/disable/edit/delete, cache clear. Treat as trusted admin. |
| `access archive` | View the newsletter archive. |
| `join newsletter` | Join newsletters. |

Submodule permissions:
- `campaignmonitor_registration`: `access campaignmonitor registration` (`restrict access: TRUE`) — show list opt-in on the registration page.
- `campaignmonitor_user`: `access campaign monitor user` — access the per-user subscription page/tab (`/user/{user}/campaignmonitor`).

Note: the subscribe **block** itself is not gated by a module permission — its visibility is controlled by
normal Drupal block placement/visibility. It is intended to be shown to anonymous visitors.
