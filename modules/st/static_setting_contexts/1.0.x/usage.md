<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Static Setting Contexts turns values defined through the owenbush/static-settings PHP API into a Drupal Condition plugin, so any static setting you define becomes a reusable visibility/context condition (e.g. for block visibility).

---

The module defines a plugin type `static_setting_contexts` (attribute `#[StaticSettings(id, label, description)]`, plugins discovered under any module's `src/Plugin/StaticSettings`). Each plugin is a PHP `enum` (implementing the static-settings package's `BaseStaticSettingInterface`) whose cases are the possible values of a setting. It ships one Condition plugin, `static_setting_contexts_static_settings` ("Static Settings"), which builds a checkbox group per defined static setting (the enum cases) and, at evaluation time, reads the current value via `StaticSettings::get()` from the owenbush/static-settings package and checks whether it is among the selected values (supports negation and combines multiple settings with AND). Because static settings are resolved in PHP (typically from environment/deployment state rather than the database), this gives you fast, code-defined contexts to gate blocks, layouts, or anything using core's Condition system — without storing the value in config. There is no admin UI, no permissions and no Drush; you define settings in code (and must make Composer's autoloader aware of your `Plugin/StaticSettings` namespace, per the static-settings package). The module is essentially a bridge between the standalone static-settings library and Drupal's condition/context plugin system.

---

- Show or hide a block depending on a code-defined environment setting (e.g. prod vs staging).
- Gate content on a feature-flag enum resolved in PHP.
- Define a "site mode" static setting and use it as a block visibility condition.
- Create reusable contexts from deployment/environment state without database config.
- Combine several static settings as an AND condition on a block.
- Negate a condition (show unless the setting has a given value).
- Expose an enum of allowed values as checkbox options in the condition form.
- Provide fast, non-DB visibility conditions for performance-sensitive pages.
- Reuse the same static setting across many blocks/layouts via one condition plugin.
- Let developers ship new contexts simply by adding an enum in `src/Plugin/StaticSettings`.
- Drive Layout Builder section visibility from environment-defined settings.
- Model an A/B or rollout flag as a static setting condition.
- Restrict a promotional block to a specific deployment tier.
- Keep environment logic in code review (enums) rather than editorial config.
- Integrate the owenbush/static-settings library with Drupal's plugin ecosystem.
- Define per-region or per-tenant modes as enums and condition on them.
- Toggle experimental UI behind a code-defined static setting.
- Provide contexts that are consistent across all requests in an environment.
- Avoid writing a bespoke ConditionPluginBase for each environment flag.
