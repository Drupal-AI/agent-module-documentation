# Honeypot hooks

From `honeypot.api.php`:

- **hook_honeypot_form_protections_alter(array &$options, array $form)** — change which
  protections are applied to a form. `$options` may contain `'honeypot'` and/or
  `'time_restriction'`; add or remove entries.
- **hook_honeypot_add_form_protection(array $options, array $form)** — fires after honeypot
  adds its protections to a form; use for tracking/analytics.
- **hook_honeypot_reject($form_id, $uid, $type)** — fires when a submission is rejected.
  `$uid` is 0 for anonymous; `$type` is `honeypot` (hidden field filled) or `honeypot_time`
  (submitted too fast). Honeypot's own implementation logs the failure.
- **hook_honeypot_time_limit($honeypot_time_limit, array $form_values, $number)** — return
  extra seconds to add to the time limit (`$number` = times the current user already tripped
  the trap). Use to harden forms that spammers hammer.

Example:

```php
function mymodule_honeypot_time_limit($limit, array $form_values, $number) {
  return !empty($form_values['risky_field']) ? 10 : 0;
}
```
