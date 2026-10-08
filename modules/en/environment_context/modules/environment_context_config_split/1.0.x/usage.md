<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Auto-registers every Config Split as an available environment in Environment Context.

---

This Environment Context submodule bridges the Config Split module into Environment Context. Once
enabled it listens for Environment Context's `AvailableEnvironmentsEvent` and adds each Config Split as
an available environment (split `id` as the machine name, split `label` as the label). It has no UI and
no configuration; it only populates the environment list so Config Split names can be selected wherever
Environment Context uses them (for example the "Current environment" visibility condition). It does not
detect or switch the active environment and does not enable or disable any split.

---

- Make every Config Split appear as a selectable environment in Environment Context.
- Reuse existing Config Split names instead of hand-registering environments.
- Populate the "Current environment" block/section visibility condition with split names.
- Keep environment naming consistent between Config Split and Environment Context.
- Install alongside `config_split` and `environment_context` (both required).
- Enable with `drush en environment_context_config_split`.
- Avoid writing a custom `AvailableEnvironmentsEvent` subscriber for Config Split.
- Let site builders pick a split-named environment without touching code.
- Expose split labels (not just ids) in environment option lists.
- Drive per-split conditional block visibility once a matching environment is detected.
- Combine with custom detection so a detected environment matches a split id.
- Provide environment options for Layout Builder sections named after splits.
- Feed `EnvironmentRegistryInterface::getEnvironmentOptions()` with split-derived entries.
- Support workflows where each deployment target has its own Config Split.
- Add or remove environments simply by adding or removing Config Splits.
