Node title length is the title_length submodule that actually widens the node `title` column beyond Drupal's default 255 characters (to 500 by default). Enable it to let node titles hold long headlines, product names, or document titles.

---

This submodule is a thin, concrete subclass of the parent `title_length` machinery: `Drupal\node_title_length\NodeTitleLength extends EntityTitleLength`, targeting entity type `node` and title field `title`. On install (`node_title_length_install()`) it calls the service `node_title_length.node`'s `changeLength(getLength())`, which runs `Schema::changeField()` to widen `node_field_data.title` and `node_field_revision.title` to the configured length and re-installs the title base-field storage definition with the new `max_length`. A `hook_entity_base_field_info_alter()` sets the runtime `title` base-field `max_length` to `getLength()` so Drupal's form/validation limit matches the wider column. The length defaults to **500** (`EntityTitleLengthInterface::DEFAULT_LENGTH`); override it with `$settings['node_title_length_chars']` in `settings.php` and re-apply with `drush title_length:update node`. On uninstall it shrinks the column back to 255, but refuses (`ModuleUninstallValidatorException`) if any node or revision already has a title longer than 255. There is no admin UI, config object, or permission.

---

- Allow node titles longer than the default 255 characters.
- Store long, descriptive article headlines without truncation.
- Keep long product names as node titles.
- Hold long legal or document titles in a content type.
- Raise the node title limit to a custom size (e.g. 1000) via settings.php.
- Set `$settings['node_title_length_chars']` before enabling to pick the length.
- Re-apply a changed node title length with `drush title_length:update node`.
- Widen both the node data table and the node revision table title columns at once.
- Keep the `title` base-field `max_length` in sync with the DB column automatically.
- Support migrations importing nodes whose source titles exceed 255 chars.
- Give editorial teams more headline room when hitting the 255 limit.
- Avoid writing a custom `hook_update_N` to ALTER the node title column by hand.
- Enable only node title widening without touching taxonomy term names.
- Standardise a larger node title limit across a multisite via shared settings.php.
- Guard against accidentally shrinking the column below existing long titles.
- Use the `node_title_length.node` service to re-apply the length programmatically.
- Support long SEO-oriented titles that would otherwise be cut at 255.
- Accommodate long auto-generated node titles (e.g. from imported data feeds).
- Provide a wider title column for content types that concatenate several values into the title.
