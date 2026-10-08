<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Access Conditions — agent index

Adds a **"Conditions" Views access plugin** and per-field/filter/argument conditional visibility using core's Conditions API (via the `conditions_helper` module). Depends on `views` + `conditions_helper`. Config UI at `/admin/config/system/views-access-conditions` (`configure` = `views_access_conditions.settings`, permission `administer views access conditions`, restricted). Provides config schema. No plugin *types*, no Drush.

- **The access plugin, per-item conditions, the admin allow-list settings, storage, and default-allow behavior** → [configure/conditions.md](configure/conditions.md)
- **`hook_views_access_conditions_available_conditions_alter` to add/remove available conditions** → [hooks/alter.md](hooks/alter.md)

Key facts:
- Access plugin id `views_access_conditions` (`Conditions::access()` AND-evaluates; `alterRouteDefinition()` adds `_conditions` route requirement → `ConditionsAccessCheck`).
- Per-item (field/filter/argument) conditions live in the view's third-party settings; enforced by `hook_views_pre_build` (remove failing fields/args) and `hook_form_views_exposed_form_alter` (hide failing exposed filters).
- Settings `views_access_conditions.settings.enabled_conditions` (allow-list); empty = all conditions available and no access-check intersection.
- **No conditions configured ⇒ access allowed** (`ConditionsAccessCheck` / `Conditions::access` default).
