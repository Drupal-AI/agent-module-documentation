# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Translation Management Tool** module (`tmgmt`) — pulled in automatically as a
  dependency. You'll typically also have your site set up as multilingual with
  translatable content.
- A **Google Cloud Translation API key** with the Translation API enabled on your
  Google Cloud project.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tmgmt_google -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in TMGMT and update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tmgmt_google -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tmgmt_google -y
```

This enables TMGMT too if it is not already on.

## Next steps

Create a Google translation provider and paste in your API key — see
[Configuration](../configuration/index.md).
