<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# seeds_security — the bundle, the hook, and the starter config

`seeds_security` is a metapackage. This doc records exactly what it enables, the single hook it
runs, and the `config/optional` it ships — including the config-precedence caveat that determines
what is actually in effect after install.

## Install / enable

- `composer require drupal/seeds_security` then `drush en seeds_security -y` (or via the UI).
  Enabling it enables all `.info.yml` dependencies too.
- `.info.yml` hard dependencies (all auto-enabled): `username_enumeration_prevention`, `captcha`,
  `recaptcha`, `activities`, `password_policy`, `remove_http_headers`, `seckit`, `session_limit`,
  `restrict_ip`, `email_tfa`.
- `composer.json` `require` also brings `drupal/login_security` and `drupal/webform_spam_words`
  into the codebase, but they are **not** in `.info.yml`, so enabling `seeds_security` does not
  enable them — enable them yourself if wanted.
- No configure route (`configure:` unset); configuration is done in each dependency module's own
  settings pages. No permissions, services, routes, entities, plugin types, or Drush commands.

## The only code: `seeds_security.module`

`seeds_security_page_attachments_alter(array &$attachments)` iterates
`$attachments['#attached']['html_head']` and, for the entry whose second element equals
`system_meta_generator`, calls `unset()` on it. Effect: the core
`<meta name="generator" content="Drupal 11 (https://www.drupal.org)">` tag is removed from every
page `<head>` (a small version-disclosure reduction). It only removes the HTML `<meta>` tag; the
`X-Generator` HTTP header is handled separately by the `remove_http_headers` dependency.

## Bundled `config/optional` and the precedence caveat

All five files live under `config/optional/`. Drupal creates optional config only if config of that
name does **not already exist** and its dependencies are met. Four of the five duplicate config
names that the corresponding dependency module already ships in its own `config/install`:

| Seeds file | Also shipped by | Net effect on install |
|---|---|---|
| `seckit.settings.yml` | seckit `config/install` | Seeds copy **skipped**; SecKit's own defaults apply |
| `login_security.settings.yml` | login_security `config/install` | Seeds copy **skipped** (and login_security isn't even enabled by `.info.yml`) |
| `session_limit.settings.yml` | session_limit `config/install` | Seeds copy **skipped**; session_limit defaults apply |
| `remove_http_headers.settings.yml` | remove_http_headers `config/install` | Seeds copy **skipped**; module defaults apply |
| `password_policy.password_policy.default_password_policy.yml` | — (no dependency ships it) | **Created** — a new policy entity |

So the practically effective Seeds-provided config is the **Default Password Policy** entity plus
the generator-meta removal hook; the header/login/session settings that end up active are each
module's own defaults unless you edit them.

### What the Seeds copies contain (for reference)

- `seckit.settings.yml`: X-Frame-Options SAMEORIGIN (`seckit_clickjacking.x_frame: "1"`); CSP
  disabled (`seckit_xss.csp.checkbox: false`); X-XSS-Protection Disabled (`x_xss.select: 0`);
  HSTS disabled; Expect-CT disabled; Referrer-Policy disabled; Feature-Policy disabled;
  CSRF origin check disabled. (Mirrors SecKit's own permissive defaults.)
- `login_security.settings.yml`: `track_time: 60`; all attempt thresholds
  (`user_wrong_count`, `host_wrong_count`, `host_wrong_count_hard`, `activity_threshold`) `0`;
  `disable_core_login_error: 0`.
- `session_limit.settings.yml`: `session_limit_max: 1`; `session_limit_behaviour: 0` (ask which
  session to end); `session_limit_admin_inclusion: 1`; roles all `0`.
- `remove_http_headers.settings.yml`: removes `X-Generator`, `X-Drupal-Dynamic-Cache`,
  `X-Drupal-Cache`; declares an enforced dependency on `remove_http_headers`.
- `password_policy.password_policy.default_password_policy.yml`: id `default_password_policy`,
  `password_reset: 30` (days), constraints — 2 character types, ≥1 special char, max 2 consecutive
  chars, min length 6, disallow-username. `roles:` map has `authenticated`, `editor`, `admin` all
  set to `"0"`, i.e. the policy is created but **not applied to any role** until you enable it on
  the roles you want under Configuration → People → Password Policies.

## Operating checklist

1. After enabling, visit each dependency's settings page and configure it (SecKit CSP/HSTS,
   Login Security thresholds, reCAPTCHA keys, Restrict IP allowlist, Email TFA, etc.).
2. Assign the Default Password Policy to the relevant roles (it ships bound to none).
3. If you want brute-force login lockout, enable and configure `login_security` (it is available
   in the codebase but not enabled by this module).
