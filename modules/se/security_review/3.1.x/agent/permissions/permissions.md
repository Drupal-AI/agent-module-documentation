# Permissions

Defined in `security_review.permissions.yml`. Grant to **trusted users only** — the module
exposes sensitive site-security information.

| Permission | Gates | Notes |
|---|---|---|
| `access security review list` | All four module routes: the run/review page, the settings form, the per-check toggle, and the help pages. | `restrict access: true`. |
| `run security checks` | Running the security review checks. | Give only to trusted roles. |

On enable, the module posts a message reminding you to configure these at
`admin/people/permissions` before use.
