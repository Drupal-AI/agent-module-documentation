# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Google API key** with access to the PageSpeed Insights API (see
  [Configuration](../configuration/index.md)).

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/google_pagespeed_report -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_pagespeed_report -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_pagespeed_report -y
```

## Verify it worked

Log in as an administrator and open the module's reports section. Before any data
appears you will need to add your PageSpeed API key — continue to
[Configuration](../configuration/index.md).
