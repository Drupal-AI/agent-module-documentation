# Facet Bot Blocker permissions

From `facet_bot_blocker.permissions.yml`:

| Permission | Gates | Notes |
|---|---|---|
| `administer facet bot blocker` | The settings form `/admin/config/system/facet-bot-blocker` | `restrict access: true` — trusted admins only. |
| `access facet bot blocker dashboard` | The metrics dashboard `/admin/reports/facet-bot-blocker` | Read-only reporting. |
| `bypass facet bot blocker` | Exemption from blocking | A user with this permission is returned early from the subscriber and is **never** blocked, regardless of facet depth. Give it to authenticated/staff roles that legitimately browse deep facets, or to keep logged-in editors unaffected. |

No permission is granted by default. The blocking itself needs no permission — it applies to
every non-bypassing visitor (including anonymous crawlers), which is the point.
