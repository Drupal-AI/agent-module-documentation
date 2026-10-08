# Drush command

Registered in `drush.services.yml` (`Drupal\title_length\Commands\TitleLengthCommands`).

## `title_length:update <entity_type>`

Re-applies the configured title length to an entity type's title column. Use it after changing
the `<entity_type>_title_length_chars` value in `settings.php`.

```bash
drush title_length:update node
drush title_length:update taxonomy_term
```

- `<entity_type>` must match a submodule's service — `node` (→ `node_title_length.node`) or
  `taxonomy_term` (→ `taxonomy_term_title_length.taxonomy_term`). The command resolves the
  service as `\Drupal::service("{$entity_type}_title_length.{$entity_type}")`.
- It first calls `checkIfExistEntitiesWithLongTitles(getLength())`; if any existing title/
  revision is longer than the target length it aborts with `CommandFailedException`
  ("Entities or entity revisions exist with long titles. The length cannot be lowered.").
- Otherwise it calls `changeLength(getLength())` and logs "Update executed successfully."

There is no command to *set* the length — the length comes from `settings.php` (or the 500
default). This command only (re-)applies it to the database schema.

> `title_length.install` also ships `title_length_update_8002()`, an update hook that installs
> the `node_title_length` submodule for existing projects on `drush updatedb`.
