<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions and route

## `facebook_pixel.permissions.yml`

| Permission | Title | Notes |
|---|---|---|
| `configure facebook_pixel` | Configure Facebook Pixel | the only permission actually enforced — it guards the settings form route |
| `use php for page_visibility` | Use PHP for tracking visibility | `restrict access: true`; declared for a PHP-snippet visibility mode that the 2.0.x form does **not** implement. Granting it changes nothing today. |

## Route

```yaml
facebook_pixel.facebook_pixel_config_form:
  path: '/admin/config/facebook_pixel'
  defaults:
    _form: '\Drupal\facebook_pixel\Form\FacebookPixelConfigForm'
    _title: 'Facebook Pixel Configuration'
  requirements:
    _permission: 'configure facebook_pixel'
  options:
    _admin_route: TRUE
```

Menu link `facebook_pixel.facebook_pixel_config_form` sits under
`system.admin_config_services` (*Configuration → Web services*) at weight 99.
`facebook_pixel.info.yml` sets `configure:` to this route.

Note the path is `/admin/config/facebook_pixel`, i.e. directly under `/admin/config` rather
than in a section — that is intentional in this release.

## Grant with Drush

```bash
drush role:create fbp_marketer 'Facebook Pixel marketer'
drush role:perm:add fbp_marketer 'configure facebook_pixel'
drush cget user.role.fbp_marketer permissions
```

## Check in code

```php
\Drupal::currentUser()->hasPermission('configure facebook_pixel');
```

There is **no** per-role permission that controls whether a visitor is tracked — that is
`visibility.user_role_mode` / `visibility.user_role_roles` in
[../configure/settings.md](../configure/settings.md).
