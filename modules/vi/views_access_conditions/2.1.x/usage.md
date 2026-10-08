<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Access Conditions adds a "Conditions" Views **access plugin** (plus per-field / per-filter / per-argument condition settings) so you can gate a view — and selectively hide individual fields, exposed filters, and contextual arguments — using Drupal core's Conditions API and available contexts.

---

The module provides a Views access plugin `views_access_conditions` (label "Conditions", class `Conditions`) built on the `conditions_helper` contrib module's form builder and evaluator. On a view's **Access** settings you pick "Conditions" and configure any core/contrib condition plugins (user role, request path, node type, etc.); at runtime `Conditions::access()` evaluates them (AND logic) and, via `alterRouteDefinition()`, also stamps the encoded conditions onto the route as a `_conditions` requirement checked by the `ConditionsAccessCheck` access checker (tagged `access_check`, `applies_to: _conditions`). Beyond whole-view access, `ViewsAlters` adds a "Views Access Conditions" details section to each field/filter/argument config item (`hook_form_views_ui_config_item_form_alter`), storing conditions in the view's third-party settings; `hook_views_pre_build` then removes fields/arguments whose conditions fail (unsetting the handler and, for arguments, the arg value), and `hook_form_views_exposed_form_alter` hides exposed-filter inputs whose conditions fail. A site settings form at `/admin/config/system/views-access-conditions` (`views_access_conditions.settings`, permission `administer views access conditions`, `restrict access: true`) lets admins limit which condition plugins are offered; when the `enabled_conditions` list is non-empty, `ConditionsAccessCheck` also intersects provided conditions down to that allow-list. If no conditions are configured, access defaults to allowed (by design). A `hook_views_access_conditions_available_conditions_alter` hook lets other modules add/remove available conditions.

---

- Restrict access to an entire view based on the current user's roles.
- Gate a view by request path, HTTP status, or current theme using core condition plugins.
- Combine multiple conditions (AND) that all must pass for a view page/display to be accessible.
- Hide a specific view **field** for users who don't meet a condition, while still showing the row.
- Hide an **exposed filter** input conditionally (e.g. show a "department" filter only to staff).
- Conditionally drop a **contextual argument** so the view isn't constrained by it for some users.
- Apply context-aware access (available contexts) beyond core's role/permission Views access plugins.
- Limit which condition plugins editors may use, via the admin allow-list settings form.
- Enforce the allow-list at the access-check layer (`enabled_conditions` intersection) as defense in depth.
- Add access rules to a view without writing a custom access plugin or custom code.
- Use node-type / entity-bundle conditions to expose a view only in certain content contexts.
- Build role-plus-path access rules (e.g. staff-only view under `/admin/*`).
- Let another module programmatically add or remove available conditions via the alter hook.
- Reuse the same Conditions API blocks familiar from Block visibility for Views access.
- Provide granular, per-display access configuration stored in the view's config (exportable).
- Selectively reveal sensitive columns (price, email) only to privileged roles within one view.
- Adjust an argument-driven view's behavior per audience without cloning the view.
- Centralize which conditions are "blessed" for access decisions across all views on a site.
- Migrate ad-hoc access PHP into declarative, config-based condition rules.
- Layer conditional field/filter visibility on top of a normal Views access plugin.
