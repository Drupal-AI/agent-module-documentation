<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `facebook_pixel.settings`

Shipped defaults (`config/install/facebook_pixel.settings.yml`):

```yaml
facebook_id: ''
visibility:
  request_path_mode: all_pages
  request_path_pages: "/admin\n/admin/*\n/batch\n/node/add*\n/node/*/*\n/user/*/*\n/user/login"
  user_role_mode: all_roles
  user_role_roles: {  }
privacy:
  donottrack: true
  fb_disable_advanced: false
  eu_cookie_compliance: false
  disable_noscript_img: false
```

## Key reference

| Key | Type | Values | Effect |
|---|---|---|---|
| `facebook_id` | string | pixel id | empty ⇒ nothing is tracked at all (no JS, no `<noscript>`) |
| `visibility.request_path_mode` | string | `all_pages` \| `listed_pages` | `all_pages` = track everywhere **except** the list; `listed_pages` = track **only** the list |
| `visibility.request_path_pages` | string | newline-separated paths, each must start with `/` or be `<front>`; `*` wildcard | matched against the internal path and its alias, lowercased, via `path.matcher` |
| `visibility.user_role_mode` | string | `all_roles` \| `listed_roles` | `all_roles` = track every role **except** the selected ones; `listed_roles` = only the selected ones |
| `visibility.user_role_roles` | sequence | role machine names | empty ⇒ everyone is tracked |
| `privacy.donottrack` | bool | | JS skips tracking when the browser sends Do-Not-Track |
| `privacy.fb_disable_advanced` | bool | | JS honours `window['fb-disable']` and exposes a global `fbOptout()` that sets an opt-out cookie |
| `privacy.eu_cookie_compliance` | bool | | JS waits for `Drupal.eu_cookie_compliance.hasAgreed()`; the checkbox is disabled unless the `eu_cookie_compliance` module is installed. That module's *Script scope* must be **Header** |
| `privacy.disable_noscript_img` | bool | | suppresses the `<noscript>` tracking image in `hook_page_top()` |

The three `privacy` booleans are passed to the browser in
`drupalSettings.facebook_pixel` — they are **client-side** switches, not server-side gates.

## Tracking decision (`facebook_pixel.module`)

```
_facebook_pixel_request_should_be_tracked()
  = facebook_id is not empty
  AND _facebook_pixel_visibility_pages()
  AND _facebook_pixel_visibility_roles(currentUser)
```

* Pages: `path_should_be_tracked = (request_path_mode == 'all_pages') XOR page_match`.
  When `request_path_pages` is empty, everything is tracked.
* Roles: `role_should_be_tracked = (user has one of the listed roles) XOR (user_role_mode == 'all_roles')`.

The result is cached in a `drupal_static()` per request.

`hook_page_top()` is independent: it emits
`<noscript><img src="https://www.facebook.com/tr?id=<id>&ev=PageView&noscript=1" …></noscript>`
whenever `facebook_id` is non-empty and `privacy.disable_noscript_img` is FALSE — regardless
of path, role or DNT.

## Read / write with Drush

```bash
drush cget facebook_pixel.settings
drush cget facebook_pixel.settings facebook_id
```

```bash
drush cset facebook_pixel.settings facebook_id 123456789012345 -y

# track only two landing pages, only for the authenticated role
drush php:eval '
  \Drupal::configFactory()->getEditable("facebook_pixel.settings")
    ->set("visibility.request_path_mode", "listed_pages")
    ->set("visibility.request_path_pages", "/campaign\n/campaign/*")
    ->set("visibility.user_role_mode", "listed_roles")
    ->set("visibility.user_role_roles", ["authenticated" => "authenticated"])
    ->save();
'
drush cr
```

Restore the shipped defaults:

```bash
drush php:eval '
  \Drupal::configFactory()->getEditable("facebook_pixel.settings")
    ->set("facebook_id", "")
    ->set("visibility.request_path_mode", "all_pages")
    ->set("visibility.request_path_pages", "/admin\n/admin/*\n/batch\n/node/add*\n/node/*/*\n/user/*/*\n/user/login")
    ->set("visibility.user_role_mode", "all_roles")
    ->set("visibility.user_role_roles", [])
    ->set("privacy.donottrack", TRUE)
    ->set("privacy.fb_disable_advanced", FALSE)
    ->set("privacy.eu_cookie_compliance", FALSE)
    ->set("privacy.disable_noscript_img", FALSE)
    ->save();
'
```

## The settings form

`/admin/config/facebook_pixel` — route
`facebook_pixel.facebook_pixel_config_form`, form
`Drupal\facebook_pixel\Form\FacebookPixelConfigForm`, permission `configure facebook_pixel`,
`_admin_route: TRUE`, menu link under *Configuration → Web services*.

| Form element | Config key |
|---|---|
| `facebook_id` textfield (maxlength 64) | `facebook_id` |
| *Pages* tab: `facebook_pixel_visibility_request_path_mode` radios | `visibility.request_path_mode` |
| *Pages* tab: `facebook_pixel_visibility_request_path_pages` textarea | `visibility.request_path_pages` |
| *Roles* tab: `facebook_pixel_visibility_user_role_mode` radios | `visibility.user_role_mode` |
| *Roles* tab: `facebook_pixel_visibility_user_role_roles` checkboxes | `visibility.user_role_roles` |
| *Privacy* tab: 4 checkboxes | `privacy.*` |

`validateForm()` trims the page list, filters unchecked roles and rejects any path that does
not start with `/` (except `<front>`).

Note: the form attaches a library `facebook_pixel/facebook_pixel.admin` that is **not**
declared in `facebook_pixel.libraries.yml`, so Drupal logs a missing-library notice on that
page. Harmless.

## Migration from Drupal 7

`migrations/d7_facebook_pixel_settings.yml` maps the D7 variable `facebook_pixel_id` to
`facebook_id` in `facebook_pixel.settings`. Nothing else is migrated.
`facebook_pixel_update_8101()` moves an older `facebook_pixel.facebookpixelconfig` object to
`facebook_pixel.settings` and seeds the new `visibility`/`privacy` groups from the install
config.
