# cleantalk — permissions

The module defines **one** permission (`cleantalk.permissions.yml`):

| Permission | Machine name | Gates | Notes |
|---|---|---|---|
| Changing CleanTalk settings | `change cleantalk settings` | The settings form (route `cleantalk.settings`) and the module's admin menu page (route `cleantalk.admin`) | `restrict access: TRUE` — treated as a security-sensitive permission |

Grant it with Drush:

```bash
drush role:perm:add administrator 'change cleantalk settings' -y
```

## Related core permission (not defined here)

The retroactive-scan screens — **Check spam users** (`cleantalk.check_users`) and
**Check spam comments** (`cleantalk.check_comments`), plus their delete/clear POST routes —
require the core **`administer site configuration`** permission, *not* the module's own
`change cleantalk settings`. So an editor allowed to change CleanTalk settings still cannot
run the bulk spam-user/comment cleanup unless they also have site-configuration access.
