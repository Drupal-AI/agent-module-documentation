Taxonomy term title length is the title_length submodule that widens the taxonomy term `name` column beyond Drupal's default 255 characters (to 500 by default). Enable it to let term names hold long labels, tags, or imported category names.

---

This submodule is a thin, concrete subclass of the parent `title_length` machinery: `Drupal\taxonomy_term_title_length\TaxonomyTermTitleLength extends EntityTitleLength`, targeting entity type `taxonomy_term` and title field `name`. On install (`taxonomy_term_title_length_install()`) it calls the service `taxonomy_term_title_length.taxonomy_term`'s `changeLength(getLength())`, which runs `Schema::changeField()` to widen the term data table's `name` column (and the revision table when revisionable) to the configured length and re-installs the term `name` base-field storage definition with the new `max_length`. A `hook_entity_base_field_info_alter()` sets the runtime `name` base-field `max_length` to `getLength()` so Drupal's form/validation limit matches the wider column. The length defaults to **500** (`EntityTitleLengthInterface::DEFAULT_LENGTH`); override it with `$settings['taxonomy_term_title_length_chars']` in `settings.php` and re-apply with `drush title_length:update taxonomy_term`. On uninstall it shrinks the column back to 255, but refuses (`ModuleUninstallValidatorException`) if any term or term revision already has a name longer than 255. There is no admin UI, config object, or permission.

---

- Allow taxonomy term names longer than the default 255 characters.
- Store long, descriptive category or tag names without truncation.
- Hold long imported vocabulary labels (e.g. from a product taxonomy feed).
- Raise the term name limit to a custom size (e.g. 1000) via settings.php.
- Set `$settings['taxonomy_term_title_length_chars']` before enabling to pick the length.
- Re-apply a changed term name length with `drush title_length:update taxonomy_term`.
- Widen both the term data table and the term revision table `name` columns at once.
- Keep the `name` base-field `max_length` in sync with the DB column automatically.
- Support migrations importing terms whose source names exceed 255 chars.
- Give editorial teams more room for long taxonomy labels.
- Avoid writing a custom `hook_update_N` to ALTER the term name column by hand.
- Enable only taxonomy term widening without touching node titles.
- Standardise a larger term name limit across a multisite via shared settings.php.
- Guard against accidentally shrinking the column below existing long names.
- Use the `taxonomy_term_title_length.taxonomy_term` service to re-apply the length programmatically.
- Accommodate long hierarchical path-style term names.
- Provide a wider name column for vocabularies that concatenate several values into the term name.
- Support long scientific, legal, or geographic names as taxonomy terms.
