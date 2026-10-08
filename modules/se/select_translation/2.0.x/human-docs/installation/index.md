# Installation

## Requirements

Select Translation is lightweight and has no third-party library requirements.
It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Language** module (`language`) — enabled automatically as a
  dependency.
- Core's **Views** module (`views`) — enabled automatically as a dependency.

> **Note on the release:** at the time of documenting, the only 2.0.x release
> is `2.0.0-alpha5`, an alpha. Test it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/select_translation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/select_translation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en select_translation -y
```

Drupal turns on the `language` and `views` dependencies for you if they are not
already enabled.

There is no configuration screen. To start using it, edit a view of content and
add the **Select translation** filter as described in the
[overview](../index.md#how-to-use-it).
