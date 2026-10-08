<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure HTTPS and WWW Redirect

Single config object, single settings form. `configure: httpswww.settings` (route name), path
`/admin/config/system/httpswww`, gated by the `administer httpswww` permission.

## Config object: `httpswww.settings`

| Key | Type | Values | Meaning |
|---|---|---|---|
| `enabled` | bool | `true` / `false` | Master on/off switch for the whole redirect subscriber. Missing/false = no redirects at all, regardless of `prefix`/`scheme`. |
| `prefix` | string | `mixed` (default), `no`, `yes` | `mixed` = no www redirect (both `example.com` and `www.example.com` work); `no` = remove the `www.` prefix (redirect `www.example.com` → `example.com`); `yes` = add the `www.` prefix (redirect `example.com` → `www.example.com`). |
| `scheme` | string | `mixed` (default), `https` | `mixed` = no scheme redirect (HTTP and HTTPS both work); `https` = force HTTPS (redirect any `http://` request to `https://`). |
| `exclude_subdomains` | array of strings | e.g. `['api', 'shop']` | Only consulted when `prefix: yes`. Subdomains in this list are NOT given the `www.` prefix even though the rest of the site is. Ignored when `prefix` is `mixed` or `no`. |

**No config schema, no default config.** The module ships neither `config/schema/*` nor
`config/install/httpswww.settings.yml`, so a freshly enabled site has `httpswww.settings` with
no stored values at all — every key reads as `NULL` until something sets it. The subscriber
treats an empty/missing `enabled` as "do nothing" and empty `prefix`/`scheme` as `mixed`
(the form's own `#default_value` fallbacks use the same `?: 'mixed'` pattern). To restore this
shipped baseline, delete the config object entirely rather than trying to reset individual keys:

```bash
drush config:delete httpswww.settings
```

## How to force HTTPS

Set `scheme` to `https` (and `enabled` to `true`):

```bash
drush php:eval '\Drupal::configFactory()->getEditable("httpswww.settings")
  ->set("enabled", TRUE)->set("scheme", "https")->save();'
```

## How to add or remove the `www.` prefix

- Add `www.` to every host (except excluded subdomains): set `prefix` to `yes`.
- Remove `www.` from every host: set `prefix` to `no`.
- Leave hosts alone: set `prefix` to `mixed` (or delete the config).

```bash
# Add www, excluding the api and shop subdomains:
drush php:eval '\Drupal::configFactory()->getEditable("httpswww.settings")
  ->set("enabled", TRUE)->set("prefix", "yes")
  ->set("exclude_subdomains", ["api", "shop"])->save();'

# Remove www instead:
drush php:eval '\Drupal::configFactory()->getEditable("httpswww.settings")
  ->set("enabled", TRUE)->set("prefix", "no")->save();'
```

## Via the UI

1. Go to `/admin/config/system/httpswww` (Configuration > System > HTTPS and WWW Redirect
   settings). Requires `administer httpswww`.
2. Tick **Enable redirects**.
3. Under **Domain WWW prefix**, choose *No redirect* / *Remove WWW prefix* / *Add WWW prefix*,
   and (only shown when "Add WWW prefix" is selected) fill in a comma-separated **Exclude
   Subdomains** list.
4. Under **HTTP Secure (HTTPS) redirect**, choose *No redirect* or *Redirect to HTTPS*.
5. Save configuration.

Caution baked into the form itself: if you lack the `bypass httpswww redirect` permission and
are currently on a host/scheme different from what you are about to select, saving can log you
out or redirect you away immediately.

## Reading config back

```bash
drush config:get httpswww.settings enabled
drush config:get httpswww.settings prefix
drush config:get httpswww.settings scheme
drush config:get httpswww.settings exclude_subdomains
# or the whole object:
drush config:get httpswww.settings
```

## Mechanism (for context, not required to configure)

`Drupal\httpswww\EventSubscriber\HttpsWwwRedirectSubscriber` (constructor args
`@config.factory`, `@current_user`) subscribes to `kernel.request` at priority 299 (after user
authentication, before most of Drupal runs). On every request it reads `httpswww.settings`,
computes the canonical scheme/host from `scheme`/`prefix`/`exclude_subdomains`, and if the
current request's scheme+host differs, returns a `TrustedRedirectResponse` 301 to the canonical
URL (preserving the request path). It exits early if `enabled` is falsy or the current user has
`bypass httpswww redirect`.
