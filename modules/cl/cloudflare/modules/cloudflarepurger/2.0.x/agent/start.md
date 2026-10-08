<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudflare Purger — agent index

Submodule of **cloudflare**. Clears the Cloudflare CDN cache via the **Purge** module: a purger
plugin plus a Cloudflare `Cache-Tag` header generator. Requires `cloudflare` + `purge`.
Settings form at `/admin/config/services/cloudflare/purger` (permission `administer cloudflare`).

- **Purger plugin, diagnostic checks, cache-tag header & excludelist config** →
  [plugins/purger.md](plugins/purger.md)
- **`cloudflarepurger.settings` (cache_tag_excludelist)** →
  [configure/settings.md](configure/settings.md)

Key facts: Purge purger plugin id **`cloudflare`** (`@PurgePurger`, types
`tag`, `url`, `everything`). Config `cloudflarepurger.settings.cache_tag_excludelist`
(sequence of tag prefixes). Cache-Tag header limit param
`cloudflarepurger.cache_tag_header_limit` = 255. Diagnostic checks: `cloudflare_creds`,
`cloudflare_api_rate_limit_check`, `cloudflare_daily_limit_check`. Actual purges hit the
Cloudflare API — evals stay in local config/plugin state.
