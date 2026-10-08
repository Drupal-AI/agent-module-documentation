# Drush commands

Defined in `src/Drush/Commands/ConfigPagesCommands.php` (registered via `drush.services.yml`).
Both require the `config_pages` module enabled.

## Set a field value

```
drush config:pages-set-field-value <bundle> <field_name> <value> [context]
drush cpsfv my_settings field_phone "+1 555 0100"
drush cpsfv my_settings field_body "line1\nline2" --append
```

- Aliases: `cpsfv`, `config-pages-set-field-value`.
- Creates the config page entity for the bundle/context if it does not exist yet, then sets the
  value and saves.
- `--append` appends to the field's existing string value instead of replacing.
- `\n` in the value is converted to a real newline.
- Optional 4th arg `context` targets a specific context (defaults to current).

## Get a field value

```
drush config:pages-get-field-value <bundle> <field_name> [context]
drush cpgfv my_settings field_phone
```

- Aliases: `cpgfv`, `config-pages-get-field-value`.
- Prints `->value` of the field on the resolved (current-context by default) config page.

> A separate Drupal Console command set also exists (`console/`, `config_pages.get_value` /
> `config_pages.set_value`), but Drupal Console is deprecated — prefer the Drush commands above.
