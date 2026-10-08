# Installation

## Requirements

- **Drupal 11.3 or 12** (`core_version_requirement: ^11.3 || ^12`).
- Core's **CKEditor 5** (`ckeditor5`) and **Media Library** (`media_library`)
  modules.
- The **[Embedded Content](https://www.drupal.org/project/embedded_content)** module
  (`embedded_content`) — pulled in automatically by Composer. It provides the button
  the Alerts, Process List, Summary Box, and Accordion components appear under.
- PHP's **DOM extension** (`ext-dom`), used by the table filters to add USWDS
  attributes. It is standard on almost all PHP installs.

## Install with Composer

From the project root:

```bash
composer require drupal/uswds_ckeditor_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Embedded Content and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/uswds_ckeditor_integration -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en uswds_ckeditor_integration -y
```

## The embed submodule (optional)

The module ships one submodule, **USWDS CKEditor Integration Embed**
(`uswds_ckeditor_integration_embed`), which is config-only glue: it provides a
ready-made **`uswds_paragraphs`** text format that wires the USWDS components together
with paragraph embeds. Enable it if you want a preconfigured format to start from:

```bash
drush en uswds_ckeditor_integration_embed -y
```

Once enabled, continue to [Configuration](../configuration/index.md) to turn the
plugins on for a text format and set up the grid.
