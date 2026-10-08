Migrate Default Content Export is the companion submodule to Migrate Default Content: it exports existing site content to `ENTITY_TYPE.BUNDLE.yml` files (in the format Migrate Default Content imports) via a Drush command, so you can turn live content into version-controlled fixtures.

---

Enabling this submodule adds the `migrate-default-content:export-content` (alias `mdcec`) Drush command and a `content_export_dir` field to the parent module's settings form. Running the command reads content entities, applies a chain of **FieldProcessor** plugins that decide how each field value is serialized (entity/user references become their identifiers, files become filenames, colors/links/paths/comments/layout sections are normalized, integers cast, and password fields are stripped out), optionally applies **ExportEntityFilter** plugins to skip certain entities (the admin user and the anonymous user are filtered by default), and writes one YAML file per entity-type+bundle to the configured export directory. The export can be scoped by entity type, bundle, specific ids, or exclusions, and by default drops null field values (a large `DEFAULT_IGNORED_FIELDS` list also removes revision/timestamp/translation bookkeeping fields). Both the field processors and entity filters are extensible plugin types, so you can control exactly how custom field types are exported. Like the parent, this is a developer/build-time tool run from the CLI.

---

- Export all site content to YAML fixtures with `drush mdcec`.
- Export a single entity type: `--export=node`.
- Export a single bundle: `--export=node:article`.
- Export everything except one type or bundle with `--exclude`.
- Export specific entities by id with `--ids=1,4`.
- Exclude specific entities by id with `--exclude-ids=1,4`.
- Capture the current state of a demo site as re-importable default content.
- Round-trip content: edit in the UI, export to YAML, commit, re-import elsewhere.
- Automatically convert entity references back to their identifier for portability.
- Convert file fields back to filenames for the files-directory workflow.
- Strip password data from exported user content (PasswordFieldProcessor).
- Skip the admin (uid 1) and anonymous users automatically on user export.
- Keep null field values in the export with `--allow-null` when you need them.
- Exclude revision/timestamp bookkeeping fields automatically for clean fixtures.
- Add a FieldProcessor plugin to control how a custom field type is serialized.
- Add an ExportEntityFilter plugin to exclude certain entities from export.
- Generate seed content for a distribution from a reference site.
- Produce test fixtures for functional tests from a curated content set.
