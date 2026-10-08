<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTPS and WWW Redirect — agent index

Issues a 301 redirect on every request to enforce one canonical scheme (HTTP/HTTPS) and one
canonical host (`www.` or bare). One config object (`httpswww.settings`), one settings form
(`/admin/config/system/httpswww`), one event subscriber. No config schema, no default config,
no plugins, no Drush commands.

- **Config keys, allowed values, the settings form, and reading/writing config via drush** →
  [configure/httpswww.md](configure/httpswww.md)
- **The two permissions and what `bypass httpswww redirect` does** →
  [permissions/httpswww.md](permissions/httpswww.md)

Key facts:
- Config object: `httpswww.settings` — keys `enabled` (bool), `prefix` (`mixed`/`no`/`yes`),
  `scheme` (`mixed`/`https`), `exclude_subdomains` (array, only used when `prefix: yes`).
- No `config/install` and no `config/schema` ship with the module — on a fresh install the
  config object has no stored values at all; the redirect subscriber treats missing/empty
  `enabled` as "do nothing."
- Mechanism: `Drupal\httpswww\EventSubscriber\HttpsWwwRedirectSubscriber` (services:
  `@config.factory`, `@current_user`) runs on `kernel.request` (priority 299) and issues a
  `TrustedRedirectResponse` 301 when the live host/scheme don't match the configured canonical
  form, unless the current user has `bypass httpswww redirect`.
