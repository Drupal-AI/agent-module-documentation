# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Access to a **BigBlueButton server** — you need its base URL and its shared
  secret to connect.

There are no additional module dependencies and no third-party Composer or PHP
library requirements listed.

> **Note:** This release is a beta (`1.0.0-beta5`). Test it on a non-production
> environment before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/bigbluebutton -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bigbluebutton -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bigbluebutton -y
```

After enabling, continue to [Configuration](../configuration/index.md) to connect
your BigBlueButton server and set who may create meetings.
