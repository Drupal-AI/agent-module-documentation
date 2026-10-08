<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config keys, gate & template

## Enable

`drush en comingsoon_mode` — no dependencies beyond core, nothing outside Drupal core to install.
Enabling does **not** gate the site; the mode starts off (`comingsoon_ckeck: 0`). Configure at
`/admin/config/system/comingsoon_mode` (permission `administer comingsoon mode configuration`).

## Config object `comingsoon_mode.settings`

Written by `SettingsForm::submitForm()` (all values except `op`/`form_build_id`/`form_token`/
`form_id`/`submit`; `countdown_time` is stored as a Unix timestamp). Defaults from
`config/install/comingsoon_mode.settings.yml`.

| key | type | form control | meaning |
|-----|------|-------------|---------|
| `comingsoon_ckeck` | int 0/1 | checkbox "Put site into coming soon mode" | **master switch**; changing it runs `drupal_flush_all_caches()` |
| `display_logo` | 0/1 | checkbox | show the active theme's logo on the landing page |
| `display_login` | 0/1 | checkbox | show a "Log in" link on the landing page |
| `allow_register` | 0/1 | checkbox | show a "Register" link **and** add `user.register` to the gate allow-list |
| `display_counter` | 0/1 | checkbox | show the JS countdown timer |
| `background_image_ckeck` | 0/1 | checkbox | use the uploaded image as a background image |
| `display_social_media_links` | 0/1 | checkbox | show the social/contact row |
| `title` | text | textfield | landing-page headline |
| `message` | text_format | text_format (`restricted_html`) | body text; rendered then `striptags`-ed in the template |
| `countdown_time` | timestamp | datetime | launch date; formatted `Y/m/d` and fed to the JS countdown |
| `background_image` | managed_file id | managed_file (`public://settings_images/`, ext `svg jpg jpeg png`) | made permanent on save via `mkPermanent()` |
| `background_color` | string | textfield | validated `/^#[a-f0-9]{6}$/i` (e.g. `#ffffff`) |
| `twitter`/`facebook`/`instagram`/`linkedin` | string | textfield | social links (shown when set) |
| `email` | string | textfield | rendered as `mailto:` |
| `phone` | string | textfield | rendered as `tel:` |

The form's **Permissions** section is just a markup link to
`/admin/people/permissions/module/comingsoon_mode`; the form defines no role selector — access is
governed entirely by the two permissions below.

## Access model

Two permissions (`.permissions.yml`, both `restrict access: true`):

- **`administer comingsoon mode configuration`** — reach the settings form.
- **`access website in comingsoon mode`** — bypass the gate and browse the real site while the mode
  is on. Grant this to the roles that must keep working **before** you flip the switch.

The gate itself (`RedirectComingSoonSubscriber`, `KernelEvents::REQUEST` priority -1): when
`comingsoon_ckeck == 1`, a visitor who `isAnonymous()` **or** lacks
`access website in comingsoon mode` is 302-redirected to `/coming-soon` for every route that is not
allow-listed. Allow-listed = the auth routes `system.css`, `system.js`, `user.login`, `user.pass`,
`user.reset.form`, `user.reset.login`, `user.logout` (plus `user.register` when `allow_register` is
on), and any path matching `#^/(favicon.ico$|libraries/|modules/|sites/[^/]+/files/|themes/)#i`
(public static files). The redirect preserves the original query string and never loops on
`comingsoon.page`. Because it is a request-time redirect that runs before the target controller, an
enabled + cache-cleared site does not render node/admin/API responses to gated visitors.

The landing controller `ComingsoonController::build()` additionally redirects anonymous visitors to
`/` if it is ever reached while the mode is **off**.

**Login guard:** while the mode is on, `comingsoon_mode_login_form_validate()` blocks any login by an
account that lacks `access website in comingsoon mode` (error: "You are not allowed to access the
site in Coming Soon Mode.").

## Landing page rendering & template override

`template_preprocess_comingsoon()` assembles `$variables['data']` from the config (display flags,
title, `message` as a `processed_text` render array, `countDownDate` as `Y/m/d`, the active theme
logo via `file_url_generator`, the background image's external URL, and the social/contact values)
and attaches `comingsoon_mode/countdown`. In `templates/comingsoon.html.twig` the message is output
as `{{ data.message|render|striptags }}` (all tags stripped) and `title` via `{{ data.title }}`
(Twig autoescaped). To restyle, copy `comingsoon.html.twig` into your theme's `templates/` folder —
the same `data.*` variables are available (documented in the template's docblock).
