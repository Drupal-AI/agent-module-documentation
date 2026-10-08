<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Manage Display Fix Title — agent index

**Obsolete stub. Do not enable it.** Submodule of
[manage_display](../../../../3.0.x/agent/start.md).

The entire submodule is one file, `manage_display_fix_title.info.yml`. There is no `.module`
file, no `src/`, no config, no routes, no permissions, no services, no plugins, no templates —
so there is nothing to write a solution doc about.

Everything an agent needs:

| Fact | Value |
|---|---|
| `lifecycle` | `obsolete` |
| `lifecycle_link` | `https://www.drupal.org/project/manage_display/issues/3291074` |
| `core_version_requirement` | `^8.8 \|\| ^9` — **incompatible with Drupal 10/11** |
| `package` | `Fields` |
| `dependencies` | none declared |
| Install attempt on D11 | `drush en manage_display_fix_title` → *"module 'manage_display_fix_title' is incompatible with this version of Drupal core"* (exit 1) |
| Removal path | `manage_display_update_9201()` in the **parent** module uninstalls it if still enabled |

## Why it exists / what replaced it

It used to work around core bugs that printed an entity title twice once the title base field was
made display-configurable. Core later gained the entity-type flags
`enable_page_title_template` and `enable_base_field_custom_preprocess_skipping`, and the parent
module now sets them itself in `manage_display_entity_type_build()`. See
[../../../../3.0.x/agent/configure/base-fields.md](../../../../3.0.x/agent/configure/base-fields.md)
for those flags and which entity types get them.

## Correct action

Enable `manage_display` only. If an old site still has this submodule enabled, run the parent's
database updates (`drush updb`) and `manage_display_update_9201()` will uninstall it; no
configuration is lost because the submodule owns none.

```bash
drush pm:list --filter=manage_display   # expect: Manage Display Fix Title -> Disabled
```
