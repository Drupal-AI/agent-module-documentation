# Installation

## Requirements

syncloud needs:

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Contact** module (`contact`), which Drupal enables automatically as a
  dependency.
- An external **MQTT broker** to publish to (and the "biz-panel"/Telegram bridge
  on the other side), plus the connection details for it.

To forward Commerce orders or webform submissions you will also need the relevant
Drupal Commerce and/or Webform modules in place, since those are the events
syncloud maps.

## Install with Composer

From the project root:

```bash
composer require drupal/syncloud -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Contact
dependency and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/syncloud -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en syncloud -y
```

## Verify it worked

After enabling, go to **`admin/structure/syn`** (you will need the `administer
syn` permission). You should reach the syncloud settings form, ready for you to
enter the MQTT broker details and create your `syn` event mappings — see
[Configuration](../configuration/index.md). Before exposing the site, also review
the note there about restricting the anonymous `/syncloud/queue` route.
