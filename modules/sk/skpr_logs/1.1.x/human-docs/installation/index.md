# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2||^11`).
- A site running on the **Skpr** hosting platform — that is the environment this
  module is designed for, since the platform consumes the JSON log stream it
  produces.

There are no dependent contrib modules and no additional PHP or third-party
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/skpr_logs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/skpr_logs -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en skpr_logs -y
```

## Verify it worked

All configuration is automatic — there is no settings form. After enabling the
module, trigger some activity on the site and confirm that JSON-formatted log
lines (with the `skpr_component` and `request_id` fields) are being written to
`stderr`.
