<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Managing switcher rules

Rules are `display_mode_switcher_rule` config entities. Source: `src/Entity/DisplayModeSwitcherRule.php`, `src/Form/DisplayModeSwitcherRuleForm.php`, `src/ListBuilder/DisplayModeSwitcherRuleListBuilder.php`, `config/schema/display_mode_switcher.schema.yml`, `display_mode_switcher.routing.yml`, `display_mode_switcher.permissions.yml`.

## Install / enable
```bash
drush en display_mode_switcher
```
No database updates — configuration entities only. Requires core `^11.3`.

## Permission
`administer display mode switcher` (`display_mode_switcher.permissions.yml`, `restrict access: true`) — gates every route and is the entity's `admin_permission`.

## Routes (`display_mode_switcher.routing.yml`) — all `_permission: administer display mode switcher`
| Route | Path | Purpose |
|-------|------|---------|
| `entity.display_mode_switcher_rule.collection` | `/admin/structure/display-modes/view/switcher` | `_entity_list` (draggable) |
| `entity.display_mode_switcher_rule.add_form` | `/admin/structure/display-modes/view/switcher/add` | add |
| `entity.display_mode_switcher_rule.edit_form` | `/admin/structure/display-modes/view/switcher/{display_mode_switcher_rule}` | edit |
| `entity.display_mode_switcher_rule.delete_form` | `/admin/structure/display-modes/view/switcher/{display_mode_switcher_rule}/delete` | delete |

Menu/task/action links place the collection under Field UI's display-mode menu (`links.menu`/`links.task`/`links.action` yml). The list builder extends `DraggableListBuilder` for weight ordering; the `label` column is a plain string, other cells are render arrays.

## Rule properties (config_export)
`id`, `label`, `entity_type` (target entity type id), `bundle` (`''` = any bundle), `source_display_mode` (mode that triggers evaluation), `target_display_mode` (mode switched to), `weight` (ascending = higher priority), `conditions` (condition plugin config, keyed by plugin id). Entity keys: id, label, status, weight.

## The form (`DisplayModeSwitcherRuleForm`)
- Fields: Label, Machine name, Enabled (status), Weight, plus an **Applicability** details group holding Entity type (select — only entity types with a view builder), Bundle (textfield), Source/Target display mode (textfields). The applicability fields set explicit `#parents` at the top level so `EntityForm::buildEntity()` maps them despite `#tree = TRUE`.
- **Conditions** section: renders every definition from `plugin.manager.display_mode_switcher.condition` as a vertical tab with an "Enable this condition" checkbox and the plugin's own config form. Only checked conditions are validated and saved.
- **Validation:** config entity forms don't auto-validate, so `validateForm()` builds the entity and calls `$entity->getTypedData()->validate()` explicitly. The `DisplayModeSwitcherValidDisplayMode` constraint (`ValidDisplayModeValidator`) checks `source_display_mode` and `target_display_mode` against `EntityDisplayRepositoryInterface::getViewModeOptions($entityType)`; violations map 1:1 to the top-level field names.

## Config schema (`display_mode_switcher.schema.yml`)
`display_mode_switcher.display_mode_switcher_rule.*` → `config_entity` mapping (id, label, entity_type, bundle, source_display_mode, target_display_mode, weight, status, conditions). `conditions` is a `sequence` of `condition.plugin.[id]` — the dynamic schema key that maps each condition's config to its `condition.plugin.{id}` type, reusing core's condition schema.

## Export / deploy
Rules are standard config entities. `drush config:export` writes `display_mode_switcher.display_mode_switcher_rule.{id}.yml`. Fully deployable and version-controllable.

## Operating tips
- Lower weight = evaluated first; first match wins. Build hierarchies (e.g. subscriber rule at weight 10 keeping `full`; no-condition paywall rule at weight 20).
- A rule with **no conditions always matches** — useful as a catch-all fallback.
- Target/source modes must exist and be enabled on the entity type's Manage display page, or the form rejects the rule.
- `drush cr` after config changes.
