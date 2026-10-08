# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No third-party Composer libraries and no PHP extension requirements.
- Best suited to teams that keep configuration in code (`config/sync`) and use git.

Pax is a developer/deployment tool. It has no admin UI and defines no permissions.

## Install with Composer

From the project root:

```bash
composer require drupal/pax -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pax -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Add the two required `settings.php` lines

This step is essential. **Installing the module lets Pax *write* shards, but
Drupal can only *read* them back if you register the sharding storage class.** Add
these two lines to your `settings.php` (adjust the path if your contrib modules
live elsewhere):

```php
require_once 'modules/contrib/pax/src/ShardingFileStorage.php';

class_alias('Drupal\pax\ShardingFileStorage', 'Drupal\Core\Config\FileStorage');
```

Shard reading is file-driven: if those two lines are present, whatever shard files
exist will be picked up even before the module is installed — which is useful for
an initial deployment where the shards already exist in your repository. Shard
*writing*, however, requires the module to be enabled.

## Enable the module

```bash
drush en pax -y
```

## Verify it worked

Run a configuration export and look at your sync directory:

```bash
drush config:export -y
```

You should now see subdirectories such as
`core.entity_form_display.node.article.default/content/` containing one small YAML
file per field, instead of a single large `core.entity_form_display.…yml`. Import
the configuration again (`drush config:import`) to confirm the shards recombine
cleanly with no changes reported.
