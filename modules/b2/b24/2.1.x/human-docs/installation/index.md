# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Bitrix24** account and either a **webhook** or an **OAuth application** set up in
  Bitrix24 to authenticate the integration.
- For individual submodules, the module they integrate with — for example Drupal
  Commerce for `b24_commerce` or the Webform module for `b24_webform`.

## Install with Composer

From the project root:

```bash
composer require drupal/b24 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/b24 -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first — it holds the Bitrix24 connection:

```bash
drush en b24 -y
```

## Submodules — enable only what you need

The project ships five optional submodules. Enable individually with `drush en`:

| Submodule | Machine name | What it integrates |
|-----------|--------------|--------------------|
| **Commerce** | `b24_commerce` | Sends Drupal Commerce orders to Bitrix24. |
| **Contact** | `b24_contact` | Sends core Contact form submissions. |
| **User** | `b24_user` | Syncs Drupal user data. |
| **UTM** | `b24_utm` | Captures UTM tracking parameters alongside the data sent. |
| **Webform** | `b24_webform` | Sends Webform submissions. |

For example, to add the Webform integration:

```bash
drush en b24_webform -y
```

Each submodule needs the base `b24` module, which is already present once you have
installed it above. After enabling, configure the Bitrix24 credentials — see
[Configuration](../configuration/index.md).
