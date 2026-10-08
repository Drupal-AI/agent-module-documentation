# Negotiator service, entity type, permissions (API)

## Theme negotiator — `theme.negotiator.theme_change_themeswitcher`

`Drupal\theme_change\Theme\ThemeChangeswitcherNegotiator` implements
`ThemeNegotiatorInterface`, registered with tag `theme_negotiator` **priority 10** (higher priority
runs before core's lower-priority negotiators, so a matching rule wins over the default/admin theme
for that request).

Constructor args, in `theme_change.services.yml` order:
`@path.current`, `@path.matcher`, `@current_route_match`, `@entity_type.manager`,
`@path_alias.manager`. The constructor eagerly stores `currentPath = path.current->getPath()` and
`currentRoute = current_route_match->getRouteName()`.

### `applies(RouteMatchInterface)` (lines 88–101)
Loads **all** `theme_change` entities (`entityTypeManager->getStorage('theme_change')
->loadMultiple()`) and returns `TRUE` on the **first** entity whose `check()` matches, stashing that
entity for `determineActiveTheme()`. First-match-wins; load order is storage order (config entity
IDs), not a configurable weight.

### `check(ThemeChange $entity)` (lines 113–130)
- `type == 'path'`: computes `path_alias.manager->getAliasByPath(currentPath)`, splits the entity's
  `path` on `,`, trims each, and for each runs `path.matcher->matchPath()` against both the raw
  current path **and** the current path's alias. Any match → `TRUE` (this is where `/user/*` style
  wildcards resolve).
- `type == 'route'`: `TRUE` iff `currentRoute == entity->getRoute()` (exact route-name equality).

### `determineActiveTheme(RouteMatchInterface)` (lines 106–108)
Returns the stashed entity's `getTheme()` — the theme machine name to render.

> Implementation note (not a bug you need to fix): the class also defines a `create()` factory whose
> argument order differs from `services.yml`, but tagged services are built from the `arguments:`
> list, so `services.yml` is authoritative and `create()` is effectively dead code here.

## Config entity type — `theme_change`

`Drupal\theme_change\Entity\ThemeChange` (`ConfigEntityBase`, implements the marker
`ThemeChangeInterface`). Annotation highlights: `config_prefix: theme_change`, `admin_permission:
access theme change settings page`, handlers `list_builder` = `ThemeChangeListBuilder`, forms
`add`/`edit` = `ThemeChangeForm`, `delete` = `ThemeChangeDeleteForm`. Getters:
`getPath()`, `getRoute()`, `getType()`, `getTheme()`. Exported/config keys: `uuid`, `id`, `label`,
`type`, `path`, `route`, `theme` (schema `theme_change.theme_change.*`).

Load rules from PHP the standard way:

```php
$rules = \Drupal::entityTypeManager()->getStorage('theme_change')->loadMultiple();
foreach ($rules as $rule) {
  // $rule->getType(), $rule->getPath(), $rule->getRoute(), $rule->getTheme()
}
```

## Permissions — `theme_change.permissions.yml`

| Permission | Gates |
|---|---|
| `access theme change settings page` | collection/list + add form; also the entity `admin_permission` |
| `access theme change edit page` | the edit form |
| `access theme change delete page` | the delete form |

None are marked `restrict access: true`. All CRUD routes carry a `_permission` requirement (no
`_access: TRUE` and no `access content` gating), so the admin surface is not anonymously reachable.

## Caching
The active theme is part of the render cache key. The module does **not** invalidate render caches
when a rule is saved or deleted, so previously rendered pages may keep their old theme until caches
are cleared (`drush cr`).

## Install / upgrade path
`theme_change.install` provides only `theme_change_update_8330()`: if a legacy `theme_change`
**database table** exists (from a pre-config-entity version), it reads each row and creates an
equivalent `theme_change` config entity, then drops the old table. No `hook_install`,
`hook_schema`, or `hook_uninstall`. New installs never create that table.
