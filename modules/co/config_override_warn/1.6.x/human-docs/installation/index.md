# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No other module dependencies, and no third‑party Composer or PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_override_warn -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_override_warn -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_override_warn -y
```

That's all it takes — there is no required configuration.

## Verify it worked

If you have a config override in place, the easiest way to confirm the module works
is to trigger one. For example, add a line like
`$config['system.site']['name'] = 'Overridden name';` to your `settings.php`, rebuild
the cache, then open **Configuration → System → Basic site settings**
(`/admin/config/system/site-information`). You should see a warning message at the
top of the form noting that `system.site` `name` is overridden. Remove the test
line from `settings.php` afterwards if you added it only to check.
