# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Mouseflow account**, from which you'll copy the tracking code / site ID.

There are no other module dependencies and no third-party PHP libraries to
install.

## Install with Composer

From the project root:

```bash
composer require drupal/mouseflow_tracking -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mouseflow_tracking -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mouseflow_tracking -y
```

Enabling the module does not start tracking on its own — you must paste your
Mouseflow tracking code and switch tracking on. See
[Configuration](../configuration/index.md), and read its privacy notes before
enabling tracking on a live site.

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep mouseflow_tracking
```

Then, after configuring and enabling tracking (next page), load a front-end page
as an anonymous visitor and confirm (via your browser's developer tools) that the
Mouseflow script is present on the pages you expect — and absent on the pages and
for the IPs you excluded.
