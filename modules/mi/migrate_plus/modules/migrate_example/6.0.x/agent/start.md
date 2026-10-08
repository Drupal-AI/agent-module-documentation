# migrate_example — agent start

Learning module (package Examples). A runnable "beer" demo: migration group `beer` with
`beer_user`, `beer_term`, `beer_node`, `beer_comment` migrations (config in
`config/install/migrate_plus.migration.*.yml`) and custom source plugins in
`src/Plugin/migrate/source/`. Depends on `migrate`, `migrate_plus`, `migrate_example_setup`
(which builds the destination content type/fields and seeds source tables), `menu_ui`, `path`.

Not something to keep enabled in production — read its YAML + source classes to learn a
migration end-to-end, then run with the Migrate Tools drush commands
(`drush migrate:status`, `drush migrate:import beer_node`). No configuration or plugins of its
own to document.
