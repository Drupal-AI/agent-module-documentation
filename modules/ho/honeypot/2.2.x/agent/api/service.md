# Honeypot API — protect a form in code

Service id `honeypot` (`Drupal\honeypot\HoneypotServiceInterface`, autowired). Public methods:

```php
getProtectedForms(): array                 // form_ids honeypot protects
getTimeLimit(array $form_values = []): int  // computed time limit for current user
addFormProtection(array &$form, FormStateInterface $form_state, array $options = []): void
logFailure(string $form_id, string $type): void  // $type: 'honeypot' | 'honeypot_time'
```

Protect your own form (options: `'honeypot'` for the hidden field, `'time_restriction'` for
the timer — omit to add both):

```php
public function buildForm(array $form, FormStateInterface $form_state) {
  // ... your fields ...
  \Drupal::service('honeypot')
    ->addFormProtection($form, $form_state, ['honeypot', 'time_restriction']);
  return $form;
}
```

Honeypot also auto-applies protection via `hook_form_alter` based on the settings
(`protect_all_forms` / per-form `form_settings`), so manual calls are only needed for forms you
want to force. To fine-tune which protections are applied, use
[hooks](../hooks/hooks.md).
