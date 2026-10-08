# Agreement handler service

Service `agreement.handler` → `Drupal\agreement\AgreementHandler` (final), implementing
`AgreementHandlerExtendedInterface` (extends `AgreementHandlerInterface`). This is the single
place that resolves, checks and records agreements. Inject it or use
`\Drupal::service('agreement.handler')`.

Constructor deps: `database`, `settings`, `entity_type.manager`, `path.matcher`,
`datetime.time`, `request_stack`, `module_handler`.

## Methods

| Method | Returns | Purpose |
|---|---|---|
| `getAgreementByUserAndPath(AccountInterface $account, string $path)` | `Agreement\|false` | Core lookup. Skips default exceptions and all agreement paths; filters to agreements whose roles the account has; returns the first that applies to `$path` and is not yet agreed. Fires `hook_agreement_handler_alter`. |
| `agreementAppliesToPath(Agreement $a, string $path)` | `bool` | Applies the visibility rule (setting `0` = all-except-listed, `1` = only-listed) via `path.matcher`. |
| `hasAgreed(Agreement $a, AccountInterface $account)` | `bool` | Anonymous → cookie check; authenticated → DB check honoring `frequency`. |
| `lastAgreed(Agreement $a, UserInterface $account)` | `int` | Timestamp of last acceptance, or `-1`. |
| `canAgree(Agreement $a, AccountInterface $account)` | `bool` | `!hasPermission('bypass agreement') && $a->accountHasAgreementRole($account)`. |
| `agree(Agreement $a, AccountInterface $account, int $agreed = 1)` | `bool\|Cookie` | Records acceptance. Authenticated → deletes prior rows then inserts into `{agreement}` (returns `bool`). Anonymous → returns a `Symfony …\Cookie` (`agreement_anon_<id>`). Pass `$agreed = 0` to revoke. |
| `isAnonymousAgreement(Agreement $a, AccountInterface $account)` | `bool` | True when the account is anonymous and the agreement targets the `anonymous` role. |
| `prefixPath(string $value)` (static) | `string` | Adds a leading `/`. |

## How authenticated acceptance is stored

`agreeWhileLoggedIn()` runs in a DB transaction: `DELETE FROM {agreement} WHERE uid = <current
uid> AND type = <agreement id>`, then `INSERT` a row `{uid, type, agreed, sid: session_id(),
agreed_date: request_time}`. The `uid` is always the passed account's id (the form passes
`current_user`) — acceptance is keyed to the current user, never a request parameter.

`hasAuthenticatedUserAgreed()` reads the latest `agreed` flag for `(uid, type)`. When
`frequency == 0` it additionally requires `sid == session_id()` (re-accept each login); otherwise
it requires `agreed_date >= max(reset_date, now − frequency·days)`.

## Anonymous acceptance

When the agreement targets `anonymous`, acceptance is a cookie `agreement_anon_<id>` (SameSite
lax) rather than a DB row; expiry is `+1 year` for `frequency == 365`, `+10 years` for
once-only, else a session cookie. `hasAnonymousUserAgreed()` just checks the cookie's presence.

## Entity helpers (`Drupal\agreement\Entity\Agreement`)

`getSettings()` (merges defaults), `agreeOnce()`, `getAgreementFrequencyTimestamp()`,
`accountHasAgreementRole($account)`, `getVisibilityPages()`, `getVisibilitySetting()`,
`getDefaultSettings()`.
