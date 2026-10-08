# Permissions — HubSpot

Defined in `hubspot.permissions.yml`:

| Permission | `restrict access` | Gates |
|---|---|---|
| `view recent hubspot leads` | **TRUE** | Viewing the recent-leads block (`HubspotBlock`, `src/Plugin/Block/HubspotBlock.php`) when it is placed and enabled. Marked restricted because it exposes CRM contact data pulled from HubSpot. |

## Route access (not module-defined permissions)
- `hubspot.admin_settings` (`/admin/config/services/hubspot`) and `hubspot.oauth_connect`
  (`/hubspot/oauth`) require the core permission **`administer site configuration`**.
- `hubspot.form_settings` (`/node/{node}/webform/hubspot`) requires **`bypass node access` AND
  `access content`** (the `+` in `bypass node access+access content` is an AND). This is the
  legacy per-node tab whose form class is missing in 3.0.x — see the configure doc.

There is no separate permission for adding the Webform handler; that is governed by Webform's own
"administer webform" / per-webform access.
