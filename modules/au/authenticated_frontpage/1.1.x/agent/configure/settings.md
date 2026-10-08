<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the authenticated front page

Settings form `Drupal\authenticated_frontpage\Form\SettingsForm` (form id `authenticated_frontpage`),
route `authenticated_frontpage.settings_form` at `/admin/config/system/authenticated-frontpage`,
gated by permission `administer authenticated_frontpage configuration`. A menu link
(`authenticated_frontpage.settings`) sits under System (`system.admin_config_system`).

All settings live in the config object **`authenticated_frontpage.settings`**, under a nested
`authenticated_frontpage.` key. There is no config schema and no `config/install` default, so the
object does not exist until the form is saved.

## Config keys

| Key (under `authenticated_frontpage.`) | Form element | Type | Meaning |
|---|---|---|---|
| `field_is_path` | `field_is_path` checkbox | bool | If TRUE, target the page by internal **path**; if FALSE, by **node id**. |
| `field_loggedin_frontpage` | `field_loggedin_frontpage` entity_autocomplete (node) | node id (int) | Target node id. Used when `field_is_path` is FALSE. Shown only when the path checkbox is unchecked. |
| `field_loggedin_frontpage_path` | `field_loggedin_frontpage_path` textfield | string | Target internal path, e.g. `/user/me` or `/node/1` (must include any active language prefix). Used when `field_is_path` is TRUE. Shown only when the path checkbox is checked. |
| `field_roles` | `field_roles` checkboxes | map `role_id => role_id\|0` | Roles the override applies to. Empty / none checked = **all authenticated users**. The `anonymous` role is excluded from the options. |
| `field_redirect_anonymous` | `field_redirect_anonymous` checkbox | bool | If TRUE, anonymous users who request the authenticated front page are redirected to the site's default front page. |

Validation (`SettingsForm::validateForm`): when path mode is on, the path is required and must pass
`path.validator` `isValid()` (a valid internal path). Node mode has no extra validation beyond the
autocomplete.

## What happens at runtime

Service `authenticated_frontpage.event_subscriber` subscribes to `KernelEvents::REQUEST`
(`AuthenticatedFrontpageSubscriber::onKernelRequest`). On every front-controller request it:

1. Returns early for CLI/drush, during installation, when `system.maintenance_mode` state is set,
   or for non-`index.php` requests (e.g. cron).
2. Resolves `$loggedinFrontpage` = the path or the node id depending on `field_is_path`.
3. **Anonymous redirect:** if the user is anonymous, `field_redirect_anonymous` is on, and the
   current page equals the authenticated front page, it redirects to `system.site` `page.front`
   (the default front page), preserving the incoming query string. Then stops.
4. Returns for anonymous users, and for authenticated users whose roles do not intersect the
   configured `field_roles` (when any roles are configured).
5. **Authenticated redirect:** if `path.matcher` `isFrontPage()` is true (the request is the site
   front page `/`) and a target is configured, it builds a `Url` — `Url::fromUserInput($path)` in
   path mode, or `Url('entity.node.canonical', ['node' => $nid])` in node mode — carrying the
   incoming query args, and issues a `Symfony\...\RedirectResponse` (302) to it.
6. When the request path already **is** the authenticated front page, it sets the request attribute
   `is_authenticated_front = TRUE`.

The hook `authenticated_frontpage_preprocess_page()` reads that attribute and sets
`$variables['is_front'] = TRUE`, so the theme treats the target page as the front page
(e.g. `is-front` body class, front-page templates). Access to the target node/path is enforced
normally by Drupal on the redirected request — the module only redirects, it does not render the
target in place or bypass its access checks.

Note: this is a redirect, so the browser URL changes to the target node/path — it is not served at
`/`. For per-role *different* front pages (rather than one shared authenticated front page), the
project README points to the `front` module.

## Set it without the UI

Drush:

```sh
# Path mode: send authenticated users to /dashboard
drush cset authenticated_frontpage.settings authenticated_frontpage.field_is_path 1 -y
drush cset authenticated_frontpage.settings authenticated_frontpage.field_loggedin_frontpage_path /dashboard -y

# Node mode: send authenticated users to node 5
drush cset authenticated_frontpage.settings authenticated_frontpage.field_is_path 0 -y
drush cset authenticated_frontpage.settings authenticated_frontpage.field_loggedin_frontpage 5 -y

# Redirect anonymous away from the authenticated front page
drush cset authenticated_frontpage.settings authenticated_frontpage.field_redirect_anonymous 1 -y
```

PHP:

```php
\Drupal::configFactory()
  ->getEditable('authenticated_frontpage.settings')
  ->set('authenticated_frontpage.field_is_path', TRUE)
  ->set('authenticated_frontpage.field_loggedin_frontpage_path', '/dashboard')
  ->set('authenticated_frontpage.field_roles', ['editor' => 'editor'])
  ->set('authenticated_frontpage.field_redirect_anonymous', FALSE)
  ->save();
```

`field_roles` stores the raw checkboxes value (`['role' => 'role']` for checked, `['role' => 0]`
for unchecked); the subscriber filters out the `0` entries before matching.
