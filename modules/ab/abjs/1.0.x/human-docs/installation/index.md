# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No third-party Composer or PHP library requirements of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/abjs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/abjs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en abjs -y
```

## Set up permissions before you begin

Before anyone starts building experiments, decide who gets which permission —
this module's security rests on that split:

- **`administer ab test scripts and settings`** — marked as a restricted
  permission. It gates every screen where a condition or experience is created or
  edited, i.e. everywhere JavaScript is authored. Because an experience is
  arbitrary JavaScript injected into page views, this is effectively the power to
  deploy code. Grant it only to people who would be allowed to deploy code.
- **`administer ab tests`** — not restricted. It lets a marketer create and run
  tests from snippets a developer has already approved. This is the one to grant
  the marketing team.

Set both under **People → Permissions**.
