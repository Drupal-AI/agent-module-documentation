# Form alters (where the description shows)

Both hooks live in `includes/role_description.form.inc` (included from
`role_description.module`). Each reads the same map
(`\Drupal::config('role_description.settings')->get('role_description')`) and sets every
value as the `#description` on the matching role element.

| Hook | Target form | Element that receives `#description` |
| --- | --- | --- |
| `role_description_form_user_form_alter` | `user_form` (BASE_FORM_ID — user add/edit) | if `role_delegation` is enabled **and** `$form['role_change']['#access']` is truthy → `$form['role_change']['widget'][$role]`; otherwise `$form['account']['roles'][$role]` |
| `role_description_form_role_delegation_role_assign_form_alter` | `role_delegation_role_assign_form` (FORM_ID) | `$form['account']['role_change'][$role]` |

Notes for integrators:

- The description string is placed on `#description`, so it renders under the role checkbox
  through the standard `form-element` template.
- The map is keyed by role machine name. Keys are applied blindly with no `isset()` guard,
  so a stale key for a deleted role just attaches to a missing element index — keep the
  config in sync with your roles.
- The `user_form` alter changes anything only when the roles widget is actually present and
  visible (i.e. for users who may edit roles). `anonymous` / `authenticated` never have
  descriptions — the settings form excludes them.
- `role_delegation` integration: when that module is enabled, descriptions attach to its
  delegated role-change widget on the account form and to its standalone
  `role_delegation_role_assign_form`. The user_form branch only switches to the delegated
  widget when `$form['role_change']['#access']` is truthy.
