# WordPress Migrate UI — agent index

Ctools wizard front-end for the parent `wordpress_migrate` module: upload a WXR file, answer the import
options across steps, and it calls the generator to create the migrations. Depends on `ctools`,
`wordpress_migrate`, `migrate_tools`, core `file` + `taxonomy`. Permission: `migrate wordpress blogs`.
`configure` route `wordpress_migrate_ui.wizard.import`.

- **The wizard route/permission, its steps, WXR upload handling, and the finish → generator flow** →
  [configure/wizard.md](configure/wizard.md)

Parent module (generator API, Drush, logging): [../../../../3.0.x/agent/start.md](../../../../3.0.x/agent/start.md)

Key facts:
- Wizard `src/Wizard/ImportWizard.php` (`FormWizardBase`) at `/admin/structure/migrate/wordpress_migrate`.
- Action link "Add import from WordPress" on `entity.migration_group.list`.
- Steps are forms in `src/Form/`; finish runs `wordpress_migration_generator_factory` +
  `MigrationConfigValidator`.
- No config of its own; output is the Migrate config entities the generator writes.
