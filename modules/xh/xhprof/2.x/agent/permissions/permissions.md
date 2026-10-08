# Permissions & route gating

Defined in `xhprof.permissions.yml`:

| Permission | Title | `restrict access` | Grants |
|---|---|---|---|
| `administer xhprof` | Administer xhprof profiling settings | **true** | The settings form `xhprof.admin_configure` (and, as one OR-branch, the report routes). |
| `access xhprof data` | Access XHProf data | *(not set → grantable to any role)* | Viewing collected profiles, and receiving the injected front-end "XHProf output" link. |

## How the routes gate

- `xhprof.admin_configure` requires **`administer xhprof`** only.
- `xhprof.runs`, `xhprof.run`, `xhprof.symbol`, `xhprof.diff` require
  `_permission: 'access xhprof data+administer xhprof'`. In Drupal routing the **`+` is OR** (comma
  would be AND), so a user needs **either** `access xhprof data` **or** `administer xhprof` to reach
  the report UI.
- The response link injection (`XHProfEventSubscriber::onKernelResponse`) is shown only to accounts
  where `$currentUser->hasPermission('access xhprof data')` is TRUE.

## Notes for operators

- `access xhprof data` is **not** marked `restrict access: true`, yet it exposes profiling output
  (function names, call graph, the profiled request path, timings). Treat it as a trusted-developer
  permission and grant it narrowly; do not hand it to untrusted authenticated roles.
- Profiling itself runs for **every** non-excluded request when `enabled` is TRUE, regardless of the
  requesting user's permissions — the permission only controls *viewing*. Keep `enabled` off in
  production (it is off by default).
