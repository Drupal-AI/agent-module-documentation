# feeds — agent start

Imports/aggregates external data (RSS/Atom, CSV, OPML, sitemap) into content entities via a
fetch → parse → process pipeline. A **feed type** (`feeds_feed_type` config entity) pins a
fetcher + parser + processor and maps source elements to field targets; **feeds** (`feeds_feed`
content entities) are concrete sources you import. Config UI: **Admin → Structure → Feed types**
(`/admin/structure/feeds`, route `entity.feeds_feed_type.collection`); feeds at `/admin/content/feed`.

- Create/configure feed types & mapping → [configure/feed-type.md](configure/feed-type.md)
- Plugin types (fetcher/parser/processor/target/source) & how to add one → [plugins/plugin-types.md](plugins/plugin-types.md)
- Import programmatically (Feed entity API) → [api/import.md](api/import.md)
- React to import stages via events → [extend/events.md](extend/events.md)
- Drush import/enable/lock commands → [drush/commands.md](drush/commands.md)
- Permissions (global + per feed type) → [permissions/permissions.md](permissions/permissions.md)
