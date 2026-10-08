# Permissions

Defined in `search_api_fusion.permissions.yml`.

| Permission (title) | Machine name | Grants |
|---|---|---|
| Send signals to any Fusion server | `send signals to any fusion server` | Access to the click-signal route `search_api_fusion.signal.click`, and lets the `fusion_request_signal` processor send a request signal for this user's searches. |

A single permission covers **all** Fusion servers (the module's own comment notes this could later be split
to one-permission-per-server). It is a normal, non-admin permission with no default grant — grant it only to
the roles whose searches should feed Fusion's ranking (per the README this may include the anonymous role if
you want anonymous searches to generate signals). Two places check it:

- Route requirement `_permission: 'send signals to any fusion server'` on the click endpoint
  (`search_api_fusion.routing.yml`).
- `RequestSignal::postprocessSearchResults()` returns early unless `currentUser` has it.
