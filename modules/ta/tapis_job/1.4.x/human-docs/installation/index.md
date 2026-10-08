# Installation

## Requirements

TAPIS Jobs needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **TAPIS Auth** (`tapis_auth`) — and, through the suite, TAPIS Tenant, TAPIS
  System, and TAPIS Apps.
- The **Key** module (`key`) and the **JWT** module (`jwt`), used for secure
  credential storage and token handling.
- Core **Views**. The module's own documentation also mentions **HTMX** for its
  interactive job screens.

Composer resolves these dependencies for you. There are no extra PHP or
third-party library requirements. Note this release is a beta (version
1.4.1-beta), so treat it accordingly on production sites.

## Install with Composer

From the project root:

```bash
composer require drupal/tapis_job -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the TAPIS, Key,
JWT, and core dependencies as needed. (The Composer package name,
`drupal/tapis_job`, matches the module's machine name, `tapis_job`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tapis_job -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tapis_job -y
```

## Verify it worked

With the module enabled and a TAPIS app available, you should be able to open an
app's page and launch a job from it, then see that job listed in the jobs view on
your profile page, with controls to check its status, view output, and cancel or
delete it.
