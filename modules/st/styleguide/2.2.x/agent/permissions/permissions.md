<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Style guide permission

From `styleguide.permissions.yml`:

| Permission | Gates | Notes |
|---|---|---|
| `view style guides` | Access to all style guide pages: `styleguide.page`, `styleguide.maintenance_page`, and every dynamic per-theme route `styleguide.<theme>` / `styleguide.maintenance_page.<theme>`. | `restrict access: false` (it only exposes themed sample markup, not real data). |

Grant it to front-end developer / themer roles. Example:

```php
use Drupal\user\Entity\Role;
$role = Role::load('developer');
$role->grantPermission('view style guides')->save();
```

There are no other permissions — the module has no data-mutating operations.
