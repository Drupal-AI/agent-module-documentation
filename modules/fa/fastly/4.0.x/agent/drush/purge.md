# Drush: Fastly purge commands

Class `Drupal\fastly\Commands\FastlyCommands` (`drush.services.yml`). All require valid Fastly
credentials (`api_key` + `service_id`, or the `FASTLY_API_*` env vars) and network access.

| Command | Alias | Action |
|---|---|---|
| `fastly:purge:all` | `fpall` | Purge/invalidate **all** site content on Fastly (`Api::purgeAll()`). |
| `fastly:purge:url` | `fpurl` | Purge a single URL: `drush fastly:purge:url https://example.com/node/1`. |
| `fastly:purge:key` | `fpkey` | Purge by cache tag(s)/key(s): `drush fastly:purge:key 'node:1,node:2'` — the keys are hashed via `CacheTagsHash::cacheTagsToHashes()` first. |
| `fastly:purge:service` | `fpservice` | Purge the whole Fastly service (`Api::purgeAll(FALSE)`). |

```bash
drush fastly:purge:all
drush fpurl https://example.com/blog
drush fpkey 'node:12,taxonomy_term:4'
drush fpservice
```

Each command prints a success or error line depending on the `Api` response. `fastly:purge:key`
takes a comma-separated list and converts tags to their Surrogate-Key hashes before calling the API.
