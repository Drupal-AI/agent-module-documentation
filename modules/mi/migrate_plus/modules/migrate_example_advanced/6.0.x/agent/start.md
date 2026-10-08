# migrate_example_advanced — agent start

Learning module (package Examples). Specialized migration examples beyond the basic beer demo:
remote `url` sources, XML/data-parser usage, and more elaborate process pipelines, declared as
`migrate_plus.migration.*` config with custom source plugins in `src/Plugin/migrate/source/`.
Depends on `migrate`, `migrate_plus`, and hidden `migrate_example_advanced_setup` (destination
config + fixtures; also pulls `rest`). Read the YAML and source classes, run with Migrate Tools
drush commands. No config/plugins of its own to document.
