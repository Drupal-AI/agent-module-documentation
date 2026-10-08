# Installation

## Requirements

Style Options — Media Reference builds on top of two other modules:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Style Options** module (`style_options`) — the framework this plugin
  extends.
- Core's **Media** module (`media`) — provides the media entities you reference.

Both are enabled automatically as dependencies when you turn this module on. The
**Media Library Form Element** is an *optional* extra — if it is present you get
its nicer media picker, and if it is not, the module falls back to autocomplete
with no configuration change. There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/style_options_media_reference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Style Options and
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/style_options_media_reference -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en style_options_media_reference -y
```

Drupal enables Style Options and Media at the same time if they are not already on.

## Verify it worked

Once enabled, the `media_reference` style option type is available to reference
from your Style Options YAML definitions. Add it to a component or layout option
and confirm a media picker appears on that component's style form.
