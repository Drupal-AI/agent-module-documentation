<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Configuration Tweak strips optional/circular configuration dependencies so the "Configuration updates report" stays clean after exports.

---

The module hooks into config export to drop dependencies that would otherwise cause churn: it can remove the dependency an entity-reference field records on its target bundles (`EntityReferenceItemConfigTweak`, `FieldTypePluginManagerConfigTweak`) and remove the dependency an Entity Browser records on its view widget (`EntityBrowserWidgetViewConfigTweak`). Fields/browsers can opt in per-instance by adding `dependencies_optional: yes` in the relevant `handler_settings`/widget `settings` of the config YAML (using Entity Browser also needs the patch referenced in the README).

A single settings form at `/admin/config/development/config_tweak` (permission `administer site configuration`) toggles which tweaks are active. This is a developer/administration utility with no runtime routes, no data mutation endpoints, and no external calls — its effect is limited to what gets written into exported configuration.

---

- Keep the configuration updates report showing no spurious changes.
- Remove entity-reference dependencies on target bundles from exported config.
- Break circular dependencies between fields and referenced content.
- Remove Entity Browser dependencies on their view widget.
- Break circular dependencies between Entity Browser and Views config.
- Toggle each tweak from `/admin/config/development/config_tweak`.
- Opt a specific field in via `dependencies_optional: yes` in `handler_settings`.
- Opt a specific Entity Browser widget in via `dependencies_optional: yes`.
- Stabilise config diffs across environments.
- Reduce noise in `drush config:status` output.
- Avoid re-importing unchanged configuration.
- Support optional (non-enforced) dependencies where core would enforce them.
- Clean up config before committing to version control.
- Apply the recommended Entity Browser patch for full compatibility.
- Limit the tweaks to only the dependency types you choose.
- Use as a developer utility during site building.
- Keep exported config portable between sites.
- Pair with standard config export/import workflows.
