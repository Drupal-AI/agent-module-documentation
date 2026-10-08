Config import single adds one Drush command that imports a **single** configuration YAML file into the active configuration, without running a full config sync of the whole sync directory.

---

The module is a thin Drush wrapper (a port of Drupal Console's `config:import:single`) exposing exactly one command: `config_import_single:single-import` (alias `cis`). You give it the path to a single exported config file (e.g. `views.view.frontpage.yml`); it reads the YAML, derives the config object name from the **filename without its extension** (`Symfony\Component\Filesystem\Path::getFilenameWithoutExtension`), wraps the active `config.storage` in a `StorageReplaceDataWrapper` with that one object replaced, builds a `StorageComparer`, and runs core's `ConfigImporter` as a batch (via `drush_backend_batch_process()`). Because it uses the real ConfigImporter, the change is validated (schema, dependencies, import event subscribers) exactly like `drush config:import`, but scoped to the one object in the file — so it can create, update, or delete-then-recreate a single config item. It throws if no file is given, if the file does not exist, or if the import fails validation. It has no admin UI, no config, no permissions of its own, and requires `drush/drush >= 11.3`.

---

- Import just one changed `*.yml` config file into a site without a full `drush config:import`.
- Apply a single view's config (`views.view.my_view.yml`) pulled from another environment.
- Push one updated block/field/form-display config object during development.
- Re-import a single accidentally-changed config object back to its exported version.
- Create a new config entity from a hand-written YAML file (filename = config object name).
- Update a settings config object (e.g. `system.site.yml`) from a file without touching the rest.
- Selectively deploy one config change in a hotfix without exporting/importing everything.
- Import config for a feature under active development while other config differs from the sync dir.
- Script targeted config updates in CI/CD that only touch specific objects.
- Restore a single config item from a backup YAML file.
- Copy one config object between multisite instances by importing its file individually.
- Test how a single config change validates against the current site (uses core ConfigImporter).
- Seed a demo/role/menu config object from a committed YAML fixture.
- Import a translated/overridden config file into the active store on demand.
- Avoid `config:import` blocking on unrelated config differences when you only need one object in.
- Roll out an updated pathauto/pattern or similar single config object to production quickly.
- Reapply one config object after a module update reset it.
- Use `cis` in a deploy hook to import a specific config file generated at build time.
- Import a single content type or field storage YAML during incremental migrations.
- Bring one config object's changes into the active config so it can then be exported cleanly.
- Provide developers a quick `drush cis path/to/file.yml` instead of editing config in the DB.
