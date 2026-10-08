<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Seeds Security & Performance (seeds_security) — agent index

Dependency-only **aggregator/metapackage** for the Seeds distribution that enables a curated set
of security contrib modules and ships starter config for some of them. Package **Seeds**. Core
`^10 || ^11`. License GPL-2.0-or-later. Version dir **2.x** (installed **2.0.2**).

No controllers, forms, routes, services, permissions, entities, plugin types, or Drush commands of
its own. Just: `.info.yml` dependencies + `composer.json` requires, one page-attachments hook, and
`config/optional/*` starter config.

- **Dependencies, the one hook, and the bundled config (and why most of it is inert)** →
  [config/bundle.md](config/bundle.md)

## What it actually is (from source)

- `seeds_security.info.yml` hard dependencies: `username_enumeration_prevention`, `captcha`,
  `recaptcha`, `activities`, `password_policy`, `remove_http_headers`, `seckit`, `session_limit`,
  `restrict_ip`, `email_tfa`.
- `composer.json` `require` additionally lists `drupal/login_security` and
  `drupal/webform_spam_words` (installed by Composer but **not** enabled by the `.info.yml`).
- `seeds_security.module` → `seeds_security_page_attachments_alter()`: loops
  `$attachments['#attached']['html_head']` and `unset()`s the entry whose key is
  `system_meta_generator` — removes the core `<meta name="generator" content="Drupal …">` tag.
- `config/optional/`: `seckit.settings.yml`, `login_security.settings.yml`,
  `session_limit.settings.yml`, `remove_http_headers.settings.yml`,
  `password_policy.password_policy.default_password_policy.yml`. No `config/schema/`.
- No `.install`, no `src/`, no `*.routing.yml`, no `*.permissions.yml`, no `*.services.yml`.

## Operating notes

- `config/optional` config is created only when config of that name does not already exist. The
  bundled `seckit`/`login_security`/`session_limit`/`remove_http_headers` settings collide with
  each dependency module's own `config/install` defaults, so in practice the **dependency's own
  defaults win** and the Seeds copies are skipped. The `default_password_policy` entity (which no
  dependency ships) is the config that actually gets created.
- After install, review/tune each bundled module; do not assume the bundle configured it. See the
  solution doc for exact deployed values.
