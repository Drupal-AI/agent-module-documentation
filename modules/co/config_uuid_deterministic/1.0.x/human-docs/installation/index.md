# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's **System** module (always present).
- The **Ramsey UUID** PHP library, which is pulled in automatically via Composer.

This is the 1.0.3 release and is not covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/config_uuid_deterministic -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Ramsey UUID
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_uuid_deterministic -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it **early**, before you create the configuration you want to keep consistent
across environments, so those items get deterministic UUIDs from the start:

```bash
drush en config_uuid_deterministic -y
```

There is nothing to configure — deterministic UUIDs apply automatically from here on.

## Verify it worked

Run `drush config:export` and inspect the resulting YAML files. Export the same
configuration on another environment (or after a re-install) and confirm the `uuid`
values match for the same config names, rather than differing randomly. Matching
UUIDs across environments mean the module is doing its job.
