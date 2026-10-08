<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Switch mechanism: hook + `ViewModeSwitcher`

## Entry point

`entity_role_view_mode_switcher.module` implements one hook:

```php
function entity_role_view_mode_switcher_entity_view_mode_alter(&$view_mode, EntityInterface $entity, $context) {
  $view_mode = ViewModeSwitcher::switchViewModes($entity, $view_mode, \Drupal::currentUser()->getRoles());
}
```

Core calls `hook_entity_view_mode_alter()` from `EntityViewBuilder::getBuildDefaults()` while building any
entity's render array, so this fires for every rendered entity of every type.

## Algorithm — `ViewModeSwitcher::switchViewModes()`

`src/Util/ViewModeSwitcher.php`, static method `switchViewModes(EntityInterface $entity, string $viewMode,
array $roles): string`:

1. If `$entity` is not a `FieldableEntityInterface`, return `$viewMode` unchanged.
2. Scan `$entity->getFieldDefinitions()` for the **first** field of type `entity_reference` whose
   `target_type` setting is `rule`. If none, return `$viewMode` unchanged. (Only one such field is supported;
   it `break`s on the first match.)
3. Build the qualified original view mode: `$qualifiedOriginalViewMode = "<entity_type_id>.<viewMode>"`.
4. Load the referenced rules: `$entity->get($fieldName)->referencedEntities()` → `RuleInterface[]`.
5. For each rule, for each of its `getConditions()`:
   - Match when `condition['original_view_mode_id'] === $qualifiedOriginalViewMode` **and** the role test
     passes: `negate ? !in_array(role_id, $roles, TRUE) : in_array(role_id, $roles, TRUE)`.
   - On match: `[$type, $viewMode] = explode('.', condition['new_view_mode_id'])` — `$viewMode` becomes the
     new (unqualified) view mode, then `break` out of the **inner** conditions loop.
6. Return `$viewMode`.

## Ordering caveats (from source)

- The inner loop `break`s on the first matching condition **within a rule** ("first ones take precedence").
  The **outer** rules loop does not break, so if multiple referenced rules each match, a **later rule can
  overwrite** an earlier rule's result. Practical guidance: put competing conditions in one rule, in
  priority order.
- Only the entity-reference field's `target_type` matters; the field name is arbitrary.
- `new_view_mode_id` is split on `.` and only the second segment (the view mode) is used; the entity-type
  segment is discarded, so the module trusts the admin to keep original/new on the same entity type (the form
  help text says so).

## Enabling it on a bundle

1. Enable the module: `drush en entity_role_view_mode_switcher -y`.
2. Create at least one rule at `/admin/structure/entity_role_view_mode_switcher_rule/add` (see
   [../config/rule-entity.md](../config/rule-entity.md)).
3. Add an **Entity reference** field to the target bundle (e.g. a content type) with **Type of item to
   reference = View Mode Switcher Rule** (`rule`).
4. Edit an entity of that bundle and select the rule(s). When that entity is viewed in the configured
   original view mode, the role-matched condition swaps the display.

If no reference field exists, no rule is selected, or no condition matches, the originally requested view
mode renders unchanged.
