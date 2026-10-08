<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Improved Rules UI (tr_rulez)

Optional replacement UI for reaction rules and Rules components. **On by default**: `config/install/tr_rulez.settings.yml` ships `ui_choice: 1`. A radio set ("Rules default UI" = 0 / "Rules Essentials improved UI" = 1) is injected into the Rules settings form (`rules_settings_form`) by `tr_rulez_form_rules_settings_form_alter()`; changing it saves and calls `drupal_flush_all_caches()` so the entity/expression alters take effect.

## What toggling to `1` does (`tr_rulez.module`)
`tr_rulez_entity_type_alter()`:
- `rules_reaction_rule`: list builder → `Controller\RulesReactionListBuilder`; `edit` form → `Form\ReactionRuleEditForm`; adds a `clone` link template `/admin/config/workflow/rules/reactions/clone/{rules_reaction_rule}`.
- `rules_component`: list builder → `Controller\RulesComponentListBuilder`; adds a `clone` link template.

`tr_rulez_rules_expression_info_alter()`: swaps expression classes/form classes and adds descriptions — see [../plugins/expressions.md](../plugins/expressions.md).

## Clone routes (`tr_rulez.routing.yml`)
- `entity.rules_reaction_rule.clone` → `RulesReactionController::saveClone` — requires `_permission: 'administer rules+administer rules reactions'` (BOTH) and `_csrf_token: 'TRUE'`.
- `entity.rules_component.clone` → `RulesComponentController::saveClone` — requires `administer rules+administer rules components` and `_csrf_token: 'TRUE'`.

`saveClone()` calls `createDuplicate()`, relabels to "Copy of @name", sets the new id to `<original_id>_clone`, saves, and redirects to the collection with a message. Known limitation (in-code `@todo`): no uniqueness check on the `_clone` id, so cloning the same entity twice would collide/overwrite — an admin-only correctness nit, not a security issue.

## ReactionRuleEditForm (`src/Form/ReactionRuleEditForm.php`)
Extends `RulesComponentFormBase`. Renders the rule's events in a table with machine names, delegates the expression editing to the Rules UI handler, and adds Save/Cancel. The per-event "Delete" and "Add event" operations currently link to the `tr_rulez.unimplemented` modal (issue #3010055 "Multiple Event Triggers") rather than performing the action — multiple-event editing is not yet wired up.

## UnimplementedFeatureForm (`src/Form/UnimplementedFeatureForm.php`)
Route `tr_rulez.unimplemented` = `/unimplemented-feature/{feature}/{title}/{issue}` (permission `administer rules`). A modal that says the named UI feature is not yet operational and links `https://www.drupal.org/node/{issue}`. Placeholders are rendered through `t()` (auto-escaped); the issue id is passed to `Url::fromUri`. Admin-gated and escaped.

## Notes for agents
- With `ui_choice: 0` the module gets out of the way and stock Rules UI is used; the added Rules *plugins* (conditions/actions/events/xor/filters) remain available regardless of this setting.
- The list builders and edit form are cosmetic/UX layers over Rules' own config entities; they do not change access or storage semantics.
