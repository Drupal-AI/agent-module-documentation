# Programmatic API — services, entity, access check, hook

## Token manager — `access_unpublished.access_token_manager`

`Drupal\access_unpublished\AccessTokenManager`:

```php
/** @var \Drupal\access_unpublished\AccessTokenManager $mgr */
$mgr = \Drupal::service('access_unpublished.access_token_manager');

$mgr->getAccessTokensByEntity($node);            // all tokens for an entity
$mgr->getAccessTokensByEntity($node, 'active');  // 'active' | 'expired' | NULL(all)
$token = $mgr->getActiveAccessToken($node);      // first active token or NULL
$mgr->getAccessTokens('expired');                // all tokens site-wide by status

// Build the shareable URL (canonical or latest-version) with the hash query param:
$url = $mgr->getAccessTokenUrl($token, \Drupal::languageManager()->getCurrentLanguage());
```

Applicability: `AccessUnpublished::applicableEntityType($entityType)` — TRUE when the entity type
implements `EntityPublishedInterface` and has a `canonical` link template.

## Create a token in code — `access_token` content entity

```php
$token = \Drupal::entityTypeManager()->getStorage('access_token')->create([
  'entity_type' => $node->getEntityType()->id(),
  'entity_id'   => $node->id(),
  'label'       => 'Client review',
  // seconds from now, or -1 for unlimited:
  'expire'      => \Drupal::time()->getRequestTime() + 172800,
]);
$token->save();   // 'value' (the secret hash) is auto-generated in preSave() via Crypt::hmacBase64
```

Entity: `Drupal\access_unpublished\Entity\AccessToken` (id `access_token`, base table `access_token`).
Key fields: `value`, `label`, `expire` (timestamp; `-1`/`>0`), `entity_type`, `entity_id`, `user_id`,
`created`, `changed`. Methods: `getHost()` (the referenced content), `isExpired()`,
`AccessToken::defaultExpiration()`, `getCreatedTime()`. `DEFAULT_EXPIRATION_PERIOD = 172800`.

## How access is granted (no code needed)

- `access_unpublished.token_getter` (`TokenGetter`) — a REQUEST event subscriber that reads the token
  value from the `hash_key` query parameter (default `auHash`) of the current request.
- `access_unpublished_entity_access()` (`hook_entity_access`) — on a `view` of an unpublished
  applicable entity, if a token is present, the user holds `access_unpublished <type>[ <bundle>]`,
  and a non-expired `access_token` matches (`entity_type`, `entity_id`, `value`), returns
  `AccessResult::allowed()` (cache max-age = seconds until expiry).
- `access_unpublished.add_http_header` (`AddHttpHeaders`) — a RESPONSE subscriber that adds the
  configured `modify_http_headers` when a token is active on the request.

## Hook — `access_unpublished.api.php`

```php
function hook_access_unpublished_duration_options_alter(array &$options) {
  unset($options[-1]);                       // remove the "Unlimited" option
  $df = \Drupal::service('date.formatter');
  $options[2419200] = $df->formatInterval(2419200);  // add a "4 weeks" option
}
```

Alters the Lifetime select options shown on both the entity form and the settings form.
