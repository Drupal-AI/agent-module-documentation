# Hooks

## `hook_agreement_handler_alter(Agreement|false &$agreement, AccountProxyInterface $account, array $context)`

Documented in `agreement.api.php`. Fires at the end of
`AgreementHandler::getAgreementByUserAndPath()`, after path/role/agreed processing, letting you
change, replace or unset (`FALSE`) the agreement that will be enforced for this request. It is
**not** called when the current path matches a default exception or any agreement's own path.

`$context` contains:
- `path` — current request path.
- `types` — all agreement entities keyed by id.
- `exceptions` — the default excluded paths.
- `handler` — the `agreement.handler` service (call `canAgree()` / `hasAgreed()`).

`$account` is the current user and must not be altered.

```php
function mymodule_agreement_handler_alter(&$agreement, $account, array $context): void {
  // Never interrupt uid 1.
  if ((int) $account->id() === 1) {
    $agreement = FALSE;
  }
  // Swap in a per-domain agreement, etc. (see agreement.api.php for a full example).
}
```

## `hook_mail()` — implemented by this module (`agreement.module`)

Keys sent via `agreement` mail when an agreement's `settings.recipient` is set:

| Key | Trigger | Subject/body |
|---|---|---|
| `notice` | User accepts | "%site_name: %username accepted %agreement" |
| `revoked` | User revokes | "%site_name: %username revoked acceptance of %agreement" |

The acceptance form (`Drupal\agreement\Form\AgreementForm::notify()`) only mails on a user's first
acceptance or on a revoke. Placeholders come from `_agreement_get_mail_variables()`.

`agreement.module` also exposes `agreement_get_agreement_options()` (id → label map, used as the
Views filter options callback).
