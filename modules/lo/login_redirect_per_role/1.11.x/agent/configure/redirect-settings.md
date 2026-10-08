<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure login/logout redirects

## Route & permission

- Configure route: `login_redirect_per_role.redirect_url_admin_settings`
- Path: `/admin/people/login-and-logout-redirect-per-role`
- Permission: **`administer site configuration`** (core; the module defines none of its own)
- Menu: appears under *Configuration → System* (`system.admin_config_system`).

## Where the settings are stored

Single config object **`login_redirect_per_role.settings`** with two parallel tables:

```yaml
login:                       # applied on hook_user_login
  <role_id>:
    redirect_url: '/admin/content'   # '' = no redirect for this role
    allow_destination: false         # true = respect an existing ?destination=
    weight: 0                        # lower = higher priority
logout:                      # applied on hook_user_logout
  <role_id>:
    redirect_url: '<front>'
    allow_destination: false
    weight: 0
```

Schema (`config/schema`): `login` and `logout` are each a **sequence** of
`login_redirect_per_role.item` = `{ redirect_url: string, allow_destination: boolean,
weight: integer }`, keyed by role machine name. The **anonymous** role is excluded from the
form. There is **no `config/install` default**, so on a fresh install the object does not
exist (`drush cget` errors) — that means "no redirects configured".

## Redirect URL formats (validated by the form)

A non-empty Redirect URL must be one of:
- `<front>` — the site front page (built with `Url::fromRoute('<front>')`);
- an internal path/user input beginning with `/`, `?`, or `#` (e.g. `/admin/content`, `?tab=x`, `#top`);
- a **token** beginning with `[` (e.g. `/user/[current-user:uid]/edit`) — requires the Token module.

External URLs are rejected. The form resolves path aliases to system paths and validates access.

## Via the UI

1. Go to *Configuration → System → Login and Logout Redirect per role*.
2. In **Login redirect**, fill a role's **Redirect URL** (leave empty to skip that role).
3. Optionally tick **Allow destination** to let an existing `?destination=` win over this URL.
4. Drag rows to set **Weight** — higher in the list = higher priority.
5. Repeat for **Logout redirect**. Save.

## Via drush (scriptable)

```bash
# Read current config (errors if never configured):
drush cget login_redirect_per_role.settings

# Set a login redirect for the content_editor role:
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("login_redirect_per_role.settings");
  $login = $c->get("login") ?? [];
  $login["content_editor"] = ["redirect_url" => "/admin/content", "allow_destination" => FALSE, "weight" => 0];
  $c->set("login", $login)->save();
'

# Set a logout redirect to the front page for authenticated users:
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("login_redirect_per_role.settings");
  $logout = $c->get("logout") ?? [];
  $logout["authenticated"] = ["redirect_url" => "<front>", "allow_destination" => FALSE, "weight" => 0];
  $c->set("logout", $logout)->save();
'
```

To remove all configuration (restore default Drupal behavior):
`drush php:eval '\Drupal::configFactory()->getEditable("login_redirect_per_role.settings")->delete();'`
