<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Auto-registers every Environment Indicator entity as an available environment in Environment Context.

---

This Environment Context submodule bridges the Environment Indicator module into Environment Context.
Once enabled it listens for Environment Context's `AvailableEnvironmentsEvent` and adds each
Environment Indicator config entity as an available environment (entity `id` as the machine name,
entity label as the label). It has no UI and no configuration; it only populates the environment list so
Environment Indicator names can be selected wherever Environment Context uses them (for example the
"Current environment" visibility condition). It does not detect or switch the active environment.

---

- Make every Environment Indicator entity appear as a selectable environment in Environment Context.
- Reuse existing Environment Indicator definitions instead of hand-registering environments.
- Populate the "Current environment" block/section visibility condition with indicator names.
- Keep environment naming consistent between Environment Indicator and Environment Context.
- Install alongside `environment_indicator` and `environment_context` (both required).
- Enable with `drush en environment_context_environment_indicator`.
- Avoid writing a custom `AvailableEnvironmentsEvent` subscriber for Environment Indicator.
- Let site builders pick an indicator-named environment without touching code.
- Expose indicator labels (not just ids) in environment option lists.
- Drive per-indicator conditional block visibility once a matching environment is detected.
- Combine with custom detection so a detected environment matches an indicator id.
- Provide environment options for Layout Builder sections named after indicators.
- Feed `EnvironmentRegistryInterface::getEnvironmentOptions()` with indicator-derived entries.
- Pair the visual environment banner (Environment Indicator) with behavioural/caching logic (Environment Context).
- Add or remove environments simply by adding or removing Environment Indicator entities.
