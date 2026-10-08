# Configure search-engine submission & IndexNow

Settings form `simple_sitemap.engines.settings` at
`/admin/config/search/simplesitemap/engines/settings`. Status list at
`/admin/config/search/simplesitemap/engines`. Permission: `administer sitemap settings`.

## Settings (`simple_sitemap_engines.settings`)
| Key | Meaning |
|---|---|
| `enabled` | Master switch for scheduled sitemap submission to engines. |
| `submission_interval` | Hours between submissions (throttle; default 24). |
| `index_now_enabled` | Enable IndexNow change notifications. |
| `index_now_preferred_engine` | Engine used for IndexNow key verification (`''` = any). |
| `index_now_on_entity_save` | Fire an IndexNow notice on entity form save. |

## Search engines (config entities)
`simple_sitemap_engine.<id>` entities ship for `bing`, `yandex`, `seznam`, `naver`, `yep`
and `index_now`. Each holds the submission URL template. Add your own by creating another
config entity of the same type.

## How it runs
- `simple_sitemap_engines_cron()` submits sitemaps when the interval elapses.
- Entity insert/update/delete hooks queue IndexNow notices
  (`SitemapSubmittingWorker` queue worker; `IndexNowSubmitter`).
- IndexNow key is served at `/simple_sitemap_engines/index_now_key/{key}`.

Permission `index entity on save` lets non-admins toggle IndexNow per entity when
`index_now_on_entity_save` is on.
