Title length raises the maximum character length of entity title fields above Drupal's default 255. It is a small framework: the parent module supplies the machinery and a Drush command, while its submodules (`node_title_length`, `taxonomy_term_title_length`) actually apply the new length to node titles and taxonomy term names.

---

The parent `title_length` module ships an abstract service class `EntityTitleLength` (interface `EntityTitleLengthInterface`) and a Drush command, but declares no entity types itself — enabling it alone changes nothing. Each submodule subclasses `EntityTitleLength` (e.g. `NodeTitleLength`) to name a target entity type and its title field, and on install calls `changeLength()`, which (a) runs a schema `changeField()` to widen the title column (and the revision title column) to the desired length and (b) re-installs the base-field storage definition with the new `max_length`; a `hook_entity_base_field_info_alter()` keeps the field definition's `max_length` in sync. The default length is **500 characters** (`EntityTitleLengthInterface::DEFAULT_LENGTH`); override it before/after install with `$settings['node_title_length_chars']` / `$settings['taxonomy_term_title_length_chars']` in `settings.php` (read via `Settings::get()`). If you change the length later, re-apply it with the Drush command `drush title_length:update <entity_type>` (aliases: `node`, `taxonomy_term`). The command and the uninstall hook refuse to *shrink* the length if any entity or revision already has a title longer than the target (`checkIfExistEntitiesWithLongTitles()`). There is no admin UI, no config object, and no permissions.

---

- Allow node titles longer than the default 255 characters.
- Allow taxonomy term names longer than 255 characters.
- Raise the title limit to a custom size (e.g. 1000) via a settings.php variable.
- Support long, descriptive article headlines that exceed 255 chars.
- Store long product names as node titles without truncation.
- Accommodate long legal/document titles in a content type.
- Re-apply a changed title length with `drush title_length:update node`.
- Re-apply term-name length with `drush title_length:update taxonomy_term`.
- Keep the base-field `max_length` and the DB column in sync automatically.
- Widen both the data table and the revision data table title columns at once.
- Set the desired length before enabling the submodule via settings.php.
- Prevent shrinking the length when long titles already exist (safety check).
- Use only the node submodule if you don't need longer term names.
- Use only the taxonomy submodule if you only need longer term names.
- Provide the length-change machinery for a custom title_length-style submodule.
- Extend `EntityTitleLength` to lengthen titles of another entity type.
- Migrate content with long source titles into Drupal nodes.
- Avoid a custom hook/update to widen the title column by hand.
- Standardise a larger title limit across a multisite via shared settings.php.
- Increase headline capacity for an editorial team hitting the 255 limit.
