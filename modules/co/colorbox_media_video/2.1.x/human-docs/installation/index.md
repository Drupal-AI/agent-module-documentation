# Installation

## Requirements

- **Drupal 11.2 or 12** (`core_version_requirement: ^11.2 || ^12`).
- Core's **Media** module (`media`) enabled, with the **Remote Video** media type
  available (that's the oEmbed video type Drupal ships).
- The contributed **Colorbox** module (`drupal/colorbox`) — this is a hard
  dependency and Composer pulls it in for you.
- Optionally, the **Token** module (`drupal/token`) if you want token replacement
  in the custom gallery-id and custom caption settings. Without it the module
  still works; the settings form just notes that tokens are unavailable.

There are no additional third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/colorbox_media_video -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in the required Colorbox module.

To add the optional Token module as well:

```bash
composer require drupal/token -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/colorbox_media_video -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en colorbox_media_video -y
```

Drupal enables `media` and `colorbox` as dependencies if they aren't already on.
(If you installed Token, enable it too: `drush en token -y`.)

There are **no submodules**. Once enabled, the **Colorbox Media Remote Video**
formatter is available to select on a Remote Video field — see
[How to use it](../index.md#how-to-use-it).
