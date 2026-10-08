# aggregator — agent start

RSS/RDF/Atom feed aggregator (formerly Drupal core, removed in core 10.0; now contrib).
Downloads external feeds and stores them as content entities, displayed at `/aggregator`.
Two content entities: `aggregator_feed` (a source) and `aggregator_item` (an imported
article). Import runs on cron through a 3-stage pipeline of swappable plugins:
**fetcher** → **parser** → **processor**. Depends on core `file`, `filter`, `options`;
pulls in `laminas/laminas-feed`. Configure route: `aggregator.admin_settings`.

- Manage feeds, OPML import, and global/processor settings (routes, config keys) → [configure/settings.md](configure/settings.md)
- The fetcher/parser/processor plugin types and how to write one → [plugins/pipeline-plugins.md](plugins/pipeline-plugins.md)
- Alter which fetcher/parser/processor class is used → [hooks/alters.md](hooks/alters.md)
- Services & entity APIs to import feeds / read items in code → [api/services.md](api/services.md)
- The two permissions and the SSRF caution → [permissions/permissions.md](permissions/permissions.md)
