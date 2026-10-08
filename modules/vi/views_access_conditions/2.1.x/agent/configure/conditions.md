<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Views access & conditional visibility

## 1. Gate a whole view (access plugin)
Edit a view → **Access** → choose **Conditions** → configure condition plugins (role, request path, node type, etc.). At runtime:
- `Conditions::access(AccountInterface $account)` calls `conditions_helper.evaluator->evaluateConditions($this->options['conditions'])`.
- `Conditions::alterRouteDefinition()` also JSON-encodes the conditions into the route's `_conditions` requirement, checked by `ConditionsAccessCheck` (service tag `access_check`, `applies_to: _conditions`).

Options are stored on the display: `display.options.access = { type: views_access_conditions, options.conditions: {…} }`.

## 2. Conditional fields / filters / arguments
On a **field**, **filter**, or **argument** config item form, a "Views Access Conditions" details section appears (`ViewsAlters::formAlter`). Conditions are saved into the view's third-party settings, keyed by display / handler-type / handler-id:
```
views.view.<id>.third_party.views_access_conditions:
  <display_id>:
    field|filter|argument:
      <handler_id>: { …condition config… }
```
Enforcement:
- `hook_views_pre_build` → `ViewsAlters::preBuildAlter()` evaluates each handler's conditions; on FALSE it `unset()`s the handler (and for `argument`, also unsets the matching `$view->args[$i]`).
- `hook_form_views_exposed_form_alter` → `exposedFormAlter()` sets `#access = FALSE` on exposed-filter inputs whose conditions fail.

## 3. Admin allow-list (which conditions are offered)
`/admin/config/system/views-access-conditions` — form `SettingsForm` (extends `conditions_helper`'s `ConditionSelectorSettingsFormBase`), permission `administer views access conditions` (`restrict access: true`).
```yaml
# views_access_conditions.settings
enabled_conditions: []   # empty = ALL conditions available
```
When non-empty, `ConditionsAccessCheck::access()` also does `array_intersect_key()` on the provided conditions, so only allow-listed conditions are evaluated for route access.

## Default-allow behavior (by design)
- `ConditionsAccessCheck::access()` returns `AccessResult::neutral()` if `_conditions` decodes to NULL, and `AccessResult::allowed()` when there are no (effective) conditions.
- A display with the Conditions access plugin but **zero conditions configured is accessible**. Configure at least one condition to actually restrict access.
