<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the login redirect

The module has one settings form and one config object. Everything it does at login is driven
by those two keys.

## Settings form

- Route: `localgov_login_redirect.settings` → `/admin/config/system/localgov_login_redirect`
- Permission: `administer site configuration` (core; the module defines none of its own)
- Form class: `\Drupal\localgov_login_redirect\Form\LoginRedirectSettingsForm`
  (`ConfigFormBase`, form id `localgov_login_redirect_settings_form`)
- Menu link: `localgov_login_redirect.settings`, parent `system.admin_config_system`

| Field | `#type` | Config key | Notes |
|-------|---------|------------|-------|
| Enable login redirect | checkbox | `enabled` | Master on/off switch. |
| User redirect path | textfield | `redirect_path` | The Drupal path to send users to after login, e.g. `/admin/content`. |

`validateForm()` rejects a non-empty `redirect_path` that fails `path.validator`'s `isValid()`
with the error "Redirect path is invalid." `submitForm()` stores `enabled` as the boolean
`getValue('enabled') === 1` and saves `redirect_path` verbatim.

## Config object & schema

Config object `localgov_login_redirect.settings` (schema `localgov_login_redirect.schema.yml`,
type `config_object`), shipped defaults in `config/install`:

```yaml
enabled: true            # boolean
redirect_path: '/admin/content'   # string
```

## Set it without the form

Drush:

```bash
drush config:set localgov_login_redirect.settings enabled true
drush config:set localgov_login_redirect.settings redirect_path '/admin/content'
```

PHP:

```php
\Drupal::configFactory()->getEditable('localgov_login_redirect.settings')
  ->set('enabled', TRUE)
  ->set('redirect_path', '/admin/content')
  ->save();
```

Setting `redirect_path` this way bypasses the form's `path.validator` check, so an invalid or
inaccessible path is not rejected — it simply produces no redirect at login (see below). Because
this is plain configuration it exports with `drush config:export` and changes without a code deploy.

## What happens at login

The behavior is `localgov_login_redirect_user_login(AccountInterface $account)` (an implementation
of `hook_user_login()`) in `localgov_login_redirect.module`. On each login it, in order:

1. Loads `localgov_login_redirect.settings`; if `enabled` is not strictly `TRUE`, returns (no redirect).
2. Reads the current route (`\Drupal::routeMatch()->getRouteName()`); if it is `user.reset` or
   `user.reset.login` (one-time login / password-reset links), returns — those flows are left alone.
3. If the request already has a `destination` query parameter, returns without touching it — an
   existing `?destination=` (from core, a link, or a form) always wins and is handled by core.
4. Otherwise takes `redirect_path` (falling back to `/admin/content` if the key is unset) and passes
   it through `\Drupal::service('path.validator')->getUrlIfValid($path)`. This both resolves the
   path and **access-checks it for the logging-in user**. If a valid `Url` comes back, it sets
   `$request->query->set('destination', $url->toString())` and core carries out the redirect. If the
   user has no access to the path, `getUrlIfValid()` returns `FALSE`, no destination is set, and core
   falls back to its default post-login page, `/user/{uid}`.

Consequence: there is a single global destination, not a per-role one. An editor with access to
`/admin/content` lands there; a user without that access lands on their own account page — the
difference is the access check in step 4, not any per-role configuration. The destination itself
comes only from admin config, never from user-supplied request input, and an existing request-supplied
`destination` is deferred to core rather than overridden.
