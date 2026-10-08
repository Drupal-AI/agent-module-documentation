<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Condition Field adds a `condition_field` field type that stores a set of Drupal core Condition plugin configurations (roles, pages, language, and other context-based conditions) on any fieldable entity, so those conditions can later be evaluated in custom code for visibility or business rules.

---

The module reuses Drupal's core **Condition Plugin** system (the same plugins that power block visibility). Its field type (`ConditionFieldItem`, `@FieldType id="condition_field"`) stores a single serialized `conditions` blob (a map of condition-id → condition configuration). Per field instance you choose, in the field settings form, which condition plugins are **enabled** (`enabled_plugins`, schema `field.field_settings.condition_field`); some plugins are always skipped via `ConditionFieldItem::SKIP_CONDITION_IDS` (`node_type`, `current_theme`, `webform`, `entity_bundle:webform_submission`, and `language` until the site is multilingual). The default widget (`condition_field_default`, "Conditions") renders each enabled condition's own configuration form inside vertical tabs (mirroring `BlockForm::buildVisibilityInterface()`), and `preSave()` keeps only conditions whose values differ from their defaults. The default formatter (`condition_field_string`) lists a human-readable summary of each stored condition. The module deliberately does **not** evaluate the conditions itself — you read the field, instantiate the conditions via `plugin.manager.condition`, and resolve them with the shipped `ConditionAccessResolver::checkAccess($conditions, 'and'|'or')` helper (e.g. inside `hook_entity_view` to hide an entity). There is no admin settings page, no permissions, and no Drush; everything is per-field configuration plus your own evaluation code.

---

- Attach a set of visibility conditions (roles, pages, etc.) directly to a node or other entity.
- Store per-entity "show this only to these roles" rules using the core User Role condition.
- Store per-entity "show only on these paths" rules using the Request Path condition.
- Let editors configure conditions in a familiar vertical-tabs UI, like block visibility.
- Choose exactly which condition plugins are available on a given field (enabled_plugins).
- Reuse any custom/contrib core Condition plugin as an editable field on content.
- Build language-specific visibility on multilingual sites using the Language condition.
- Evaluate stored conditions in `hook_entity_view` to hide/show an entity's build.
- Combine conditions with AND or OR logic via ConditionAccessResolver::checkAccess().
- Drive custom business rules (not just visibility) from editor-set conditions.
- Add a "display conditions" field to a paragraph or block content entity.
- Gate a call-to-action component on request path or role without custom forms.
- Let content authors decide targeting rules per item instead of hardcoding them.
- Show a condition summary on the rendered entity via the default formatter.
- Keep only non-default condition values stored, minimizing config noise.
- Provide a reusable conditions field across multiple content types.
- Implement per-node access or personalization rules in code you control.
- Expose context-aware conditions (those whose context requirements are met) automatically.
- Prototype visibility logic quickly by reading one field instead of building a settings UI.
- Migrate block-style visibility rules onto content entities.
