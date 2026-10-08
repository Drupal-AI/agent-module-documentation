<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enforcement — the USER_SYNC subscriber (events)

The whole module is one event subscriber:
`Drupal\samlauth_restrict_to_ou\EventSubscriber\SamlRestrictSubscriber` (service
`samlauth_restrict_to_ou.restrict_subscriber`, args `@config.factory`, `@messenger`).

`getSubscribedEvents()` registers two callbacks:

| Event | Constant | Priority | Method |
|---|---|---|---|
| `samlauth.user_sync` | `SamlauthEvents::USER_SYNC` | `10` | `onUserSync` |
| `kernel.response` | `KernelEvents::RESPONSE` | `-10` | `onResponse` |

## Where USER_SYNC sits in samlauth's flow

samlauth fires `USER_SYNC` **after** the IdP response is validated but **before** the Drupal user is
logged in, and a subscriber may throw to abort. Concretely, in samlauth's `SamlService::doLogin()`:
- **Existing/linked account:** `synchronizeUserAttributes()` (which dispatches `USER_SYNC`) is called
  *before* `externalAuth->userLoginFinalize()`. Throwing here means the login never happens — no session.
- **New account:** `externalAuth->register()` saves the user, and samlauth's `hook_user_presave()`
  dispatches `USER_SYNC` *during* that save. Throwing there makes the entity save abort (Drupal wraps
  it in `EntityStorageException`), so no account is persisted and `userLoginFinalize()` is never reached.

So the OU check runs before both provisioning and session creation, and a rejected user is left with
neither an account nor a session — the gate is enforced pre-login and fails closed.

## onUserSync() logic (`SamlRestrictSubscriber.php:62`)

1. If `enabled` is false → `return` (no restriction; all SAML users pass).
2. Read `saml_attribute_name`, `allowed_ous`, `strict_mode`. If `saml_attribute_name` or `allowed_ous`
   is empty → `return` (no restriction applied). *An enabled restriction with an empty allow-list
   admits everyone — always populate `allowed_ous` when `enabled` is on.*
3. Build the allow-list: split `allowed_ous` on `\n`, `trim`, drop empties, `strtolower` each.
4. Read the attribute values: `$event->getAttributes()[$saml_attribute_name] ?? []` (coerced to array).
5. Extract OUs from each value with `preg_match_all('/OU=([^,]+)/i', $dn, $m)` → collect `$m[1]`,
   `trim`+`strtolower` each. (So a DN like `CN=jdoe,OU=Staff,OU=Users,DC=corp` yields `staff`, `users`.)
6. Decide:
   - **strict_mode = true:** `array_diff(allowed_lower, extracted_lower)` must be empty — i.e. every
     listed OU must be present in the user's OUs (AND).
   - **strict_mode = false (default):** grant if any extracted OU is `in_array()` the allow-list (OR).
7. If not granted: `messenger->addError(denied_message)` then
   `throw new \Exception("SAML_OU_RESTRICT_BLOCK")` — this exception is what aborts the login.

**Matching is case-insensitive EXACT string equality on whole OU components**, not substring/prefix.
Allow-list `Finance` admits a user with `OU=Finance` but not one whose only OU is
`OU=Finance Contractors` (that extracts to `finance contractors`, which is not equal to `finance`).

If the configured attribute is absent from the assertion, step 4 yields `[]`, step 5 yields no OUs,
and both branches deny (strict: allow-list still "missing"; non-strict: nothing matches) — again
failing closed.

## onResponse() (`SamlRestrictSubscriber.php:121`)

Runs on every response while `enabled` is true. It scans `messenger->all()['error']`; if any error
message contains the configured `denied_message`, it deletes all `error`-type messages and re-adds a
single HTML-formatted copy (`Markup::create('<br /><p><strong>' . $custom_msg . '</strong></p><br />')`).
Purely presentational — it makes the rejection notice stand out. `denied_message` is admin-configured
(behind `administer samlauth_restrict_to_ou`) and rendered as trusted markup here, which is why the
settings help text says basic HTML is supported.
