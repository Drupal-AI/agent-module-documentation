# Installation

## Requirements

Config Override Warn is a single-purpose helper with no dependencies:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No other contrib modules, Composer libraries or PHP extensions are required.

## Install with Composer

From the project root:

```bash
composer require drupal/config_override_warn -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/config_override_warn -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_override_warn -y
```

That is all it takes. The module has no configuration form and no permissions —
the override warnings start appearing on configuration forms immediately.

## Verify it worked

Create a config override (if you do not already have one) and check that the
warning shows. For example, add a line like this to `settings.php`:

```php
$config['system.site']['slogan'] = 'Pinned by deployment';
```

Then visit **Configuration → System → Basic site settings**
(`/admin/config/system/site-information`). You should see a warning that the
slogan value has been overridden. If you would rather the warning not print the
overridden values (for example when overrides hold secrets), see the note in the
[overview](../index.md#the-one-setting-showing-or-hiding-overridden-values).
