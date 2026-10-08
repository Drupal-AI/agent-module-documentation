# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Permissions by Term** module (`permissions_by_term`) — this module
  builds on it and does nothing without it.
- Core's **Dynamic Page Cache** module, which the redirect behaviour relies on to
  avoid serving a stale denial.

## Install with Composer

From the project root:

```bash
composer require drupal/permissions_by_term_redirect -W
```

The `-W` (`--with-all-dependencies`) flag pulls in Permissions by Term and any
other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/permissions_by_term_redirect -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en permissions_by_term_redirect -y
```

Make sure **Permissions by Term** and core **Dynamic Page Cache** are enabled as
well (Drush will enable the former as a dependency).

## Verify it worked

While logged out, visit a node that Permissions by Term restricts from anonymous
users. Instead of a plain "Access Denied", you should be redirected to the login
form. Log in with an account that is allowed to view the node, and you should land
back on that same node. If authenticated-but-denied users still get the normal
Access Denied page, that is expected — the redirect is only for anonymous
visitors.
