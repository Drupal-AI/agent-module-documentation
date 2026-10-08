<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — disable_login_by_domain

**Route:** `/admin/config/people/disable-login-by-domain`
(route `disable_login_by_domain.settings`, menu link under *Configuration › People*).
**Permission:** `administer site configuration`.
**Config object:** `disable_login_by_domain.settings` (has config schema).

## Settings

| Key | Type | Default | Meaning |
| --- | --- | --- | --- |
| `domains` | sequence of strings | `[]` | Disallowed hostnames. Login is prevented whenever the site is served on one of these hosts. The literal `*` as a list entry disallows **all** domains. |
| `hijack_login_action` | boolean | `true` | When on, invalidates the session of any user who reaches `user_login_finalize()` on a disallowed host (`hook_user_login`), logging them back out. |

Form field mapping (`Form\SettingsForm`):

- **Disallowed domains** — a textarea; one domain per line. On submit the value is `explode("\n")`
  and each line `trim()`-med, then stored as the `domains` sequence. Use `*` to disallow all domains.
- **Hijack login attempts** — a checkbox bound to `hijack_login_action`.

## Matching semantics (important)

- The compared value is `Request::getHost()` — the current request's `Host` (or `X-Forwarded-Host`)
  header, **not** the user's email/account domain. `getHost()` returns the host lowercased and
  **without** the port.
- Comparison is **exact** (`in_array($current_domain, $domains)`). `www.example.com` matches only
  `www.example.com`; it does not match `example.com`, `sub.www.example.com`, or `www.example.com:8080`
  as a value. List every hostname you need to cover explicitly, or use `*`.
- Because the request host is lowercased, enter domains in **lowercase** — an uppercase entry such as
  `Example.com` will never match and silently fails to block.

## Example

```yaml
# config/install or via the form
domains:
  - www.example.com
  - example.com
hijack_login_action: true
```

Blocks login on `www.example.com` and `example.com`; leaves it working on, e.g.,
`manage.example.com`.

## Operational notes

- The matched host comes from an HTTP request header. Configure Drupal's **Trusted Host Settings**
  (`trusted_host_patterns` in `settings.php`) so the accepted set of `Host` values is constrained.
- Turn **Hijack login attempts** *off* if users authenticate outside Drupal's login form (e.g. SSO),
  since it will otherwise invalidate their sessions too.
- The Layout Builder cache dependency for the disabled login block is noted as unreliable in the
  source (`@todo`); flush caches after changing these settings if a Layout-Builder-placed login block
  does not update.
