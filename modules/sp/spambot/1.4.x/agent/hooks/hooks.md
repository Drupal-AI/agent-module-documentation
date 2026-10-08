# Spambot hooks

Spambot does not ship a `spambot.api.php`, but it invokes one custom hook.

## `hook_spambot_registration_blocked($hook_args)`

Fired from both the registration validator (`spambot_user_register_form_validate()`) and the
`spambot_validation` Webform handler **when a submission is blocked** — but only if
`spambot_log_blocked_registration` is TRUE (the same flag that logs the block).

`$hook_args` is an associative array:

```php
[
  'request' => ['email' => ..., 'username' => ..., 'ip' => ...], // the values that were checked
  'reasons' => ['email=a@b.com', 'ip=203.0.113.5', ...],          // which criteria matched
]
```

Implement it to react to blocked spam attempts (e.g. increment a metric, notify an admin):

```php
function mymodule_spambot_registration_blocked(array $hook_args): void {
  \Drupal::logger('mymodule')->info('Spam blocked: @r', ['@r' => implode(',', $hook_args['reasons'])]);
}
```

Invoked via `\Drupal::moduleHandler()->invokeAll('spambot_registration_blocked', [$hook_args])`.
