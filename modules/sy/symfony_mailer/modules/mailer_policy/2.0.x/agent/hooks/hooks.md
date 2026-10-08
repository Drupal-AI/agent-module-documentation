# Hooks (`mailer_policy.api.php`)

## hook_mailer_adjuster_info_alter(array &$mailer_adjusters)
Alter the discovered `EmailAdjuster` plugin definitions — add, remove, or change adjusters
available to policies. Registered via the manager's `alterInfo('mailer_adjuster_info')`.

```php
function my_module_mailer_adjuster_info_alter(array &$mailer_adjusters): void {
  // e.g. hide the plain-text adjuster from the policy UI
  unset($mailer_adjusters['email_plain']);
}
```

To add a new adjuster, write an `#[EmailAdjuster]` plugin rather than altering here — see
[../plugins/email-adjuster.md](../plugins/email-adjuster.md). To act on emails imperatively
(outside a policy), use the base module's `hook_mailer_*` phase hooks.
