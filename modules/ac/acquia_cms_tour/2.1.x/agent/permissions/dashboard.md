<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `acquia_cms_tour.permissions.yml`:

| Permission | Title | Gates |
|---|---|---|
| `access acquia cms tour dashboard` | Access the Acquia CMS tour dashboard page | The dashboard route `acquia_cms_tour.enabled_modules` (`/admin/tour/dashboard`) and the two welcome/starter modal routes. |

The permission is **not** flagged `restrict access: true`.

`hook_content_model_role_presave_alter()` (in `.module`) auto-grants this permission to the
`content_administrator` role when that role is (re)saved by the Acquia CMS content-model tooling.

Grant it with drush:

```bash
drush role:perm:add content_editor 'access acquia cms tour dashboard'
```

Note the two wizard routes (`acquia_cms_tour.installation_wizard`,
`acquia_cms_tour.selection_wizard`) are gated by core's `access content` instead of this permission —
see [configure/dashboard.md](../configure/dashboard.md) for the full route table.

Install history: `acquia_cms_tour_update_8002()` removed a legacy `access acquia cms tour`
permission from all roles; that permission no longer exists.
