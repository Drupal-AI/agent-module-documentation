# The import wizard

## Route & access

- `wordpress_migrate_ui.wizard.import` → `/admin/structure/migrate/wordpress_migrate`
- `wordpress_migrate_ui.wizard.import.step` → `/admin/structure/migrate/wordpress_migrate/{step}`
- Both require permission **`migrate wordpress blogs`** (`wordpress_migrate_ui.permissions.yml`).
- Entry point: action link "Add import from WordPress" on the Migrate Tools group list
  (`entity.migration_group.list`), which is also the module's `configure` route.

Implementation: `src/Wizard/ImportWizard.php` extends Ctools `FormWizardBase`; step state is held in a
`SharedTempStore` collection `wordpress_migrate_ui.wizard.import`.

## Steps (forms in `src/Form/`)

| Step form | Collects |
|---|---|
| `SourceSelectForm` | WXR upload (`.xml`), and whether to permanently keep the file. |
| `AuthorForm` | Import WP authors vs a single default author. |
| `ContentTypeForm` / `ContentSelectForm` | Target node bundle(s) for posts/pages. |
| `BodyFieldSelectForm` | Body field + text format for content. |
| `VocabularySelectForm` | Tag/category vocabularies. |
| `ImageSelectForm` | Image field for attachments/thumbnails. |
| `CommentSelectForm` | Whether/how to import comments. |
| `ReviewForm` | Final confirmation, then generate. |

## WXR upload handling (`SourceSelectForm`)

- File field restricted to the `xml` extension (`file_validate_extensions` / `FileExtension` validator).
- Saved with `file_save_upload('wxr_file', …, 'public://', 0)`; a name clash triggers a rename. The
  resulting `file_uri` is stored in the wizard's cached values and passed to the generator.

## Finish → generation

On the final step the wizard injects `wordpress_migration_generator_factory`, runs the pre-flight
`MigrationConfigValidator` (via `wordpress_migrate.logger`); if there are no blocking errors it calls
`createGenerator()->createMigrations($configuration)` — identical output to
`drush wordpress_migrate:generate`. Then run the generated migrations with Migrate Tools
(`drush migrate:import …`). See the parent module's
[api/generator.md](../../../../../3.0.x/agent/api/generator.md).
