# Permissions

Defined in `readonlymode.permissions.yml`:

| Permission | Gates |
|---|---|
| `readonlymode access forms` | **Bypass the lock.** Users with it can submit any form even while Read Only Mode is enabled (treated as trusted). `_readonlymode_form_check()` returns TRUE for them. |
| `readonlymode access messages` | **See the notices.** Controls who is shown the on-page warning and the rejected-submission error; users with it also get an admin "site is in Read Only" message. |

Grant to a role:

```bash
drush role:perm:add administrator 'readonlymode access forms'
drush role:perm:add editor 'readonlymode access messages'
```

Typical setup: give administrators `readonlymode access forms` so they can keep editing during a
freeze, and give staff `readonlymode access messages` so they understand why submissions are
blocked, while anonymous users get neither.
