Config Devel is a developer tool that automates moving Drupal configuration between YAML files and the active configuration store, and that exports a module's owned config back into its `config/install` directory (a Features-style workflow for D8+).

---

The module offers three related tools, all driven from either the `config_devel.settings` config object or Drush. First, **auto-import**: list config files (paths relative to the Drupal root) in the settings form's "Auto import" box, and at the start of every request Config Devel checks each file's hash and, if changed, imports it into active storage — as if you pasted it into core's *Single import* form. Second, **auto-export**: list config object names in "Auto export", and whenever one of those objects is saved through the admin UI, its current value is written back out to the file(s) you specified. Third, a **Features-like module export/import** via Drush: a module lists the config objects it owns in a `config_devel:` section of its `.info.yml`, then `drush config:devel-export MODULE` writes those objects into the module's `config/install` (and `config/optional`) directory, and `drush config:devel-import MODULE` reads them back into active storage. A fourth command, `config:devel-import-one`, imports a single YAML file (or stdin) into active storage, deriving the config object name from the filename. The module registers two event subscribers (auto-import and auto-export) plus a `ConfigImporterExporter` service; it has no plugins and no permissions of its own (the settings form is gated by the core `import configuration` permission). It is explicitly a development-only tool and should not be deployed to production.

---

- Auto-import a config YAML file into active storage on every request while iterating on it locally.
- Keep a hand-edited `views.view.frontpage.yml` in sync with the site without clicking through *Single import* each time.
- Auto-export a config object to a file whenever you change it in the admin UI, so edits land in version control.
- Build a reusable "feature" module by listing its config in a `config_devel:` info section and running `drush cde`.
- Export `node.type.article` plus its form/view displays and fields into a custom module's `config/install`.
- Re-import a module's shipped config into active storage after tweaking the YAML with `drush cdi`.
- Import a single config file with `drush config:devel-import-one path/to/system.site.yml`.
- Pipe config from a remote environment into a local object via stdin: `drush cdi1 system.site < file`.
- Split one config object's export across multiple target files listed for the same object.
- Move config edits from a developer's UI clicks straight into a module's `config/install` directory.
- Package a content model (content type, fields, displays) as installable module config.
- Migrate a Drupal 7 Features-style workflow to Drupal 8+ config management.
- Round-trip a single config object: export it to a module, edit the YAML, import it back.
- Prototype config changes in YAML files and apply them instantly via auto-import.
- Distribute default configuration with a contrib/custom module by exporting owned objects.
- Verify a module installs cleanly by re-importing its exported `config/install` config.
- Populate a fresh module's `config/optional` directory from live config objects.
- Automate config export in a local dev loop so nothing has to be exported by hand.
- Keep a demo/reference config object under source control and auto-import it on each run.
- Inspect which files/objects are wired for auto-import or auto-export in `config_devel.settings`.
- Seed a distribution's install profile config from a running site's config objects.
- Reduce manual copy/paste between the *Single export* screen and files on disk.
