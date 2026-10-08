# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1** or newer.

There are no additional module dependencies and no third‑party Composer or PHP
library requirements — the module works standalone.

> **Note on security coverage:** this project is **not covered by Drupal's security
> advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/extend_help_maintainers -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/extend_help_maintainers -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en extend_help_maintainers -y
```

That's all it takes. Maintainer blocks begin appearing on module help pages that
have maintainer data; no configuration is required to get started.

## Verify it worked

Go to **Administration → Help** and open the help page of a module that declares
maintainers. You should see a **Maintainers** block with names, avatars (or a
placeholder), and links to Drupal.org profiles.

Next, if you want to control which sources are used and how they are prioritized,
see [Configuration](../configuration/index.md).
