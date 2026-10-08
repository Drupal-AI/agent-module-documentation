Webform Migrate provides Migrate API source plugins and migration definitions that move Drupal 6 and Drupal 7 webforms — and their submissions — into the Drupal 9/10/11 Webform module.

---

The module ships four **migrate source plugins** (`Drupal\webform_migrate\Plugin\migrate\source`) — `d6_webform`, `d7_webform`, `d6_webform_submission`, `d7_webform_submission` — each a `DrupalSqlBase` that reads a legacy Drupal database, plus four matching **migration definitions** in `migrations/` (`d6_webform`, `d7_webform`, `d6_webform_submission`, `d7_webform_submission`). The webform source plugins read the legacy `webform`/`webform_component` tables and build a Webform config entity: the D7/D6 components are converted into Webform's `elements` YAML (via `buildFormElements()`), and legacy settings (confirmation, redirect, draft, submit limits, preview, progress bar) are mapped onto the new webform `settings`. The submission source plugins read `webform_submitted_data` and produce `webform_submission` entities keyed back to their host node. The webform migration destination is `entity:webform`; submissions target `entity:webform_submission` and depend on the webform migration. The module registers with the Drupal-to-Drupal upgrade path through `migrations/state/webform_migrate.migrate_drupal.yml` (declaring it finishes the legacy `webform` module for D7). Because the elements conversion cannot know about every custom component, the module invokes two alter hooks — `hook_webform_migrate_d7_webform_element_ELEMENT_TYPE_alter()` and the D6 equivalent — so other modules can inject or rewrite the YAML markup for a given element type. It depends on `webform` and `webform_node`, has no admin UI, no `configure` route, no permissions, and no config schema of its own; you run it via the standard Migrate tooling (migrate_drupal upgrade, or migrate_plus/migrate_tools with a configured legacy source database).

---

- Migrate all Drupal 7 webforms into Drupal 11's Webform module during a site upgrade.
- Migrate Drupal 6 webforms into a modern Drupal Webform site.
- Migrate Drupal 7 webform submissions (responses) so historical data survives the upgrade.
- Migrate Drupal 6 webform submissions into `webform_submission` entities.
- Convert legacy webform components into Webform `elements` YAML automatically.
- Preserve webform settings (confirmation message/URL, redirect, draft, submit limits) on migration.
- Keep each migrated webform attached to its original host node via `webform_node`.
- Run the migration as part of a Drupal-to-Drupal (migrate_drupal) upgrade path.
- Run the migration with migrate_plus/migrate_tools by referencing the `d7_webform` source plugin.
- Roll back a webform migration (the D7 source implements rollback awareness).
- Reuse the `d7_webform` source plugin in a custom migration config entity.
- Map legacy submission timestamps (submitted) onto created/completed/changed.
- Migrate the submitting user (uid) and remote address for each submission.
- Handle multi-page (wizard) webforms' progress-bar settings during migration.
- Customize the migrated YAML for a custom D7 element type via the element alter hook.
- Add support for a contrib webform component by implementing the D6/D7 element alter hook.
- Rewrite or fix up generated element markup (e.g. change a `#type`) during migration.
- Stage a webform content migration alongside core node/user upgrade migrations.
- Migrate confidential/limited webforms while retaining their access settings.
- Bulk-import legacy form definitions instead of rebuilding each webform by hand.
- Test a webform upgrade with the module's provided kernel-test fixtures as a reference.
- Include webform data in an incremental, re-runnable migration workflow.
- Migrate webforms whose file-upload submissions reference legacy `sites/default/files` paths.
