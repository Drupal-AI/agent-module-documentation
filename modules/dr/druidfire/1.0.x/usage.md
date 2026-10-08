<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Druidfire provides Drush commands and a PHP service API to alter existing entity field definitions in place — resizing fields and converting between field types.

---

Druidfire is a developer/DevOps tool (no admin UI, no config form) for transforming already-created entity fields without hand-written update hooks or manual database work. It ships five field operations packaged as "Spell" plugins: `resize` (change a text/string field's max length), `string2formatted` (plain string field to formatted long-text with a WYSIWYG format column), `err2er` (Entity Reference Revisions field to plain Entity Reference), `err2bricks` (ERR field to a Bricks `bricks_revisioned` field), and `string2taxonomyReference` (string field to a taxonomy-term entity reference, creating the terms as needed). Each spell rewrites the SQL storage schema (through the `entity.storage_schema.sql` keyvalue store and live `Schema` ALTERs), the `field.storage`/`field` config records, and the matching form/view display config, then clears cached entity definitions. You invoke a spell from Drush (`drush druidfire:<spell> …`) or from PHP (`\Drupal::service('druidfire')->resize(...)`), which makes it suited to scripted deployments and content migrations. Spell operations reshape and can drop field storage, so they are inherently destructive and are meant to be run by trusted developers on the CLI, tested first, and only after a database backup. It defines the `Spell` plugin type, so custom transformations can be added by other modules.

---

- Enlarge a `string`/`varchar` field's max length (e.g. a title field from 255 to 1024) without a manual DB migration.
- Resize a specific sub-property of a compound field (e.g. a link field's `title` property) via the optional property argument.
- Convert a plain `string` field into a `text_long` formatted-text field so editors get a WYSIWYG/format selector.
- Add the `_format` companion column and index when promoting a string field to formatted text.
- Convert an Entity Reference Revisions field to a standard Entity Reference field, dropping the `target_revision_id` column and index.
- Migrate an ERR field into a Bricks (`bricks_revisioned`) field with the extra `_depth` and `_options` columns for layout building.
- Convert a free-text `string` field into a taxonomy-term reference, auto-creating any missing terms in a given vocabulary from the existing values.
- Backfill the new `target_id` column with term IDs matched from the previous string values during a string-to-taxonomy conversion.
- Automate all of the above from a deployment pipeline via `drush druidfire:<spell>` commands.
- Drive the same operations from an `hook_update_N()` or `hook_deploy_N()` using `\Drupal::service('druidfire')`.
- List every available spell and its description with `drush druidfire:list-spells` (alias `drush druidfire:ls`).
- Perform bulk field-type standardisation across many bundles during a large site refactor.
- Recover from an incorrectly chosen field type after content already exists, without recreating the field.
- Adjust field storage that other tools cannot change once data is present.
- Add a project-specific field transformation by writing a new `Spell` plugin under `Plugin/Spell`.
- Extend or alter available spells through the `hook_druidfire_spell_info` alter hook.
- Keep form and view display config in sync automatically when a field's type changes.
- Update the entity's last-installed field-storage definition so Drupal's schema state stays consistent after a conversion.
- Script repeatable field transformations for use across dev, staging and production environments.
- Prototype field-model changes quickly in a development environment before committing to config.
- Use as a reference implementation of an annotation-based custom plugin type in Drupal.
