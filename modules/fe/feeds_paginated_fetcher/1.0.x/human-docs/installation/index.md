# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Feeds** module (`feeds:feeds`) enabled — this is the only dependency, and
  the paginated fetcher plugs into it.

There are no extra Composer libraries or PHP extensions to install.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_paginated_fetcher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you don't already have Feeds, Composer will pull it in.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_paginated_fetcher -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_paginated_fetcher -y
```

This also enables Feeds if it isn't on yet.

## Verify it worked

Go to **Structure → Feed types** (`/admin/structure/feeds`) and add or edit a
Feed type. In the fetcher selection you should now see **Paginated HTTP Fetcher**
as an option. Configure it as described in the guide's "How to use it" section.
