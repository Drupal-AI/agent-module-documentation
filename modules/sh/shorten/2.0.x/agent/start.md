# Shorten URLs — agent index

Shortens URLs through **external** services (is.gd, TinyURL, Bit.ly, ~25 more). Provides
`shorten_url()` API, a `/shorten` page, two blocks, a `[url:shorten]` token, and a
primary+backup+cache pipeline. No dependencies. It delegates to third-party services — it does
not mint local short codes or redirects.

- **Admin settings, keys form, permissions, config keys, blocks** →
  [configure/settings.md](configure/settings.md)
- **`shorten_url()` / `shorten_fetch()` API, tokens, service definitions** →
  [api/functions.md](api/functions.md)
- **`hook_shorten_service()` / `hook_shorten_create()` extension points** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Routes: `shorten.admin_form` `/admin/config/services/shorten` (perm `administer site
  configuration`); `shorten.keys_form` `/admin/config/services/shorten/keys` (perm `manage Shorten
  URLs API keys`); `/shorten` (perm `use Shorten URLs page`).
- Config object `shorten.settings` (has schema): `shorten_service`, `shorten_service_backup`,
  `shorten_method` (php/curl), `shorten_timeout`, cache durations, per-service API keys, etc.
- Blocks: `shorten` (shorten-any-URL form), `shorten_short` (short URL for current page).
- Submodules in-project (not documented here): `record_shorten`, `shorten_cs`, `shortener`.
