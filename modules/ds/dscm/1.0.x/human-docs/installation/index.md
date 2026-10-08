# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- A beacon link from the external service at
  [didsomeoneclone.me](https://didsomeoneclone.me) (generated during
  configuration, not required to install).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dscm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Note the project (and Composer) name is `dscm`, while the
module's internal machine name is `didsomeonecloneme`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dscm -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**, `didsomeonecloneme`:

```bash
drush en didsomeonecloneme -y
```

## Verify it worked

Go to **Configuration → System → Did Someone Clone Me**
(`/admin/config/system/did-someone-clone-me`) and confirm the settings form
loads. Then follow [Configuration](../configuration/index.md) to add your beacon
link. Once configured, view your site's page source and confirm the beacon markup
is present.
