# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The [H5P](https://www.drupal.org/project/h5p) module (`h5p:h5p`) enabled — this
  is a hard dependency, since H5P is what produces the xAPI statements this module
  captures.
- **Cron configured to run regularly.** The module batches and sends statements
  to the LRS on cron; without cron, captured data never leaves the site.
- An external **Learning Record Store** to receive the data, with its endpoint
  URL and credentials.

There are no third-party Composer or PHP library requirements.

> **Note:** this module is **not covered by Drupal's security advisory policy**,
> and it handles learner personal data. Review both points before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/h5p_analytics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the H5P
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/h5p_analytics -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en h5p_analytics -y
```

## Submodules

- **`h5p_analytics_tip`** — an optional submodule shipped with the project.
  Enable it if you want its additional functionality:

  ```bash
  drush en h5p_analytics_tip -y
  ```

## Verify it worked

1. Configure the LRS endpoint and credentials — see
   [Configuration](../configuration/index.md).
2. Have a user interact with a piece of H5P content (answer a quiz, for example).
3. Run cron (`drush cron`) so the queued statements are batched and sent.
4. Check your LRS to confirm statements are arriving. If nothing appears, verify
   cron is running and that the LRS endpoint and credentials are correct.
