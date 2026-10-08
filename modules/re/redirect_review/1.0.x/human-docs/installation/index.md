# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[Redirect](https://www.drupal.org/project/redirect)** module
  (`redirect`) — the redirects it reports on.
- Core's **Views** module (`views`) — the report is a view. Views ships with
  core and is normally already enabled.

> **Heads up:** Redirect Review is **unsupported and marked obsolete**, and is
> **not covered by the security advisory policy**. Consider
> [Redirect Audit](https://www.drupal.org/project/redirect_audit) instead.

## Install with Composer

From the project root:

```bash
composer require drupal/redirect_review -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including the Redirect module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/redirect_review -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redirect_review -y
```

Drupal will enable the Redirect and Views dependencies automatically if they are
not already on.

## Verify it worked

Once enabled, open the redirect problem report the module provides and confirm it
lists any redirects that currently resolve to a 403, 404, or a redirect loop. If
your site has no broken redirects, the report will simply be empty.
