<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions and the admin page

## `social_api.permissions.yml`

| Permission | Title | Gates |
|---|---|---|
| `administer social api configuration` | Administer Social API admin configuration | the `social_api.admin_config` route (`/admin/config/social-api`) |
| `administer social api authentication` | Administer Social API user authentication | Social Auth implementer settings pages |
| `administer social api autoposting` | Administer Social API autoposting | Social Post implementer settings pages |
| `administer social api blocks` | Administer Social API blocks | block-providing implementers |
| `administer social api widgets` | Administer Social API widgets | Social Widgets implementer settings pages |

Only the first one is used by a route inside this module; the other four exist for
implementer modules to reference in their own `routing.yml`.

## Route

```yaml
social_api.admin_config:
  path: '/admin/config/social-api'
  defaults:
    _controller: '\Drupal\system\Controller\SystemController::systemAdminMenuBlockPage'
    _title: 'Social API'
  requirements:
    _permission: 'administer social api configuration'
```

It is core's generic "menu block page" controller, so the page simply lists the child menu
links that implementer modules register under it. The menu link
`social_api.admin_config` ("Social API settings") is attached to `system.admin_config`.
`social_api.info.yml` sets `configure: social_api.admin_config`, which is why the module row
on `/admin/modules` links there.

## Grant with Drush

```bash
drush role:create social_api_manager 'Social API manager'
drush role:perm:add social_api_manager 'administer social api configuration'
drush user:role:add social_api_manager someuser
```

Check what a role has:

```bash
drush role:list --filter='administer social api'
drush cget user.role.social_api_manager permissions
```

## Access check in code

```php
$account->hasPermission('administer social api autoposting');
\Drupal::currentUser()->hasPermission('administer social api configuration');
```
