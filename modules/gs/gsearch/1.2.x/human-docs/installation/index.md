# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`).
- Core's **Field** module (enabled on most sites already).
- The **Select2** module, version `^2` (`drupal/select2`) — it powers the
  searchable address dropdown.
- The `thecodingmachine/safe` PHP library, version `^2`, and the PHP `json`
  extension. Composer pulls the library in for you.
- A **Dataforsyningen account and API token** — free to create at
  [dataforsyningen.dk](https://dataforsyningen.dk). You will need this before the
  field will return suggestions (see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/gsearch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Select2 and `thecodingmachine/safe`
automatically.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gsearch -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gsearch -y
```

Drupal will enable Select2 and Field as dependencies at the same time.

## Verify it worked

Log in as an administrator and go to **Configuration → GSearch → Configuration**
(`/admin/config/gsearch/config`). If the settings form loads, the module is
installed. Once you have entered a valid Dataforsyningen token there, add a GSearch
address field to a content type and confirm that typing a Danish street name
returns live suggestions.
