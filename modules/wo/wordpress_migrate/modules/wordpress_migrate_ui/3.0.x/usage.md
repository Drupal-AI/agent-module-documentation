WordPress Migrate UI is the wizard front-end for WordPress Migrate: a Ctools multi-step form that uploads a WXR export and collects the import options, then calls the generator to create the migrations.

---

The submodule adds a Ctools form wizard (`src/Wizard/ImportWizard.php`, extends `FormWizardBase`) at `/admin/structure/migrate/wordpress_migrate` (route `wordpress_migrate_ui.wizard.import`, plus a `/{step}` route), gated by the permission `migrate wordpress blogs`. An action link "Add import from WordPress" is placed on the Migrate Tools migration-group list (`entity.migration_group.list`), which is also the `configure` route. The wizard steps are individual forms under `src/Form/` — source/WXR upload (`SourceSelectForm`, which validates the `.xml` extension and saves the uploaded file to `public://`), author handling (`AuthorForm`), content-type and body-field selection for posts/pages (`ContentTypeForm`, `ContentSelectForm`, `BodyFieldSelectForm`), vocabulary and image selection (`VocabularySelectForm`, `ImageSelectForm`), comments (`CommentSelectForm`), and a final `ReviewForm`. On finish it injects the `wordpress_migration_generator_factory` service and runs the same `createMigrations()` as the Drush command, after the pre-flight `MigrationConfigValidator` checks pass. Depends on ctools, the parent wordpress_migrate module, migrate_tools, and core file + taxonomy. It provides no config of its own; all persisted output is the Migrate config entities the generator writes.

---

- Import a WordPress site through a guided, step-by-step UI instead of Drush or code.
- Upload a WXR (`.xml`) export directly in the browser.
- Optionally keep the uploaded WXR file permanently in the Files listing.
- Choose whether to import WordPress authors or assign all content to one default author.
- Pick the Drupal node bundle for imported posts.
- Pick the Drupal node bundle for imported pages.
- Select the body field and text format for imported content.
- Select the taxonomy vocabularies for tags and categories.
- Select an image field for imported attachments/thumbnails.
- Decide whether to import comments.
- Review all selections on a final confirmation step before generating.
- Reach the wizard from the "Add import from WordPress" button on the Migrate Tools group list.
- Restrict who can create WordPress imports via the `migrate wordpress blogs` permission.
- See pre-flight validation errors/warnings in the UI before migrations are generated.
- Generate the same migration set the CLI/API produces, then run them with Migrate Tools.
- Set up multiple imports (different groups) by re-running the wizard.
- Provide a non-developer-friendly path for content editors to stage a blog import.
- Store wizard progress between steps via Ctools SharedTempStore.
- Hand off generated migrations to Migrate Tools for import/rollback.
- Avoid hand-editing migration YAML entirely.
