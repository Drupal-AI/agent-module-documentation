# Alter login route definitions

`hook_gin_login_route_definitions_alter(&$route_definitions)` (documented in
`gin_login.api.php`) lets a module add or change which routes Gin Login treats as
login/auth pages. Each definition maps a theme hook to a template + preprocess functions;
the module's `gin_login.route` service returns the merged list, and `gin_login_theme()`
registers a template for every entry.

```php
/**
 * Implements hook_gin_login_route_definitions_alter().
 */
function mymodule_gin_login_route_definitions_alter(&$route_definitions) {
  $route_definitions['user.login.alternative'] = [
    'page' => 'page__user__login',
    'template' => 'page--user--login',
    'preprocess functions' => ['gin_login_preprocess_ginlogin'],
  ];
}
```

- Keys: `page` (theme hook id), `template` (Twig file base name), `preprocess functions`
  (array of preprocess callbacks).
- Add an entry to bring a custom auth route (e.g. a contrib login route) under Gin Login
  styling and give it its own template.
- The negotiator and asset-attachment logic key off these route definitions, so a newly
  added route is themed and gets Gin's libraries automatically.
