# Module Filter settings

Config object `module_filter.settings` (schema `config/schema/module_filter.schema.yml`).
Form `Form\ModuleFilterSettingsForm` (extends `ConfigFormBase`) at
`/admin/config/user-interface/module-filter`
(route `module_filter.settings`, permission `administer module_filter`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `tabs` | bool | `true` | Enhance the Extend page and convert package fieldsets into vertical tabs (server-rendered). |
| `path` | bool | `false` | Show each module's relative path in the modules list. |
| `descriptions_show` | bool | `false` | Always expand module description details. |
| `enabled_filters.permissions` | bool | `true` | Add the filter box to the permissions page. |

```
drush config:set module_filter.settings tabs 0 -y
drush config:set module_filter.settings path 1 -y
```

## Affected pages
- **Extend / modules** (`system.modules_list`, `form_system_modules_alter`) — filter text box +
  Enabled/Disabled/Unavailable checkboxes; server-rendered tabs when `tabs` is on
  (`module_filter/modules.tabs` library), otherwise `module_filter/modules.bare`.
- **Modules confirm** (`form_system_modules_confirm_form_alter`) and **Uninstall**
  (`form_system_modules_uninstall_alter`) forms — filter carried through / filtered.
- **Update status report** — the `update.status` route controller is overridden by
  `RouteSubscriber` to `ModuleFilterUpdateController`, which prepends
  `ModuleFilterUpdateStatusForm` (filter box + All / Update available / Security update / Unsupported radios).
- **Permissions** (`user.admin_permissions`, `form_user_admin_permissions_alter`) — filter box when
  `enabled_filters.permissions` is on (`module_filter/permissions` library).

## Filter operators (Extend page)
Type `operator:value` in the filter box. Available operators (per README): `description:` (match a
module's description), `requiredBy:` (match what a module is required by), `requires:` (match what a
module requires); bare text matches name by default. Space-delimit multiple queries
(`description:ctools views`); wrap a value in double quotes to include a space
(`requires:"chaos tools"`).

## Deep link
The modules page accepts a `filter` query param (`system.modules_list?filter=views`) — the filter
value is injected as the field's `#default_value` and preserved across submit-redirect
(`ModuleFilterHelper::submitRedirect`).

## Implementation notes
- No `.module` file. Hooks are `#[Hook]`-attribute methods on `Hook\ModuleFilterFormHooks`,
  `Hook\ModuleFilterHooks` (help) and `Hook\ModuleFilterThemeHooks`; form-submit callbacks are static
  methods on `Services\ModuleFilterHelper` (serialization-safe).
- Recently enabled modules are tracked in state key `module_filter.recent` (set on install for
  `module_filter` itself; entries older than one week are pruned on each Extend-page build). Rows
  whose file ctime is under a week old get a `new` class.
- Vanilla-JS filter engine (`js/module_filter.winnow.js`, `Drupal.Winnow`) — no jQuery.
