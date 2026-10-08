<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Protected Pages Extra

## Admin UI routes

- **Overview / list** — `/admin/config/system/protected-pages-extra` (route `entity.protected_page.collection`, this is the `configure` link). Perm: `access protected pages extra overview page` or `administer protected pages extra`.
- **Add page** — `/admin/config/system/protected-pages-extra/add` (perm `create and edit protected page`).
- **Edit page** — `/admin/config/system/protected-pages-extra/manage/{protected_page}` (perm `create and edit protected page`).
- **Delete page** — `.../manage/{protected_page}/delete` (perm `delete protected page`).
- **Send email** — `.../manage/{protected_page}/send-email` (perm `create and edit protected page`).
- **Settings** — `/admin/config/system/protected-pages-extra/settings` (route `protected_pages_extra.settings`, perm `administer protected pages extra`).
- **Login form** — `/protected-page/login` (route `protected_pages_extra.login`, `no_cache: TRUE`, perm `access protected page extra password screen`).

## Per-page entity (`protected_page` config entity)

Each entity has: `title` (admin label), `paths` (array; internal paths like `/node/5`, or wildcard patterns like `/news/*`), `password` (hashed via `PasswordInterface`; leave blank on edit to keep the existing hash), `allow_append_password` (bool, default FALSE). Config prefix: `protected_pages_extra.page.<id>`. Exportable with `drush cex`.

## Settings config: `protected_pages_extra.settings`

Edited from the settings form (`ProtectedPagesExtraSettingForm`, a `ConfigFormBase` with `#config_target` bindings).

- `password.per_page_or_global` — `per_page_password` (default) | `per_page_or_global` | `only_global`.
- `password.global_password` — hashed. Bound via a custom `ConfigTarget` using `ToConfig::NoOp`, so a blank submit keeps the stored hash.
- `password.session_expire_time` — minutes; `0` = unlimited. An unlock older than this re-prompts the visitor.
- `login.title` / `login.description` / `login.password_label` / `login.submit_button_text` / `login.incorrect_password_msg` — login-form strings. `description` and `incorrect_password_msg` are rendered through `Xss::filterAdmin()`.
- `email.subject` / `email.body` / `email.wildcard_text` — templates for the per-entity Send email operation. Body tokens: `[protected-page-urls]` (absolute URLs of exact paths), `[protected-page-wildcard-text]` (the `wildcard_text` snippet, only when the entity has wildcard paths; empty otherwise), `[site-name]`. Inside `wildcard_text`: `[protected-page-wildcard-urls]` (the wildcard patterns). Password is hashed and never tokenized.
- `flood.ip_limit` (default 50) / `flood.ip_window` (default 3600s) — failed attempts allowed per IP before lockout.
- `flood.page_limit` (default 10) / `flood.page_window` (default 3600s) — failed attempts allowed per page-per-IP.
- `flood.ip_allowlist` — list of `{from, to}` entries. Empty `to` = single IP; both set = inclusive range. IPv4 and IPv6 (endpoints must match family). Allowlisted IPs skip both the flood pre-check and per-attempt registration; the password check still runs. Managed with an AJAX add/remove table on the settings form.
- `disabled_protected_pages_module` — bool. Hidden unless `protected_pages` is enabled. Set to `TRUE` automatically on migration to suppress the legacy module's redirect. Flip to `FALSE` to re-enable the legacy path.

## Caching / CDN

Responses on protected paths get `Cache-Control: private, no-store` plus the entity's `config:protected_pages_extra.page.<id>` cache tag. `hook_protected_page_insert` and `hook_protected_page_update` (only when `paths` changed) invalidate the `http_response` tag, evicting pages cached before they became protected. A tag-aware CDN purger (e.g. Purge module) is needed to act on that invalidation.

## Excluding passwords from config export

Protected page entities and the settings are normal config, so `drush cex` writes the hashes. To keep per-environment passwords out of git, use Config Ignore:

```yaml
# config_ignore.settings.yml
ignored_config_entities:
  - protected_pages_extra.page.*
```

The same pattern works for `protected_pages_extra.settings` to vary the global password per environment.

## Migration from `protected_pages`

If `protected_pages` is enabled at install time, the install hook migrates entity rows (1:1), settings, and role permissions in one step, then sets `disabled_protected_pages_module: TRUE`. Verify migrated entities at the overview page, then `drush pmu protected_pages`.

## config_translation

A mapper (`protected_pages_extra.config_translation.yml`) exposes login and email strings for per-language overrides at `/admin/config/regional/config-translation` when the `config_translation` module is installed.
