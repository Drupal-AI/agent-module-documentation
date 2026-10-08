# Hooks (antibot.api.php)

Implement in `MYMODULE.module`.

### `hook_antibot_form_status_alter(string $form_id, bool &$protection)`
Force-enable or disable Antibot protection for a specific form, overriding the settings list.
```php
function mymodule_antibot_form_status_alter(string $form_id, bool &$protection) {
  if ($form_id === 'my_form_id') {
    $protection = TRUE;
  }
}
```

### `hook_antibot_reject($form_id, $uid)`
Invoked when Antibot rejects a submission. `$uid` is 0 for anonymous, otherwise the user ID.
Use it to log, count, or alert on blocked bot attempts.
```php
function mymodule_antibot_reject($form_id, $uid) {
  \Drupal::logger('mymodule')->notice('Antibot rejected @f (uid @u)', ['@f' => $form_id, '@u' => $uid]);
}
```

### `hook_antibot_generate_key_alter($form_id, &$key_encrypted)`
(Invoked from `antibot.module`.) Alter the encrypted per-form key before it is attached.
