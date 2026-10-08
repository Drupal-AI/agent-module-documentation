# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Media** module (`media`), which is pulled in as a dependency.
- The **`j7mbo/twitter-api-php`** PHP library (`~1.0`), which Composer installs
  automatically. It is only actually used if you turn on the Twitter API option;
  simple tweet embedding works without any API credentials.

## Install with Composer

From the project root:

```bash
composer require drupal/media_entity_twitter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`j7mbo/twitter-api-php` library and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_entity_twitter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_twitter -y
```

Enabling the module copies a default `twitter.png` icon into the media icon
directory so tweets have a fallback thumbnail.

There are no submodules.

## Next step

Media Entity Twitter has no settings of its own — the real setup is creating a
Media type that uses the Twitter source. Continue to
[Configuration](../configuration/index.md).
