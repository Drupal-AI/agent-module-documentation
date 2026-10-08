# Installation

## Requirements

Linkit Media Library needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Linkit** module (`drupal/linkit` `^7`) — provides the link autocomplete framework
  and the CKEditor 5 extension this module hooks into.
- Core's **Media Library** module (`media_library`) enabled.

Linkit is pulled in by Composer; Drupal enables Media Library as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/linkit_media_library -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies and pull
in Linkit at the same time.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/linkit_media_library -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en linkit_media_library -y
```

When it is enabled, the module adds a media matcher to Linkit's **default** profile if that
profile does not already have one — so on many sites the button will work after a little
text-format setup. If you use a *different* Linkit profile, you will need to add the media
matcher to it yourself. See [Configuration](../configuration/index.md).
