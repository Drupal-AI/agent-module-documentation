<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Token (config_token) — agent index

Define **custom tokens** whose values are stored in **configuration**, exposed as
`[config_token:<machine_name>]` and usable wherever Drupal tokens are supported.
Installed release **8.x-1.9** (version dir `8.x-1.x`). Core `^10.3 || ^11 || ^12` (verified on 11.4.5).

## What it is / isn't

- **Is:** a thin Token API integration. `hook_token_info()` advertises each admin-defined token;
  `hook_tokens()` resolves it by looking up a value in config and (optionally) running it through a
  text format. Two admin forms manage definitions and values as configuration.
- **Isn't:** it does **not** resolve `[token]`s that appear *inside* other configuration values at read
  time. There is no `ConfigFactoryOverrideInterface`, no config event subscriber, no runtime service
  API, no plugin type, and no Drush command. It only *provides* tokens; something else (Token Filter, a
  token-enabled module setting, `\Drupal::token()->replace()`) must render them.

## Mechanism (real names)

- Hooks live in `src/Hook/ConfigTokenHooks.php` (registered as a service, dispatched from
  `config_token.module` via `#[LegacyHook]` shims). Service args: `@config.factory`, `@renderer`.
- Token type is `config_token`. Each allowed token becomes `[config_token:<name>]`.
- Two config objects:
  - `config_token.settings` → `allowed_tokens[<name>] = {name, description, format_id}` (the definitions).
  - `config_token.tokens` → `replacements[<name>] = <value>` (the values).
- Rendering (`ConfigTokenHooks::tokens()`):
  - Skips any requested token not present in `allowed_tokens`.
  - Missing value → empty string.
  - `format_id === '' | NULL` → returns the stored value **verbatim** (raw); Token API escapes it since
    it is a plain string. This is the "None (raw value)" option.
  - Otherwise runs the value through `applyFilterFormat()` — a `#type => processed_text` render element
    with `#format => format_id` (avoids the deprecated `check_markup()`), returned as `MarkupInterface`
    so Token API does **not** re-escape the text-format output.
  - Adds both config objects as `addCacheableDependency`, so edits invalidate embedding caches.
- A token with **no** `format_id` key at all (pre-dates the option) defaults to `plain_text`.

## Admin surface

- Routes (`config_token.routing.yml`), both gated by permission `administer config_tokens`:
  - `/admin/config/system/config_tokens` → `ConfigTokensForm` (values, editable config `config_token.tokens`).
  - `/admin/config/system/config_tokens/allowed_tokens` → `AllowedConfigTokensForm` (definitions, editable
    config `config_token.settings`).
- `AllowedConfigTokensForm` only offers text formats the current user can `use` (`$format->access('use')`);
  validates machine names against `^[a-z0-9_-]+$` and rejects duplicates; on save calls
  `token_clear_cache()`.
- `ConfigTokensForm` keeps "orphan" values (a value whose token is no longer allowed) selectable so they
  round-trip instead of silently overwriting another token, and warns about them.
- `ConfigTokenFormBase` adds a hidden implicit-submit Save button and a delete-guard so a stray Enter or a
  fallback-button submission cannot silently delete row 1 (see `getDeletedRow()`).

## Install / config seeds

- Enabling installs three example tokens: `example_email` (plain_text), `example_phone` (plain_text),
  `example_link` (basic_html), with values `email@example.com`, `02070000000`, `http://www.example.com`.
  Confirmed live via `drush cget config_token.settings` / `config_token.tokens`.
- Dependencies: `drupal:filter`, `token:token`. `token_filter` is a **test/dev** dependency only.

## Rendering a config token in content

1. Enable **Token Filter** on a text format (`/admin/config/content/formats`).
2. Put `[config_token:example_email]` in a field using that format.
3. Or resolve programmatically: `\Drupal::token()->replace('[config_token:example_email]')`.
4. All defined tokens are listed with core tokens at `/admin/help/token`.

## See also

- `config/config-objects.md` — the two config objects, schema, and a config/CLI-driven workflow for
  bulk-defining tokens and per-environment / per-domain overrides.

## Notes for agents

- Values are **plain, exportable config** — never store secrets in a config token (readable wherever the
  token renders and in `config/sync` exports).
- Everything is behind one permission, `administer config_tokens`; treat it as a trusted site-builder
  permission (a widely-embedded token is a site-wide lever).
