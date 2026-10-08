# Permissions

Defined in `matomo.permissions.yml`:

| Permission | Machine name | Gates | Notes |
|---|---|---|---|
| Administer Matomo | `administer matomo` | The settings form and maintenance tasks. | `restrict access: true`. |
| Opt-in or out of tracking | `opt-in or out of matomo tracking` | Lets a user decide (on their account) whether tracking code is added for them. Only meaningful when a per-user visibility mode is set. | Safe for authenticated users. |
| Use PHP for tracking visibility | `use php for matomo tracking visibility` | Entering PHP code to compute tracking visibility. | `restrict access: true` — arbitrary PHP. |
| Add JavaScript snippets | `add js snippets for matomo` | Entering the before/after custom JS snippets on the settings form. | `restrict access: true`. |

Grant at **People → Permissions** (`/admin/people/permissions`). Keep the three restricted
permissions to fully trusted administrators.
