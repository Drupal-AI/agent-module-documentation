# varnish_purge_tags — agent start

Submodule of `varnish_purger` (project `varnish_purge`). Adds one Purge `@PurgeTagsHeader`
plugin, `varnish_tagsheader`, that emits a **`Cache-Tags` response header** on cacheable
responses so Varnish can `BAN` cached pages by Drupal cache tag. No config, no admin page —
`drush en varnish_purge_tags` is all it takes. Depends on `varnish_purger`.

- The single TagsHeader plugin and how tag-based invalidation flows → [plugins/tagsheader.md](plugins/tagsheader.md)

Parent module → [../../../../2.3.x/agent/start.md](../../../../2.3.x/agent/start.md)
