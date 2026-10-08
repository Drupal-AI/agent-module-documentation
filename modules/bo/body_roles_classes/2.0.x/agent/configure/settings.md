# Body Roles Classes — configuration

Config object `body_roles_classes.settings` (schema in `config/schema`, defaults in
`config/install`):

| Key | Type | Default | Effect |
|---|---|---|---|
| `enabled` | boolean | `true` | Master switch; when off, `getClasses()` returns `[]`. |
| `prefix` | string | `role-` | Prepended to each role class before cleaning. |
| `exclude_roles` | sequence of role ids | `[administrator]` | Roles omitted from the output (hide sensitive roles). |
| `role_map` | mapping (role id → string) | `{}` | Override the class emitted for a role. |

Set via Drush, e.g.:
```
ddev drush config:set body_roles_classes.settings prefix 'r-' -y
ddev drush config:set body_roles_classes.settings enabled 1 -y
```

## Settings form
Route `body_roles_classes.settings` → `/admin/config/user-interface/body-roles-classes`
(`SettingsForm`, a `ConfigFormBase`) exposes *Enable*, *Class prefix*, and *Exclude roles*
checkboxes (`role_map` is not editable in the UI — set it via config).

**Caveat:** the route requires `_permission: 'administer body roles classes'`, but the module
ships **no `*.permissions.yml`** defining that permission. As a result the permission cannot
be granted to any role, so only user 1 (superuser bypass) can open the form. Manage the config
with Drush/config import if you are not user 1.

## Class generation (`RoleClassGenerator::getClasses()`)
For each current-user role not in `exclude_roles`: `$class = role_map[role] ?? role`, then
`strtolower(str_replace('_','-',$class))`, then `Html::cleanCssIdentifier(prefix . $class)`.
Finally appends `user-authenticated` or `user-anonymous`; returns `array_unique(...)`. Emitted
into `$variables['attributes']['class']` in `hook_preprocess_html`, with
`$variables['#cache']['contexts'][] = 'user.roles'`.
