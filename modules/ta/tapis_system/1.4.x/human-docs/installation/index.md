# Installation

## Requirements

TAPIS Systems needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **TAPIS Tenant** (`tapis_tenant`) and **TAPIS Auth** (`tapis_auth`) — install
  and configure these first.
- Core **Node** and **Views**.

The module's own documentation also mentions companion modules such as Storage,
Field Group, and Inline Entity Form for its editing experience; Composer resolves
whatever is declared as a dependency for you. There are no extra PHP or
third-party library requirements. Note this release is a beta (version
1.4.1-beta), so treat it accordingly on production sites.

## Install with Composer

From the project root:

```bash
composer require drupal/tapis_system -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the TAPIS and core
dependencies as needed. (The Composer package name, `drupal/tapis_system`, matches
the module's machine name, `tapis_system`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tapis_system -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tapis_system -y
```

## Verify it worked

With the module enabled you should be able to create **Tapis System**, **Tapis
System Scheduler Profile**, and **Tapis System Credential** content, and each
user's profile page should show the two views listing the systems and credentials
they can access. Remember that private keys for credentials are stored only in
TAPIS, never in Drupal.
