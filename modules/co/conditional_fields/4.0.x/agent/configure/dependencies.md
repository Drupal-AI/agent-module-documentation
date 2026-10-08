# Configure field dependencies

![Conditional fields dependency list](../../../../../../../screenshots/conditional_fields/4.0.x/dependencies.png)

Manage at `/admin/structure/conditional_fields` (route `conditional_fields`) → pick entity type →
bundle, or use the **Manage Dependencies** local task on a bundle's config page
(`.../conditionals`, e.g. `/admin/structure/types/manage/{node_type}/conditionals`).
Permissions: `view/edit/delete conditional fields`.

## Workflow
1. On the bundle's conditional-fields form, choose the **dependent** field (the one that reacts)
   and one or more **controlling** fields, then save to create the dependency.
2. Edit the dependency (route `conditional_fields.edit_form`) to set:
   - **State** — what happens to the dependent field. Options include `visible`/`!visible`,
     `required`/`!required`, `disabled`/`!disabled`, `!empty`/`empty` (fill/clear),
     `checked`/`!checked`, `collapsed`/`!collapsed`, `readonly`/`!readonly`, `valid`/`!valid`,
     `touched`/`!touched`, `unchanged`.
   - **Condition** — the trigger on the controlling field: `value`, `empty`, `filled`,
     `checked`, etc.
   - **Value** to match, and the **values set / logic**: `widget` (match the widget's own input),
     `AND`, `OR`, `XOR`, `NOT`, or `regex`.
   - **Effect** for show/hide states: `show` (Show/Hide), `fade`, or `slide` (with a speed option).
     `fill` auto-populates the field with a configured value when its condition is met.

## As config
Dependencies are stored as third-party settings on the form-display config entity
(`core.entity_form_display.{entity_type}.{bundle}.default`) and covered by this module's
config schema, so they export with `drush config:export` and deploy like any other config.

Under the hood each dependency is translated into a core `#states` array by a handler plugin and
attached to the dependent element at form build (see
[../plugins/handler.md](../plugins/handler.md)).
