# Permissions

Defined in `styleswitcher.permissions.yml`.

| Permission | Machine name | Grants |
| --- | --- | --- |
| Administer Style Switcher | `administer styleswitcher` | Access to all admin routes: the global settings form, per-theme arrangement, and add/edit/delete of custom styles. |

Notes:
- Every admin route in `styleswitcher.routing.yml` requires `_permission: 'administer styleswitcher'`.
  Treat it as an administrative permission — it lets a user define CSS paths/URLs that are loaded into
  the page for all visitors.
- The **visitor-facing switching** is intentionally **not** gated by any permission: the runtime routes
  `styleswitcher.switch` and `styleswitcher.css` require only the core `_access_theme: 'TRUE'` check
  (the `{theme}` must be a real, installed theme). Choosing a stylesheet is not a privileged act, and
  the chosen style name is always resolved against the defined styles before use.
