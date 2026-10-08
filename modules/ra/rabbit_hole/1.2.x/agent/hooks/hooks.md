# Hooks

Declared in `rabbit_hole.api.php`.

## `hook_rabbit_hole_values_alter(array &$values, ContentEntityInterface $entity)`

Alter the resolved Rabbit Hole values **before** the behavior plugin runs. `$values` includes
`rh_action` and `bypass_access`. Use it to force-display translations, disable access bypass,
or switch the action conditionally.

```php
function mymodule_rabbit_hole_values_alter(array &$values, \Drupal\Core\Entity\ContentEntityInterface $entity) {
  $values['bypass_access'] = FALSE;
  if ($entity->isTranslatable() && $values['rh_action'] === 'access_denied') {
    $values['rh_action'] = 'display_page';
  }
}
```

## `hook_rabbit_hole_response_alter(Response &$response, ContentEntityInterface $entity)`

Alter the `Response` **after** the plugin's `performAction()`. Typical use: rewrite a redirect
target.

```php
function mymodule_rabbit_hole_response_alter(\Symfony\Component\HttpFoundation\Response &$response, $entity) {
  if ($response instanceof \Symfony\Component\HttpFoundation\RedirectResponse) {
    $response = new \Drupal\Core\Routing\TrustedRedirectResponse('https://example.com');
  }
}
```

Also available: `hook_rabbit_hole_rabbit_hole_behavior_plugin_info_alter()` (the behavior
plugin manager's `alterInfo`) to modify behavior plugin definitions.
