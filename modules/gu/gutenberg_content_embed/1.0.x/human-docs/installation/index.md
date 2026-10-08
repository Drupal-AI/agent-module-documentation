# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **Gutenberg** module (`gutenberg`) — this module extends the Gutenberg editor
  and lists it as a dependency, so Composer installs it automatically. You then
  enable the Gutenberg experience on the content types where you want to author with
  it.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/gutenberg_content_embed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Gutenberg and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gutenberg_content_embed -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gutenberg_content_embed -y
```

There is no settings page to visit. Configuration happens per content type, and
editors need Gutenberg's **Use Gutenberg** permission to use the embed block — see
the [main page](../index.md#how-to-use-it).
