# Custom Permissions — programmatic API

There is no dedicated service facade; you work with the config entity directly through the
entity type manager. Entity type id: **`custom_perms_entity`** (class
`Drupal\config_perms\Entity\CustomPermsEntity`, interface `CustomPermsEntityInterface`).

## Create

```php
$storage = \Drupal::entityTypeManager()->getStorage('custom_perms_entity');
$storage->create([
  'id'     => 'manage_regional',            // machine name (a-z0-9_)
  'label'  => 'Manage regional settings',    // becomes the permission title
  'route'  => 'system.regional_settings',    // one route name...
  // 'route' => "route.one\nroute.two",       // ...or several, newline-separated
  'status' => TRUE,                           // enabled
])->save();

// Rebuild the router so the route access override is applied.
\Drupal::service('router.builder')->rebuild();
```

## Read

```php
$storage = \Drupal::entityTypeManager()->getStorage('custom_perms_entity');

$e = $storage->load('manage_regional');
$e->id();            // 'manage_regional'
$e->label();         // 'Manage regional settings'  (== the permission name)
$e->getRoute();      // 'system.regional_settings'  (raw string; may hold newlines)
$e->getStatus();     // TRUE / FALSE

// Only the enabled ones (this is what the permission callback and access check use):
$enabled = $storage->loadByProperties(['status' => TRUE]);

// Normalise multi-route strings to an array with the module helper:
$routes = config_perms_parse_path($e->getRoute());  // ['system.regional_settings']
```

## Update / delete

```php
$e = $storage->load('manage_regional');
$e->set('route', "system.regional_settings\nsystem.performance_settings")->save();
$e->set('status', FALSE)->save();   // disable without deleting
$e->delete();                        // remove entirely
\Drupal::service('router.builder')->rebuild();
```

## How it wires into access (read-only internals)

- `Drupal\config_perms\CustomPermissions::permissions()` (the `permission_callbacks` entry
  in `config_perms.permissions.yml`) loads every **enabled** entity and exposes each
  `label` as a grantable permission.
- `Drupal\config_perms\Routing\RouteSubscriber::alterRoutes()` runs on router rebuild: for
  each enabled entity and each route it names, it **replaces** that route's requirements
  with a single `_config_perms_access_check`. This removes the route's original access
  checks entirely.
- `Drupal\config_perms\Access\ConfigPermsAccessCheck::access()` returns
  `AccessResult::allowedIf($account->hasPermission($entity->label()))` for the matching
  route — i.e. access is granted when the user holds the permission named by the label.

Practical consequences:
- Changing `route`/`status`/adding/deleting an entity requires a **router rebuild**
  (`drush cr` or `router.builder`) to take effect.
- The permission's machine name **is the label string** (with spaces/case), so assign it
  verbatim: `\Drupal::service('...')` or `drush role:perm:add <role> '<label>'`.
- Only routes that actually exist can be used; the admin form validates route names via
  `router.route_provider`.
