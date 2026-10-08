<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Token Defaults (token_default) — agent index

Supplies a **fallback value for tokens that resolve to nothing**. Implemented as a
`hook_tokens_alter()` that runs after core replacement, spots the requested tokens core
left unresolved, and injects an admin-configured default for each. Defaults are
**`token_default_token` configuration entities** managed at
`/admin/config/search/token_default` behind the `administer token defaults` permission.
Depends on `token`. Version **2.0.0-rc2** (a release candidate). Core `^8 || ^9 || ^10 || ^11`.

## How it works
- **`token_default.module`** — `token_default_tokens_alter()`: returns early unless
  `token_default.settings:enabled`; delegates to the `token_default.manager` service to add
  defaults for missing tokens; then re-scans each replacement and, if it still contains
  tokens, runs `Drupal::token()->replace()` again (recursion capped by
  `recursive_limit`, default 5; a logged warning fires at the cap). Also `hook_help()`.
- **`TokenDefaultManager`** (`token_default.manager`, args `@entity_type.manager`) —
  `replaceMissingTokensWithDefaults()`: missing = `array_diff($context['tokens'], keys($replacements))`;
  resolves the entity from `$context['data']` (`entity`, else `token_type`); loads
  `token_default_token` entities `loadByProperties(['type' => entityTypeId, 'pattern' => $token])`
  and applies `replacement` when the stored bundle is empty or equals the entity's bundle.
- **`Entity/TokenDefaultToken`** — config entity, `config_prefix` `token_default_token`,
  exported keys `id, label, type, bundle, pattern, replacement`. Getters/setters for
  pattern/replacement/bundle.
- **`Form/TokenDefaultTokenForm`** — add/edit form. Fields: label, machine id, pattern,
  replacement, and a bundle select. The **`type` field is a hidden input hard-coded to
  `node`** (TODO in source to make entity type selectable), so the UI only creates node
  defaults; bundle empty = any node type.
- **`Form/SettingsForm`** (`token_default.settings`) — `enabled` checkbox + `recursive_limit`
  number.
- **`TokenDefaultTokenListBuilder`**, **`TokenDefaultTokenDeleteForm`**,
  **`TokenDefaultTokenHtmlRouteProvider`** (admin route provider) — standard config-entity UI.

## Facts
- **Routes:** `entity.token_default_token.collection` at `/admin/config/search/token_default`;
  `token_default.settings_form` at `/admin/config/search/token_default/settings`. Both require
  `administer token defaults`. Add/edit/delete routes come from the entity's own links
  (`/admin/config/search/token_default_token/...`).
- **Permission:** `administer token defaults` (the config-entity annotation's `admin_permission`
  is `administer site configuration`).
- **Config:** install default `token_default.settings` = `{enabled: TRUE, recursive_limit: 5}`;
  schema `token_default_token.schema.yml` covers the config entity.
- **No** Drush commands, libraries, plugin types, submodules, or automated tests.
- **Known limits (README):** token pattern string is unvalidated (no single-token enforcement);
  one content type per default via UI; no way to scope a default to a specific replacement
  context (e.g. pathauto only).

See `../usage.md` for use cases and `configure/token-defaults.md` for the setup workflow and config-entity model.
