# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node**, **Field**, **User** and **System** modules — all part of a
  standard Drupal install, so nothing extra to download.
- A **SPhoenix AI account / credentials** for the external service. The module is
  only useful once it can authenticate to SPhoenix AI.

There are no additional Composer libraries or PHP extension requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sphoenixai -W
```

Note the Composer package name is `drupal/sphoenixai` even though the module's
machine name is `sphoenix_ai`. The `-W` (`--with-all-dependencies`) flag lets
Composer update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sphoenixai -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sphoenix_ai -y
```

## Verify it worked

After enabling, head to [Configuration](../configuration/index.md) and supply
your SPhoenix AI credentials. The AI generation, analysis and chatbot features
only come to life once that connection is in place.
