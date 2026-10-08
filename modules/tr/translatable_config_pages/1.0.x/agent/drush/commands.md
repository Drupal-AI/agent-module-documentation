# Drush commands

Defined in `drush.services.yml` (service `translatable_config_pages.commands`,
class `Commands\TranslatableConfigPagesCommands`; injects `translatable_config_pages.manager` +
`language_manager`). Requires Drush ^10 (per composer.json `extra.drush`).

| Command | Alias | Arguments | Behaviour |
| --- | --- | --- | --- |
| `translatable_config_pages:getConfigFieldValue` | `tcp-gc-fv` | `bundle` `field` `[langcode]` | Loads the config page for `bundle` (that language's translation if `langcode` given) and prints `$entity->get($field)->getString()`. Logs an error if the bundle or field does not exist. |

```bash
# Default language
drush translatable_config_pages:getConfigFieldValue site_footer field_phone
drush tcp-gc-fv site_footer field_phone

# Specific language
drush tcp-gc-fv site_footer field_phone es
```

`getString()` returns a flattened string of the field value (suitable for scalar-ish fields such as
plain text/number); complex/multi-value fields are stringified by core's field API.
