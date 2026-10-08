<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Coming Soon Mode (comingsoon_mode) — agent index

Puts a site into a temporary **"coming soon" / pre-launch mode**: while enabled, a request
event-subscriber issues a **302 redirect to a configurable `/coming-soon` landing page** for any
visitor who is anonymous or lacks the bypass permission. The landing page shows a title, a message,
an optional JS countdown timer, logo, background colour/image, and social/contact links. No
dependencies outside Drupal core. Package `maintenance`. Core `^9 || ^10 || ^11`. License
GPL-2.0-or-later. Installed **1.4.0-alpha2** (version dir `1.4.x`).

## What it provides (from source)

- **Gate — `RedirectComingSoonSubscriber`** (`src/EventSubscriber/`, service
  `comingsoon_mode.redirect_to_comingsoon`, tag `event_subscriber`). Subscribes to
  `KernelEvents::REQUEST` at **priority -1** (after routing, so `_route` is set). When config
  `comingsoon_ckeck == 1` and the current user `isAnonymous()` **or** lacks
  `access website in comingsoon mode`, it redirects to route `comingsoon.page`, carrying the
  original query string; skips the redirect on `comingsoon.page` itself to avoid a loop. The
  redirect fires on **every** route not on the allow-list (nodes, admin, REST/JSON:API included) —
  the target controller never runs.
  - **Allow-list (always reachable):** routes `system.css`, `system.js`, `user.login`, `user.pass`,
    `user.reset.form`, `user.reset.login`, `user.logout`, plus `user.register` when config
    `allow_register` is on; and any path matching
    `#^/(favicon.ico$|libraries/|modules/|sites/[^/]+/files/|themes/)#i` (public static assets).
- **Landing page controller — `ComingsoonController::build()`** (route `comingsoon.page`, path
  `/coming-soon`, `_permission: 'access content'`). Returns the `comingsoon` themed render array.
  If coming-soon mode is **off** and the user is anonymous, it 302-redirects to `/` instead.
- **Settings form — `SettingsForm`** (route `comingsoon_mode.settings_form`, path
  `/admin/config/system/comingsoon_mode`, `_permission: 'administer comingsoon mode configuration'`).
  Single config form (`comingsoon_mode.settings`) for the toggle, display flags, content, style, and
  social fields. Toggling `comingsoon_ckeck` triggers `drupal_flush_all_caches()`.
- **Permissions** (`.permissions.yml`, both `restrict access: true`):
  `administer comingsoon mode configuration` (config the module) and
  `access website in comingsoon mode` (bypass the gate / see the real site).
- **Theme + template** — `hook_theme()` registers `comingsoon`;
  `hook_theme_suggestions_page_alter()` adds a `comingsoon` page suggestion on `comingsoon.page`;
  `template_preprocess_comingsoon()` builds the `data` array (config values + active-theme logo +
  background-image file URL) and attaches library `comingsoon_mode/countdown`
  (`assets/js/comingsoon_mode.js`, jQuery countdown). Template `templates/comingsoon.html.twig` is
  overridable by copying it into a theme.
- **Login guard** — `hook_form_user_login_form_alter()` adds a validate handler: while
  `comingsoon_ckeck` is on, a login attempt is rejected unless the account holds
  `access website in comingsoon mode`.
- **Config schema** (`config/schema/comingsoon_mode.schema.yml`), config-translation
  (`.config_translation.yml`), admin menu link + local task, and an `ar.po` translation.
  No install/update hooks; no Drush; no submodules; no composer.json.

## Solution docs

- **Settings form fields, config keys, the gate/allow-list, template override** →
  [config/settings.md](config/settings.md)

## Notes for callers

- The gate is a **request-time redirect that covers all non-allow-listed routes**, so an enabled,
  cache-cleared site does not serve node/API content to anonymous visitors. It is nonetheless a
  convenience pre-launch gate, not a substitute for real access control on genuinely sensitive
  material (it relies on a redirect + cache invalidation, deliberately passes public files and the
  auth routes, and this release is *not covered* by Drupal's security-advisory policy). Grant
  `access website in comingsoon mode` to the roles that must keep working **before** enabling the
  mode, or you lock yourself out.
