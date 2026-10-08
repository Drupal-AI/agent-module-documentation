# The `paragraphs_role_visibility` behavior plugin

A Paragraphs behavior (not a standalone plugin type — it plugs into the Paragraphs behavior system) plus a
`paragraph_access` hook that enforces the choice.

## Enable + configure (UI)

1. *Structure → Paragraphs types → edit a type → Behaviors* → enable **Paragraph visibility**.
2. Edit a paragraph (inside its host entity) → **Behavior** tab → select roles under "Available roles"
   and choose the operand (Any / All).

## The plugin (`src/Plugin/paragraphs/Behavior/ParagraphsRoleVisibility.php`)

- Annotation `@ParagraphsBehavior(id = "paragraphs_role_visibility", label = "Paragraph visibility")`,
  extends `ParagraphsBehaviorBase`.
- `buildBehaviorForm()` builds a `wrapper` fieldset:
  - `roles` — `checkboxes` of all roles (`Role::loadMultiple()`), plus a UI-only "Select all" option;
    **required**. Default = all roles.
  - `operand` — `radios`: `or` → "Any", `and` → "All"; default `or`; **required**.
  - Attaches library `paragraphs_role_visibility/paragraphs_role_visibility` (JS "select all" helper).
- `filterBehaviorFormSubmitValues()` strips the UI-only `wrapper.roles.all` value before saving.
- `settingsSummary()` shows "Paragraph visible for: <roles or 'all roles'>".
- `view()` is empty — this behavior does **not** alter rendering directly; access is enforced by the hook.

## Access enforcement (`src/Hook/ParagraphsRoleVisibilityHooks.php`)

`#[Hook('paragraph_access')] paragraphAccess(ParagraphInterface $entity, $operation, AccountInterface $account)`:

```
$access = AccessResult::neutral()->addCacheableDependency($entity);
if ($operation === 'view') {
  $allowed_roles = $entity->getBehaviorSetting('paragraphs_role_visibility', ['wrapper','roles']);
  if ($allowed_roles) {
    $access->addCacheContexts(['user.roles']);
    $operand = $entity->getBehaviorSetting('paragraphs_role_visibility', ['wrapper','operand']);
    // 'or':  forbidden if the user has NONE of the allowed roles (array_intersect empty)
    // 'and': forbidden if the user is MISSING any allowed role (array_diff non-empty)
  }
}
return $access;  // AccessResultForbidden | AccessResultNeutral
```

- Returns **forbidden** (which denies the `view` operation) or **neutral** (defers to other access checks).
- Correct cacheability: `user.roles` context + paragraph as cacheable dependency, so results cache safely
  per role set.

## Notes

- This is real **entity access** on the `view` operation — an unauthorized user does not get the
  paragraph's rendered output/data, so it is suitable as access control (not merely visual hiding).
- If no roles are configured on a paragraph, access stays neutral (visible to all, subject to other
  checks). The form defaults to all roles selected.
- Legacy (pre-2.x) settings stored a flat role list; `hook_update_9201` rewrites them into
  `wrapper.roles` + `operand => 'or'` across every paragraph revision.
