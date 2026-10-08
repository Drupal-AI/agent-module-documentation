# PET — hooks

Declared in `pet.api.php` (group registered via `pet_hook_info()`).

## `hook_pet_substitutions_alter(&$substitutions, $params)`

Add custom token objects/types for a PET send. `$substitutions` is the array later passed to
`Token::replace()` (keys become token types, values the objects); `$params` carries the send
context (`pet`, `pet_uid`, `pet_nid`, `pet_to`, `node`, etc.).

```php
function mymodule_pet_substitutions_alter(&$substitutions, $params) {
  if (isset($params['node']) && $params['node']->bundle() === 'event') {
    $substitutions['event'] = $params['node'];
  }
}
```

## `hook_default_pet()`

Provide code-based default templates (Entity-API style export/import). Return an array of
created `pet` entities keyed by machine name:

```php
function mymodule_default_pet() {
  $defaults['welcome'] = \Drupal::entityTypeManager()->getStorage('pet')->create([
    'name' => 'welcome',
    'title' => 'Welcome email',
    'subject' => 'Welcome, [user:display-name]',
    'mail_body' => 'Hello [user:display-name]…',
    'cc_default' => 'ops@example.com',
    'recipient_callback' => 'mymodule_welcome_recipients',
  ]);
  return $defaults;
}
```

A `hook_recipients_callback($node = NULL)` (the function named in a template's
`recipient_callback` field) returns an array of `uid|email` (or plain email) strings.
