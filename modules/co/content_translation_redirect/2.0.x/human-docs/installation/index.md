# Installation

## Requirements

- **Drupal 9.1 or newer** (`core_version_requirement: ^9.1 || ^10 || ^11 || ^12`).
- Core's **Content Translation** module (`content_translation`) — pulled in
  automatically as a dependency.
- A **multilingual site**: the redirect behaviour only fires when more than one
  language is configured. (You'll typically also have core's **Language** module and
  translatable content types set up.)

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_translation_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_translation_redirect -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_translation_redirect -y
```

The module ships a **Default** redirect rule that is installed but disabled (no
status code set), so nothing changes until you configure a rule — see
[Configuration](../configuration/index.md).
