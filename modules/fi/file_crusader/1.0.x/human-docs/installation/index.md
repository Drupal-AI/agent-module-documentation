# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **File** (`file`) module, which Drupal enables automatically as a
  dependency.

There are no third-party Composer or PHP library requirements.

> **Maturity:** this is an **alpha** release and is **not covered by Drupal's
> security advisory policy**. Because the module moves files and rewrites references,
> back up your files and database before enabling it, and test on a non-production
> copy first.

## Install with Composer

From the project root:

```bash
composer require drupal/file_crusader -W
```

Because current releases are pre-stable, you may need to request the alpha explicitly
(and/or set your project's minimum stability to allow it):

```bash
composer require 'drupal/file_crusader:^1.0@alpha' -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_crusader -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_crusader -y
```

## Verify it worked

On a non-production copy, attach a file to a piece of content, publish it, then
unpublish it, and confirm the file can no longer be reached by its direct public URL.
Try a file that is also referenced by another published entity and confirm it is left
in place (with a warning) rather than hidden. This confirms the module is respecting
publish state across all parents as intended.
