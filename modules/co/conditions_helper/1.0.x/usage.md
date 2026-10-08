Conditions Helper is an API-only developer module that reduces boilerplate when integrating with Drupal core's Condition plugin API: it provides services to build "which conditions are available" selector forms, to build the per-condition configuration UI (with context mapping), and to evaluate a set of configured conditions with AND/OR logic — plus base form classes that wire it all up.

---

The module has no UI, routes, permissions, or config of its own; it exists to be consumed by other modules. Three services do the work: `conditions_helper.condition_selector_form_builder` (`ConditionSelectorFormBuilder`) builds a `checkboxes` element listing all condition plugin definitions from the core `plugin.manager.condition`, sorted by label, and runs `hook_conditions_helper_selector_definitions_alter` so modules can add/remove choices per scope; `conditions_helper.form_builder` (`ConditionsFormBuilder`) builds and submits the detailed sub-forms for each selected condition plugin, integrating context-mapping UI for context-aware plugins; and `conditions_helper.evaluator` (`ConditionsEvaluator`) instantiates a `ConditionPluginCollection` from stored configuration, applies runtime (and any caller-supplied additional) contexts, and returns a boolean using `resolveConditions()` with `'and'` or `'or'` logic. Two abstract base classes make consumption near-turnkey: `ConditionSelectorSettingsFormBase` (extends `ConfigFormBase`) saves selected plugin IDs under a standardized `enabled_conditions` config key, and `ConditionsFormBase` (extends `FormBase`) injects the form-builder service for embedding condition configuration UIs. Consuming modules define their own config schema for the saved data (the README recommends a mapping keyed by plugin ID resolving to `condition.plugin.[%key]`). It depends only on core APIs (Condition, Context, Form).

---

- Add a settings page to your module where admins pick which condition plugins are available for a feature.
- Build a configuration UI where each selected condition plugin renders its own sub-form.
- Support context-aware conditions (node, user, etc.) with automatic context-mapping UI.
- Evaluate a set of stored conditions and get a single TRUE/FALSE (all-must-pass AND logic).
- Evaluate conditions with OR logic (any condition passing is enough).
- Gate custom access checks, block visibility, or business rules on core condition plugins.
- Reuse core condition plugins (Request Path, User Role, Node Type, etc.) without re-implementing their forms.
- Save selected condition IDs to config under the standardized `enabled_conditions` key via the base form.
- Extend `ConditionSelectorSettingsFormBase` to get a turnkey condition-selection settings form.
- Extend `ConditionsFormBase` to embed a condition configuration form in your own form.
- Alter the list of selectable conditions per scope with `hook_conditions_helper_selector_definitions_alter`.
- Provide feature-specific condition subsets (e.g. only content-related conditions) via the alter hook.
- Pass runtime-specific contexts (e.g. the current node) into evaluation via `$additional_contexts`.
- Persist per-item condition configurations (e.g. per entity or per page) and evaluate them later.
- Negate individual conditions using each plugin's standard `negate` setting.
- Avoid writing custom `ConditionPluginCollection` / context-handling glue in every module.
- Build a reusable "conditional publishing" or "conditional display" feature on top of core conditions.
- Standardize how multiple modules store and evaluate condition sets across a site.
- Get the underlying `ConditionManager` from the form builder service when needed.
- Sort available condition options alphabetically by label for a consistent UX.
