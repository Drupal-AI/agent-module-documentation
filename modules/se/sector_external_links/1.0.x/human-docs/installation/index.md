# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **External Links** module (`extlink`) — this is a hard dependency; this
  module tailors extlink and does nothing on its own.

There are no third-party PHP or library requirements, and there are no submodules.
It is intended for **Sector** distribution sites.

## Install with Composer

From the project root:

```bash
composer require drupal/sector_external_links -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in External Links and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sector_external_links -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sector_external_links -y
```

Enabling it will also enable External Links if it is not already on.

## Verify it worked

Visit a page containing a link to an external site. The external-link indicator
should now render as a Material Symbols icon rather than the default Font Awesome
one. If you do not see an indicator at all, check the **External Links** module's
settings to confirm external-link marking is enabled.
