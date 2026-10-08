<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AntiBot Redirect (antibot_redirect) — agent index

Session-based bot gate: a kernel REQUEST subscriber redirects visitors to a `/verify-human`
reCAPTCHA page before serving admin-configured protected paths, unless the request already carries
a same-site `Referer` or the session is already verified.

- **Version dir:** 1.0.x (installed 1.0.0). **Core:** `^10 || ^11`. **License:** GPL-2.0-or-later.
- **Dependency:** `recaptcha` (reCAPTCHA contrib module — supplies the CAPTCHA element/keys).
- **Provides:** no permissions, no config schema, no plugins, no drush, no `.module`/`.install`.
  Reuses core permissions `access content` (verify page) and `administer site configuration` (settings).

## What it ships

- **Event subscriber** `Drupal\antibot_redirect\EventSubscriber\BotBlockSubscriber`
  (service `antibot_redirect.kernel_request_subscriber`, on `KernelEvents::REQUEST` priority `-10`) —
  the interception + redirect logic.
- **Verify form** `Drupal\antibot_redirect\Form\AntibotCheckForm` — route `antibot_redirect.form`
  at `/verify-human` (`_permission: access content`). Renders description + reCAPTCHA; sets the
  session `verified_human` flag on submit.
- **Settings form** `Drupal\antibot_redirect\Form\AntibotSettingsForm` — route
  `antibot_redirect.settings` at `/admin/config/system/antibot-redirect`
  (`_permission: administer site configuration`), also the `configure` link and an admin menu link.
- **Config object** `antibot_redirect.settings` (no shipped default / schema): keys
  `verify_page_title`, `verify_page_description` (value+format), `protected_paths`.

## Solution docs

- [Request-interception flow & the verify page](flow/interception.md) — how requests are gated,
  the `/verify-human` round-trip, the session flag, path exclusions, and operational caveats.
- [Settings & configuration](config/settings.md) — the settings form, the `antibot_redirect.settings`
  keys, protected-path syntax (wildcards), and how to configure the module end to end.
