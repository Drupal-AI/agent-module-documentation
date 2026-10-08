# Hooks

Documented in `password_policy.api.php`.

## `hook_password_policy_show_policy_alter(&$show_password_policy_status, array $context)`

Alter whether the live policy-compliance status table is shown on a form. Set
`$show_password_policy_status` to FALSE to hide it. `$context` may contain
`form_state` (a `FormStateInterface`), letting you suppress the table on specific
forms.

```php
function mymodule_password_policy_show_policy_alter(&$show, array $context) {
  if (isset($context['form_state'])) {
    $info = $context['form_state']->getBuildInfo();
    if (($info['form_id'] ?? '') === 'user_notifications_settings_form') {
      $show = FALSE;
    }
  }
}
```

This is the only hook the module documents. The compliance table itself is injected
by `password_policy_form_user_form_alter()` (via `_password_policy_show_policy()`).
To add new password *rules*, define a PasswordConstraint plugin instead —
see plugins/password-constraint.md.
