# Installation

## Requirements

Tarte au citron - ClickDimensions needs:

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Tarte au citron** module (`tarte_au_citron`) — the consent manager this
  add-on plugs into. It provides all the storage, the consent banner, and the
  services screen where you configure ClickDimensions.

Composer resolves the Tarte au citron dependency for you. There are no third-party
Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tarte_au_citron_clickdimensions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Tarte au citron as
needed. (The Composer package name, `drupal/tarte_au_citron_clickdimensions`,
matches the module's machine name, `tarte_au_citron_clickdimensions`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tarte_au_citron_clickdimensions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tarte_au_citron_clickdimensions -y
```

Enabling the module makes ClickDimensions available as a service inside Tarte au
citron, but you still need to enable and configure it there — see
[Configuration](../configuration/index.md).

## Verify it worked

Go to **Configuration → Tarte au citron → Services**
(`/admin/config/tarte_au_citron/services`) and confirm that **ClickDimensions**
now appears in the list of available services.
