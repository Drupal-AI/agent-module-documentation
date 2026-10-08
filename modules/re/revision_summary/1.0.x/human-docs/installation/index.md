# Installation

## Requirements

Revision Summary is a thin wrapper around the Diff module, so it needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **[Diff](https://www.drupal.org/project/diff)** module (`diff`) — this is the
  one hard dependency, since Revision Summary delegates the actual comparison work
  to Diff's `diff.entity_comparison` service.

There are no other PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/revision_summary -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Diff module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/revision_summary -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en revision_summary -y
```

Drupal will enable the Diff module at the same time as a dependency. That is all
the setup there is — the service becomes available immediately for your code to
call.

## Verify it worked

Because this module has no UI, the quickest check is from Drush:

```bash
drush php:eval "var_dump(\Drupal::hasService('revision_summary.compare_revisions'));"
```

If that prints `bool(true)`, the service is registered and ready. From here, see
the "How to use it" section of the [overview](../index.md) for the available
methods.
