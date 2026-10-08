# Email confirmer — service & entity API

## The `email_confirmer` service
`Drupal\email_confirmer\EmailConfirmerManager` (interface `EmailConfirmerManagerInterface`).
```php
$m = \Drupal::service('email_confirmer');           // or inject '@email_confirmer'

// Start (or reuse) a confirmation and email the address a link. Returns the entity.
$confirmation = $m->confirm(string $email, array $data = [], string $realm = '');

// Query existing confirmations.
$m->getConfirmations(string $email, $status = FALSE, int $limit = 0, string $realm = '');  // array
$m->getConfirmation(string $email, $status = FALSE, string $realm = '');                    // one or null
$m->createConfirmation(string $email);   // build an unsaved confirmation entity to customize
```
`$status` values are the entity flags: `'pending'`, `'sent'`, `'confirmed'`, `'cancelled'`,
`'expired'`. `$realm` scopes a confirmation to a feature so different modules don't collide.

## The `email_confirmer_confirmation` content entity
`Drupal\email_confirmer\Entity\EmailConfirmation` (interface `EmailConfirmationInterface`). No bundles;
add fields programmatically. Useful methods:
```php
$c->getEmail(); $c->getStatus(); $c->getHash();
$c->isPending(); $c->isConfirmed(); $c->isCancelled(); $c->isExpired(); $c->isPrivate();
$c->setRealm($realm); $c->setPrivate(); $c->setProperty($k, $v); $c->getProperty($k);
$c->setResponseUrl(Url $url, $op);   // $op: 'confirm' | 'cancel' | 'error'
$c->sendRequest();                    // (re)send the request email; respects resend delay + queue
$c->confirm($hash);                   // verify hash and mark confirmed; invokes hook_email_confirmer
$c->cancel();                         // mark cancelled; invokes hook_email_confirmer
```
Typical custom flow:
```php
$c = $m->createConfirmation($email);
$c->setRealm('newsletter')->setProperty('list', 42)
  ->setResponseUrl(Url::fromRoute('<front>'), 'confirm')
  ->sendRequest();
$c->save();
```

## Routes & the hash
`email_confirmer.routing.yml`:
- `entity.email_confirmer_confirmation.response_form` — `/email-confirmer/reply/{uuid}/{hash}`.
  `{uuid}` resolved by the `email-confirmer-confirmation-uuid` param converter
  (`src/ParamConverter/UuidConverter.php`); `{hash}` must match `^[a-zA-Z0-9\-_]{43}$`. Access is the
  entity `response` operation (see permissions doc), but `confirm()` still requires the hash to match.
- `entity.email_confirmer_confirmation.resend` — `/email-confirmer/resend/{confirmation}`; requires
  `access email confirmation` + `_csrf_token`.

Hash (in `EmailConfirmation::getHash()`):
`Crypt::hmacBase64($email . $created . $ip, \Drupal::service('private_key')->get())`. It is the actual
security gate on the confirmation link — a 43-char base64 HMAC keyed by the site private key.

## Email
`hook_mail()` key `confirmation_request` (see `email_confirmer.module` / `.tokens.inc`). The subject &
body come from settings and are token-replaced; tokens include
`[email-confirmer:confirmation-mail]`, `[email-confirmer:confirmation-url]`.
