<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Require Login

Config object: **`require_login.settings`**. UI: `/admin/config/people/login-requirements`
(route `require_login.settings`, permission `administer require login`). Saving the form runs
`drupal_flush_all_caches()` so changes take effect immediately.

## Config keys

```yaml
login_path: ''            # login page path; blank => /user/login
login_message: ''         # warning shown to the user after redirect (blank = none)
login_destination: ''     # fixed post-login path; blank => return to the requested URL
requirements:             # condition-plugin configs, AND-combined
  request_path:
    id: request_path
    negate: false
    pages: ''             # blank => matches everywhere (login required on ALL pages)
extra:
  include_403: false      # also gate the access-denied page (recommended)
  include_404: false      # also gate the not-found page (recommended)
```

## Default behavior

Out of the box **every page requires login**: the `request_path` condition has empty `pages`,
which evaluates TRUE for all paths. Anonymous users are redirected to the login page. These
routes stay reachable regardless (`LoginRequirementsManager::PROTECTED_ROUTES`):
`user.login`, `user.register`, `user.pass`, `user.reset*`, `image.style_public`,
`system.css_asset`, `system.js_asset`.

## Narrowing where login is required

The **Requirements** fieldset shows core condition plugins (Request Path plus other
context-aware conditions; `node_type`, `user_role`, `current_theme` are intentionally hidden).
All configured conditions are AND-combined — each must pass (or be neutral) to enforce login.

- **Only on some paths:** set `requirements.request_path.pages` to a newline list
  (e.g. `/members\n/members/*`) with `negate: false` → login required only on those paths.
- **Everywhere except some paths:** same `pages` list with `negate: true` → login required
  everywhere but those paths.

## Set config in code

```php
$c = \Drupal::configFactory()->getEditable('require_login.settings');
$c->set('login_message', 'Members only. Please log in.')
  ->set('login_destination', '/dashboard')
  ->set('extra.include_403', TRUE)
  ->set('requirements', [
    'request_path' => ['id' => 'request_path', 'negate' => FALSE, 'pages' => "/private\n/private/*"],
  ])
  ->save();
```

Read a value: `\Drupal::config('require_login.settings')->get('extra.include_403');`
or `drush config:get require_login.settings requirements.request_path.pages`.
