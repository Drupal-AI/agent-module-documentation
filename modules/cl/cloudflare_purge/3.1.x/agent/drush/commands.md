<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Defined in `Commands\CloudflarePurgeCommands` (Drush 12+ attribute style, `drush.services.yml`). All
purge commands route through the `Purge` service, so they honor the same credential resolution,
Zone-ID validation, rate limiting, and automatic batching (100 items/request) as the UI.

| Command | Aliases | Args | Action |
|---|---|---|---|
| `cloudflare:purge-all` | `cf-purge-all`, `cfpa` | — | Purge the entire zone (`purge_everything`). |
| `cloudflare:purge-url` | `cf-purge-url`, `cfpu` | `urls` (variadic) | Purge specific URLs. |
| `cloudflare:purge-tags` | `cf-purge-tags`, `cfpt` | `tags` (variadic) | Purge by cache tag. |
| `cloudflare:purge-prefixes` | `cf-purge-prefixes`, `cfpp` | `prefixes` (variadic) | Purge by URL prefix. |
| `cloudflare:purge-hostnames` | `cf-purge-hosts`, `cfph` | `hostnames` (variadic) | Purge by hostname. |
| `cloudflare:status` | `cf-status`, `cfs` | — | Report whether credentials are configured. |

Multiple items may be space- or comma-separated:

```bash
drush cloudflare:purge-url https://example.com/a https://example.com/b
drush cfpu "https://example.com/a,https://example.com/b"
drush cloudflare:purge-tags node:123 taxonomy_term:45
drush cfpp https://example.com/blog/
drush cf-purge-hosts cdn.example.com,images.example.com
drush cloudflare:purge-all
drush cloudflare:status
```

Notes:
- Without configured credentials the purge commands error with a pointer to
  `/admin/config/cloudflare-purge/credentials`; use `cloudflare:status` to check first.
- Prefixes are normalized (a leading scheme is stripped — Cloudflare rejects schemed prefixes).
- Tags are run through the shared `CacheTagFormatter` (prefix + optional hash) so CLI purges match the
  tags emitted in the `Cache-Tag` header.
- Good for CI/CD and cron: e.g. `drush cloudflare:purge-all` after a deploy, or scripted per-URL purges.
