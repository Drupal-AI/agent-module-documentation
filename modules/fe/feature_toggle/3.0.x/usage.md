<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feature Toggle provides named on/off feature flags you manage from an admin screen (or Drush), then gate blocks, views, routes, Twig output, and custom code on whether a feature is enabled.

---

You define features (each a machine name + label + description) at *Configuration → System → Feature Toggle* (`/admin/config/system/feature_toggle`, the module's `configure` route) and flip each one on or off from the same list. The **definitions** are stored in the `feature_toggle.features` config object (`features.<name>` = `{name, label, description}`), while the **on/off status** is stored separately in the key-value store (collection `feature_toggle`, key `flags` = `[name => bool]`) — so toggling a feature is not a config change. Two services expose this: `feature_toggle.feature_manager` (`FeatureManagerInterface` — CRUD of `Feature` value objects) and `feature_toggle.feature_status` (`FeatureStatusInterface` — `getStatus()` / `setStatus()`, which also dispatches a `feature_toggle.update` event and invalidates the `feature_toggle_list` and `feature_toggle:<name>` cache tags). The module ships many ways to consume a flag: a **Condition** plugin (`feature_toggle`) for block visibility, three **Views access** plugins (`feature_toggle_feature`, `feature_toggle_perm_feature`, `feature_toggle_role_feature`), a **route access** requirement (`_feature_toggle: 'feature.value'`), a Twig function `feature_toggle_status('name')`, a Drush command `feature_toggle:set` (alias `ftset`), and a `drupalSettings.feature_toggle.enabled` array attached to every page. Two permissions gate it: `administer feature_toggle` and `modify feature_toggle status`.

---

- Ship a half-finished "beta checkout" feature dark and flip it on for everyone with one toggle.
- Give non-developers a safe on/off switch for a feature without deployments or config changes.
- Show or hide a block based on whether a feature is enabled (Feature Toggle block-visibility condition).
- Restrict a whole view to users when a feature is enabled (Views "Feature (Unrestricted)" access).
- Combine a permission *and* a feature for view access (Views "Permission + Feature").
- Combine a role *and* a feature for view access (Views "Role + Feature").
- Gate a custom route behind a feature with the `_feature_toggle: 'my_feature.1'` requirement.
- Conditionally render markup in a Twig template with `feature_toggle_status('my_feature')`.
- Read the list of enabled features in JavaScript from `drupalSettings.feature_toggle.enabled`.
- Toggle a feature from CI or a deploy script with `drush feature_toggle:set my_feature 1`.
- Turn a feature off instantly as a kill switch during an incident (`drush ftset my_feature 0`).
- Delegate day-to-day toggling to editors (`modify feature_toggle status`) while reserving feature creation for admins (`administer feature_toggle`).
- React to a feature being switched on/off by subscribing to the `feature_toggle.update` event.
- Run per-feature logic by subscribing to `feature_toggle.update.<feature_name>`.
- Cache-tag rendered output on `feature_toggle:<name>` so it rebuilds when the flag changes.
- A/B a new UI by enabling it for a role-gated audience via the Role + Feature views access plugin.
- Keep feature status out of config export (it lives in key-value), so environments can differ.
- Programmatically check a flag in a service with `FeatureStatusInterface::getStatus('name')`.
- Enumerate all defined features and their labels via `FeatureManagerInterface::getFeatures()`.
- Add, rename the label of, or delete a feature from code using the feature manager service.
- Coordinate a staged rollout: define the feature now, enable it later without touching code.
- Provide a maintenance/"coming soon" gate on a section by toggling a feature that a route checks.
- Let a block appear only while a promotional feature is live.
- Roll back a risky change by toggling its feature off instead of reverting a deployment.
