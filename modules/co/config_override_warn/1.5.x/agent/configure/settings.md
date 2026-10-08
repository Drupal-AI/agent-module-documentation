<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Config Override Warn

`configure: null` — the module ships **no settings form and no route**. Everything it has is
one boolean in `config_override_warn.settings`.

## The config object

```yaml
# config/install/config_override_warn.settings.yml
show_values: true
```

Schema (`config_override_warn.schema.yml`): `config_override_warn.settings` is a
`config_object` with a single boolean `show_values` labelled "Show overridden values".

| Value | Message content |
|---|---|
| `true` (default) | "The value for **key** has been overridden. **`'old'`** has been changed to **`'new'`**" — both values are `var_export()`ed into the message. |
| `false` | Only "The value for **key** has been overridden." — no values are printed. Use this when overrides carry secrets. |

Internally, when `show_values` is `FALSE` the service stores `NULL` for each key instead of
the `['original' => …, 'override' => …]` pair; the Twig template skips the value sentence when
the override entry is empty.

## Read it / change it

```bash
drush config:get config_override_warn.settings show_values
drush config:set config_override_warn.settings show_values 0 -y   # hide values
drush config:set config_override_warn.settings show_values 1 -y   # show values (default)
```

In PHP:

```php
\Drupal::configFactory()->getEditable('config_override_warn.settings')
  ->set('show_values', FALSE)->save();
```

Because it is ordinary configuration you can also override the module's own setting
per-environment from `settings.php`:

```php
$config['config_override_warn']['settings']['show_values'] = FALSE; // production
```

## Making the module actually warn

The module warns only if a config object edited by the form is really overridden. Two ways to
create such an override:

1. **`settings.php`** — `$config['system.site']['slogan'] = 'Pinned by deployment';`
2. **A module service** tagged `config.factory.override` implementing
   `\Drupal\Core\Config\ConfigFactoryOverrideInterface::loadOverrides()`.

Both land in the `Config` object's protected `settingsOverrides` / `moduleOverrides`
properties, which is exactly what this module reads.

## Update hook

`config_override_warn_update_8101()` rewrites the whole settings object to
`['show_values' => TRUE]`; there is no other install/uninstall logic.
