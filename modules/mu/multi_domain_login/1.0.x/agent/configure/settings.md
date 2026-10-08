<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — settings page and `multi_domain_login.settings`

One settings form, one config object. There is no per-entity or per-user configuration.

- **Route:** `multi_domain_login.admin_settings` → `/admin/config/multi_domain_login`
- **Permission:** `administer site configuration`
- **Form:** `Drupal\multi_domain_login\Form\MultiDomainLoginForm` (a `ConfigFormBase`, form id `multi_domain_login`)
- **Menu link:** `multi_domain_login.admin_settings` under *system.admin_config_system*
- **Config object:** `multi_domain_login.settings` (schema `multi_domain_login.schema.yml`)

> Note: info.yml declares **no** `configure:` key, but the settings form/route above is the real and only configuration entry point.

## Fields and config keys

| Form field | Config key | Type / default | Effect |
|---|---|---|---|
| Domains | `domains` | textarea → sequence of strings; default empty `{}` | The domains that participate in the shared login, **one per line, including the scheme** (e.g. `https://www.mydomain.com`). On save the textarea is trimmed, CRLF normalized to LF, and `explode("\n")` into an array. Order matters — the redirect chain visits them in list order and wraps back to the first. |
| Timeout | `timeout` | textfield (int); default 30 | Seconds a generated cross-domain login URL stays valid. `doLogin()` rejects a hop when `request_time - timestamp > timeout` (logs `Login attempt expired`). Keep it small; the redirect chain completes in seconds. |
| Redirect on success | `redirect_success` | textfield (string); default `''` | User-input path the chain redirects to once it wraps back to the origin domain. Empty → `<front>`. Built with `Url::fromUserInput()` and made absolute on the origin domain, language-aware. |
| Redirect on error | `redirect_error` | textfield (string); default `''` | **Stored but not consumed** by the controller in this release — collected by the form and present in schema, but no code reads it. Setting it has no runtime effect. |
| Force logout | `force_logout` | checkbox (bool); default 1 (on) | Governs a target domain where a **different** user is already authenticated. On: `user_logout()` then finalize the requested user (switch accounts). Off: leave the existing session and skip (logs `already logged in`, status 200). |
| Enable extra logging | `enable_extra_logging` | checkbox (bool); default unset | Emits `debug`-level watchdog entries for each per-domain logout / login-finalize step. **Not present in the config schema** (`multi_domain_login.schema.yml` lists only the five keys above), so it is an untyped extra key — read by the controller via `config->get('enable_extra_logging')`. |

## Prerequisites for it to work

- Every domain in the list must serve the **same** Drupal codebase and database — same `hash_salt` (in `settings.php`) and same `users` table. The HMAC login URLs only validate when both sides derive the identical hash.
- Each domain host is identified internally by `crc32(scheme+host)`; the incoming request is matched to a configured domain with `str_starts_with($request->getUri(), $domain)`, falling back to the request's own scheme+host if none matches.
- The redirect targets are `TrustedRedirectResponse`s to the admin-configured domains only; no user-supplied host reaches the redirect.

## Drush

```
ddev drush cset multi_domain_login.settings timeout 60 -y
ddev drush cset multi_domain_login.settings force_logout 0 -y
# domains is a sequence; edit via the form, or:
ddev drush cset multi_domain_login.settings domains.0 'https://www.english.com' -y
ddev drush cset multi_domain_login.settings domains.1 'https://www.nederlands.nl' -y
ddev drush cget multi_domain_login.settings
```

`hook_update_9000` (`multi_domain_login.install`) attempts to clear a legacy `message` key, but targets the mistyped config name `multi_domain_login.settigns`, so it is effectively a no-op.
