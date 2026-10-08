# Installation

## Requirements

jQuery UI is a lightweight library provider. It needs:

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).

There are no other module dependencies and no third‑party Composer or PHP
library requirements — the jQuery UI files themselves are vendored inside the
module.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jquery_ui -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_ui -y
```

That's all it takes. As soon as the module is enabled the jQuery UI libraries
are available for any module or theme to depend on or attach — there is no
required configuration and no settings form to visit.
