# Permissions

Defined in `analytics.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer analytics` | The entire admin UI: adding/editing/deleting `analytics_service` entities, enabling/disabling them, and the shared `analytics.settings` form. It is the config entity `admin_permission`. |
| `bypass all analytics services` | Holders are excluded from all tracking output — `ServicePluginBase::canTrack()` returns FALSE for them, so no service snippet renders on their requests. |

Notes:
- `administer analytics` is a standard site-administration permission. The tracking snippets an
  admin authors (GTM containers, data-layer JSON, service URLs) are, by design, JavaScript
  injected on every front-end page — this is the module's purpose, not a trust-boundary crossing;
  grant it only to trusted administrators.
- `bypass all analytics services` is a read-only "opt me out" capability (e.g. for staff whose
  visits should not be tracked); it grants no administrative power.
