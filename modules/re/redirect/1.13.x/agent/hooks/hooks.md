# Hooks — `redirect.api.php`

## `hook_redirect_response_alter(TrustedRedirectResponse $response, Redirect $redirect)`

Invoked just before a redirect response is sent, with the matched redirect entity. Use it to
change the target, add a message, or add cacheability.

```php
use Drupal\Core\Routing\TrustedRedirectResponse;
use Drupal\redirect\Entity\Redirect;

function mymodule_redirect_response_alter(TrustedRedirectResponse $response, Redirect $redirect) {
  if (!$redirect->getRedirectUrl()->isExternal()) {
    \Drupal::messenger()->addWarning(t('Redirecting within the site.'));
  }
  // Override the destination when needed:
  // $response->setTrustedTargetUrl('https://example.com');
}
```

## Entity CRUD hooks

Because `redirect` is a content entity, the standard generic hooks fire on save/load/delete
(as documented in `redirect.api.php`): `hook_redirect_presave/insert/update/load/delete`,
`hook_redirect_prepare_form`, `hook_redirect_validate`, plus the equivalent
`hook_entity_*` hooks. Use these to react to redirects being created or changed (e.g. logging,
syncing to an external system).
