# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5||^10||^11`).

There are no dependent contrib modules and no additional PHP or third-party
library requirements. Cleanup runs on cron, so your site needs cron running as
usual.

## Install with Composer

From the project root:

```bash
composer require drupal/skip_temp_file_warnings -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/skip_temp_file_warnings -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en skip_temp_file_warnings -y
```

## Next steps

Enabling the module alone does not clean anything yet — you need to tell it which
file-URI scheme(s) to act on. See [Configuration](../configuration/index.md), then
let cron run (or run it manually with `drush cron`) and confirm the repeating
"Could not delete temporary file …" warning stops appearing.
