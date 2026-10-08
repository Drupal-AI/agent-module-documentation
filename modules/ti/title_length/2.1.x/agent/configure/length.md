# Choosing the title length

There is **no admin UI and no config object**. The length is a code constant with a
`settings.php` override.

## Default & constants

- Default applied length: **500** (`EntityTitleLengthInterface::DEFAULT_LENGTH`).
- Original core length: **255** (`EntityTitleLengthInterface::ORIGINAL_LENGTH`) — used when
  uninstalling to shrink back.
- `EntityTitleLength::getLength()` returns
  `Settings::get('<entity_type>_title_length_chars') ?: 500`.

## Override the length (settings.php)

```php
// web/sites/default/settings.php
$settings['node_title_length_chars'] = 1000;
$settings['taxonomy_term_title_length_chars'] = 512;
```

The variable name is `<entity_type>_title_length_chars` (`node`, `taxonomy_term`).

## Applying a change

- **On install** of a submodule, the length is applied automatically (its `hook_install()`
  calls `changeLength(getLength())`).
- **If you change the settings.php value later**, re-apply it:

  ```bash
  drush title_length:update node
  drush title_length:update taxonomy_term
  ```

  See [../drush/commands.md](../drush/commands.md).

## Safety: cannot shrink below existing data

`changeLength()` on uninstall (and `title_length:update` when lowering) first calls
`checkIfExistEntitiesWithLongTitles()`. If any node/term (or revision) already has a title
longer than the target, the operation is refused (uninstall throws
`ModuleUninstallValidatorException`; the Drush command throws `CommandFailedException`). Widen
first, backfill/shorten data before narrowing.

## Where the length actually lives

Not in config — in the **database schema**. `changeLength()` runs `Schema::changeField()` on
the entity's data table (and revision data table) title column, then re-installs the base-field
storage definition so `max_length` matches. `hook_entity_base_field_info_alter()` also sets the
base-field `max_length` at runtime, so the field definition reports the new length even before
a re-apply.
