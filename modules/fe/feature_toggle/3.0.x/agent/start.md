<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feature Toggle — agent index

Named on/off **feature flags**. Definitions live in config; the on/off status lives in key-value.
Gate blocks, views, routes, Twig, and code on a feature.

- **Define/toggle features, config vs key-value storage, cache tags** →
  [configure/features.md](configure/features.md)
- **Services & events: FeatureManager, FeatureStatus, the `Feature` object, `feature_toggle.update`** →
  [api/services.md](api/services.md)
- **Consume a flag: Condition (block visibility), Views access plugins, route access, Twig, drupalSettings** →
  [api/integrations.md](api/integrations.md)
- **Drush: `feature_toggle:set` / `ftset`** → [drush/commands.md](drush/commands.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- `configure`: `feature_toggle.feature_toggle_form` → `/admin/config/system/feature_toggle`.
- Definitions: config `feature_toggle.features` → `features.<name>` = `{name, label, description}`.
- **Status: key-value** store, collection `feature_toggle`, key `flags` = `[name => bool]`
  (NOT config, NOT state) — so toggling is not a config change.
- Services: `feature_toggle.feature_manager`, `feature_toggle.feature_status`.
- Twig `feature_toggle_status('name')`; Drush `feature_toggle:set NAME 0|1` (alias `ftset`).
- Cache tags: `feature_toggle_list`, `feature_toggle:<name>`. No plugin types of its own.
