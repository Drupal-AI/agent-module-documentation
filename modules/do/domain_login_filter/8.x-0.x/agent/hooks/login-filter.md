<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The domain login filter (hook + validator)

All logic lives in `domain_login_filter.module` — no classes, no config. Two functions.

## Install & enable

```bash
composer require drupal/domain_login_filter
drush en domain_login_filter -y
```

Declared dependency: `domain:domain`. **Also enable the Domain Access submodule** (`domain_access`)
— the validator calls the `domain_access.manager` service, which only exists when `domain_access`
is on. `domain_access` is *not* listed in `domain_login_filter.info.yml`, so Drupal will not pull
it in automatically; enable it yourself.

There is **no settings form** and no config object. The module works on enable; the only "setup"
is making sure each user's Domain Access assignments are correct, since those assignments decide
who may log in where. User 1 (superuser) is always exempt.

## `domain_login_filter_form_alter()` — where it hooks in

`hook_form_alter()`. For form IDs **`user_login_form`** and **`user_pass`** (the password-reset
*request* form) it rebuilds `$form['#validate']`, inserting the callback
`'_domain_login_filter_domain_check'` right after the validator at index `0`:

```php
foreach ($form['#validate'] as $source_id => $value) {
  $new_validate[] = $value;
  if ($source_id == 0) {
    $new_validate[] = '_domain_login_filter_domain_check';
  }
}
```

Only these two form IDs are altered.

## `_domain_login_filter_domain_check()` — the rule

1. `$name = $form_state->getValue('name')` (the submitted username/email).
2. `$user = user_load_by_name($name)`; if empty, `$user = user_load_by_mail($name)`.
3. If still no account → **return** (no error; core credential validation handles a bad
   identifier).
4. If `$user->id() == 1` → **return** (superuser exempt on every domain).
5. `$available_domains = \Drupal::service('domain_access.manager')->getAccessValues($user)`.
6. `$active_domain = \Drupal::service('domain.negotiator')->getActiveDomain()->getDomainId()`.
7. If `array_search($active_domain, $available_domains, TRUE) === FALSE` →
   `$form_state->setErrorByName('name', t('The username %name has not been activated or is blocked on this domain.', …))`.

The strict (`TRUE`) `array_search` means the active domain ID must match an assigned domain ID
exactly. An empty assignment set therefore fails the check (the user is blocked), so an
unassigned user cannot log in.

## How to operate it

- Create your domains and assign each user to the domain(s) they should sign in on (user account
  page, or bulk via Domain Access). That assignment is the only lever this module reads.
- To change who can log in where, change the assignments — there is nothing else to configure.
- Verify: take a user assigned to domain A but not B; the login form on B is refused with the
  "…blocked on this domain" error, while login on A succeeds.

## Scope & gotchas (important)

- **Two forms only.** The check runs on `user_login_form` and `user_pass`. It is a login-time
  form validation, not a per-request session check, and it does not touch non-form authentication.
  Treat it as scoping the interactive login *form*, not as a per-request domain firewall.
- **Requires `domain_access`.** Without the `domain_access` submodule the `domain_access.manager`
  service is undefined and the altered forms will error. Enable `domain_access`.
- **`getActiveDomain()`** must resolve to a domain for the check to run meaningfully (e.g. a
  properly negotiated request); a context with no active domain will not behave like a normal web
  request.
- No permissions, routes, services, Drush commands, config schema or submodules are provided.
