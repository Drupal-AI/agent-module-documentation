<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ARA — install, configuration, routes & permission

## Install / enable

```bash
ddev drush en ara -y
ddev drush cr
```

No contrib or composer dependencies (only core `system`). Enabling the module swaps the core
`renderer` service class (see `AraServiceProvider`), so a cache rebuild is required for the
decorator to take effect. Enabling the module alone does **not** start profiling — the `enabled`
config flag is `FALSE` by default.

## Turning the profiler on

1. Grant the **`use ara profiler`** permission (People → Permissions) to the role(s) that should
   see profiler output. It is `restrict access: true` — treat it like an admin capability.
2. Visit **`/admin/config/development/ara`** (route `ara.settings`, *Configuration → Development →
   Advanced Render Auditor profiler*).
3. Tick **Enable profiler site-wide** (`enabled`).
4. Optionally tick **Display annotations** (`display_annotations`) and set **Annotation display
   threshold (milliseconds)** (`annotation_threshold_ms`, 0–60000).
5. Reload any non-admin page; the results panel appears at the bottom.

Profiling for a given request runs only when **both** the config flag is on **and** the current
user holds `use ara profiler` (see `ProfileRunSettings::isActive()`), and never on admin routes.

## Config object `ara.settings`

Schema `config/schema/ara.schema.yml`; install defaults `config/install/ara.settings.yml`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enabled` | boolean | `false` | Master switch — profile every (non-admin) request for permitted users. |
| `display_annotations` | boolean | `false` | Prepend a timing badge to each rendered element. |
| `annotation_threshold_ms` | integer | `100` | Badges below this render time are rendered but `hidden`; rows still appear in the panel. |

Drush example:

```bash
ddev drush cset ara.settings enabled true -y
ddev drush cset ara.settings display_annotations true -y
ddev drush cset ara.settings annotation_threshold_ms 50 -y
```

The form (`src/Form/SettingsForm.php`, `ConfigFormBase`, form id `ara_settings`) uses
`#config_target` bindings, so it reads/writes those keys directly; the threshold field is only
visible (`#states`) when *Display annotations* is checked.

## Route & permission summary

- Route `ara.settings`: path `/admin/config/development/ara`, `_form: SettingsForm`, requirement
  `_permission: 'use ara profiler'`. Menu link `ara.settings` (`ara.links.menu.yml`) parented to
  `system.admin_config_development`.
- Permission `use ara profiler` (`ara.permissions.yml`): grants viewing profiler output and
  configuring settings; `restrict access: true`.

## Status Report warning (leave-on guard)

`ara_requirements('runtime')` in `ara.install` returns a `REQUIREMENT_WARNING` on the Status Report
whenever `ara.settings.enabled` is TRUE, linking to `ara.settings` to disable it. This is by
design: the decorator instruments every render call and is meant for local development only.
Disabling the flag clears the warning automatically.

## Upgrade path

`ara_update_11001()` renames a legacy `dxp_performance.settings` config object to `ara.settings`
(only if the new one is still new) and migrates the `use dxp performance profiler` permission to
`use ara profiler` on every role, logging each migrated role.

## Uninstall

Disabling the module removes the renderer decoration (rebuild caches). Config `ara.settings` is
removed on uninstall per standard config lifecycle.
