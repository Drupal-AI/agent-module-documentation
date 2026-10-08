# Email confirmer — hooks

Source: `email_confirmer.api.php`.

## `hook_email_confirmer($op, EmailConfirmationInterface $confirmation)`
Invoked (via `moduleHandler()->invokeAll()`) when a confirmation response is received — from
`EmailConfirmation::confirm()` and `::cancel()`.

- `$op` — `'confirm'` or `'cancel'`.
- `$confirmation` — the confirmation entity (check `getRealm()`, `getEmail()`, `getProperty()`).

```php
function mymodule_email_confirmer($op, \Drupal\email_confirmer\EmailConfirmationInterface $confirmation) {
  if ($confirmation->getRealm() !== 'mymodule') {
    return;
  }
  if ($op === 'confirm') {
    // e.g. subscribe $confirmation->getEmail() to a list.
  }
}
```
The submodule `email_confirmer_user` uses this hook to apply a confirmed user email change — see its
docs for a full worked example.
