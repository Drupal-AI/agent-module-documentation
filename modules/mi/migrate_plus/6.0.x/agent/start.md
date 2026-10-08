# migrate_plus — agent start

Extends core Migrate: `migration` + `migration_group` **config entities**, a pluggable `url`
source, and many extra process plugins. Depends on core `migrate`. No admin UI, no Drush of
its own (run migrations with `migrate_tools`' drush commands).

- Migration & migration_group config entities, shared group config → [configure/migrations.md](configure/migrations.md)
- The `url` source + data_fetcher / data_parser / authentication plugins → [plugins/data-plugins.md](plugins/data-plugins.md)
- Extra process/source/destination plugins (DOM, entity_lookup, table, …) → [api/process-plugins.md](api/process-plugins.md)
- React to source rows via events, add your own parser/fetcher/auth plugin → [extend/events.md](extend/events.md)
