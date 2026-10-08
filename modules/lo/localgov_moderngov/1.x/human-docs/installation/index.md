# Installation

## Requirements

- **Drupal 10.5 or 11.2** and up (`core_version_requirement: ^10.5 || ^11.2`).

The module declares no hard module or third-party library dependencies. It is part of
the **LocalGov Drupal** distribution and is aimed at UK council sites that use
Modern.Gov for democratic services.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_moderngov -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_moderngov -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_moderngov -y
```

Note that this is a beta release (the current version is a 1.x beta), so test it
before relying on it in production.

## Verify it worked

Visit **`/moderngov-template`** on your site — you should see the example Modern.Gov
template page, with the `{pagetitle}`, `{breadcrumb}`, `{content}` and `{sidenav}`
tokens in place and links/assets rendered as absolute URLs. You can also check the
`?nocontent`, `?header` and `?footer` variants at the same path.
