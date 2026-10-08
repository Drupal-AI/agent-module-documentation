<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions (dynamic)

Form Mode Manager declares no static permissions; it generates them at runtime via a permission
callback (`form_mode_manager.permissions.yml` → `FormModeManagerPermissions::formModeManagerPermissions`).

For every entity type that has form modes, it creates:

| Permission | Gate |
|---|---|
| `use <entity_type>.default form mode` | Access to the **default** add/edit form for that entity type. Marked `restrict access`. |
| `use <entity_type>.<form_mode> form mode` | Access to that specific form mode's add/edit routes for that entity type. Marked `restrict access`. |

Examples: `use node.default form mode`, `use node.contributor form mode`,
`use user.register form mode`.

## Why it matters

- The per-mode permission lets you grant a role **only** a specific form mode.
- The `…default form mode` permission lets you **hide** the default add/edit operations from a
  role (e.g. force contributors to use the `contributor` mode only). Combine with moving the
  local tasks to the primary level (see [configure/settings.md](../configure/settings.md)).

## Inspect on the live site

```bash
# list all generated FMM permissions
drush php:eval 'print implode("\n", array_keys(array_filter(
  \Drupal::service("user.permissions")->getPermissions(),
  fn($k) => str_starts_with($k, "use ") && str_ends_with($k, " form mode"),
  ARRAY_FILTER_USE_KEY)));'

# check whether a role has one
drush php:eval 'print in_array("use node.contributor form mode",
  \Drupal\user\Entity\Role::load("editor")->getPermissions()) ? "yes" : "no";'
```

The permission only exists once the corresponding form mode exists (the callback loads each
`entity_form_mode` to build its title/description).
