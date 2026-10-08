# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- No other modules, Composer packages, or PHP libraries are required — the
  module uses only core's request-handling and configuration systems.

## Install with Composer

From the project root:

```bash
composer require drupal/anonymous_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/anonymous_redirect -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en anonymous_redirect -y
```

The redirect is **off by default** after enabling, so nothing changes for your
visitors until you configure and switch it on. Continue to
[Configuration](../configuration/index.md).

> **Tip:** before you enable the redirect, decide which paths anonymous users
> still need — especially the **login page** — and add them to the overrides
> list, or anonymous visitors (including you, if you log out) could be locked out
> of the very page they need to log in from.
