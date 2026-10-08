<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions & output visibility

The module defines one permission (`kint.permissions.yml`):

| Permission | Notes |
|---|---|
| `access kint dumps` | title "View kint output"; `restrict access: TRUE` (dev-sensitive) |

## When Kint output is actually shown

1. **Before authentication:** governed by the `early_enable` setting (`kint.settings`). If off,
   dumps produced early are suppressed.
2. **After authentication:** the `kint.event_subscriber` (`KintEventSubscriber`) checks
   `access kint dumps` on the current user; without it, dump output is hidden.
3. **Via Devel:** when Kint is selected as the Devel dumper, **Devel's** permissions apply
   instead.
4. **Twig dumps:** additionally require Twig development mode
   (`Configuration → Development settings`).

The settings form itself renders a live demo dump of the Kint config — if you see nothing there,
your role is missing `access kint dumps` (or early_enable/permissions are blocking it).

Grant it like any permission:

```bash
drush role:perm:add developer 'access kint dumps'
```
