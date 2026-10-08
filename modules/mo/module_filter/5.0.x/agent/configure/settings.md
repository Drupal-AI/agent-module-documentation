# Module Filter settings

Config object `module_filter.settings` (schema `config/schema/module_filter.schema.yml`).
Form `ModuleFilterSettingsForm` at `/admin/config/user-interface/module-filter`
(route `module_filter.settings`, permission `administer module_filter`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `tabs` | bool | `true` | Convert the Extend page packages into vertical tabs. |
| `path` | bool | `false` | Show each module's machine path in the modules list. |
| `descriptions_show` | bool | `false` | Always expand module description details. |
| `enabled_filters.permissions` | bool | `true` | Add the filter box to the permissions page. |

```
drush config:set module_filter.settings tabs 0 -y
drush config:set module_filter.settings path 1 -y
```

## Affected pages
- **Extend / modules** (`system.modules_list`) — filter text box + Enabled/Disabled/Required/Unavailable checkboxes; tabs when `tabs` is on.
- **Uninstall** and **modules confirm** forms — filtered too (`hook_form_system_modules_uninstall_alter`, `..._confirm_form_alter`).
- **Update status report** — filter by Up-to-date / Update available / Security update / Unknown.
- **Permissions** (`user.admin_permissions`) — filter box when `enabled_filters.permissions` is on.

## Filter operators (Extend page)
Type `operator:value` in the filter box. Available: `requires:` (modules that require the given
module), `dependents:`/`required-by:` style relationships, and text match by default
(e.g. `requires:block`).

## Deep link
The modules page accepts a `filter` query param (`system.modules_list?filter=views`) — the
module remembers/injects it on submit-redirect.

## Notes
Hook logic lives in the OOP service `Drupal\module_filter\Hook\ModuleFilterHooks` (the
`.module` file just delegates via `#[LegacyHook]`). Recently enabled modules are tracked in
state key `module_filter.recent`.
