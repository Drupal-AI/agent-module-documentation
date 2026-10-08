<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure conditions on Layout Builder Styles

## Add conditions to a style
Go to **Layout Builder Styles** (`/admin/config/content/layout_builder_style`), add/edit a style or style group, and use the **Condition restrictions** section (added by `FormAlters::layoutBuilderStylesFormAlter` on the style add/edit forms). Configure any available condition plugins and save.

Stored in the style entity's third-party settings:
```
layout_builder_styles.style.<style_id>.third_party.lb_styles_conditions:
  <condition_plugin_id>: { …condition config… }
```

## How availability is enforced (UI only)
When an editor opens a Layout Builder form, `FormAlters` evaluates each relevant style's conditions and hides failing ones:
- `hook_form_layout_builder_add_block_alter` / `..._update_block_alter` → `alterLayoutBuilderBlockForm()`: for component (block) styles, respecting the style's block/bundle restrictions (`getBlockRestrictions()`, incl. `inline_block:<bundle>` propagation for reusable blocks).
- `hook_form_layout_builder_configure_section_alter` → `alterLayoutBuilderSectionForm()`: for section styles, respecting `getLayoutRestrictions()` against the current layout id.
- `evaluateConditions()` calls `conditions_helper.evaluator->evaluateConditions()`; on FALSE it `unset()`s the form element `layout_builder_style_<group>` (the whole style-group select/checkboxes), so the option is not offered.

This only controls what the **authoring UI presents**. It does not add access control to already-saved layouts or rendered output — treat it as UX curation, not a permission.

## Admin allow-list
`/admin/config/user-interface/lb-styles-conditions` — form `SettingsForm` (extends `conditions_helper` `ConditionSelectorSettingsFormBase`), permission `administer lb_styles_conditions` (`restrict access: true`).
```yaml
# lb_styles_conditions.settings
enabled_conditions: []   # which condition plugins are available in the Condition-restrictions UI
```
