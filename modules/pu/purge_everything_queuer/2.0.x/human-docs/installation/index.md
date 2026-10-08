# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- The **Purge** module (`purge`), set up and working — see the
  [Purge documentation](https://www.drupal.org/project/purge) for the pipeline.
  Purge is pulled in automatically as a dependency.
- An active **purger that supports "everything" invalidation** for the queuer to
  have any effect.

## Install with Composer

From the project root:

```bash
composer require drupal/purge_everything_queuer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/purge_everything_queuer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en purge_everything_queuer -y
```

That is all — there is no settings form. The cron safeguard is active
immediately, and the `purge_everything_queuer.everything` service is available to
custom code.

## Verify it worked

1. Go to **Configuration → Development → Performance → Purge**
   (`/admin/config/development/performance/purge`) and confirm the **Everything
   queuer** is available in the list of queuers you can add.
2. Make sure at least one enabled **purger supports "everything" invalidation** —
   otherwise the queuer and the cron safeguard have nothing to act on.
