# Permissions — moderation_dashboard

Defined in `moderation_dashboard.permissions.yml`:

| Permission | Gates |
|---|---|
| `use moderation dashboard` | Access to **your own** moderation dashboard (`user/{your uid}/moderation-dashboard`). Also controls whether the "Moderation Dashboard" link is injected into the user toolbar menu, and whether the post-login redirect fires. |
| `view any moderation dashboard` | Access to **other users'** dashboards, for editorial oversight. |

The config form at `/admin/config/people/moderation_dashboard` is gated separately by the
core `administer site configuration` permission (not by these two).

## How access is computed

`Drupal\moderation_dashboard\Access\ModerationDashboardAccess::access()` (service
`moderation_dashboard.access_checker`, access check id `_access_moderation_dashboard`) is
attached to the Views page by the custom Views access plugin
(`Drupal\moderation_dashboard\Plugin\views\access\ModerationDashboard`, id
`moderation_dashboard`). Logic, keyed on the `{user}` route parameter (the dashboard owner):

1. Viewing **your own** dashboard **and** you have `use moderation dashboard` → allowed.
2. If the dashboard owner has neither `use moderation dashboard` nor
   `view any moderation dashboard` → forbidden (that user has no dashboard).
3. If the viewer has `view any moderation dashboard` → allowed (can view others).
4. Otherwise → forbidden.

Access is cached per `user` cache context.

### Grant with drush

```bash
drush role:perm:add editor 'use moderation dashboard'
drush role:perm:add editor 'view any moderation dashboard'   # oversight of others
```
