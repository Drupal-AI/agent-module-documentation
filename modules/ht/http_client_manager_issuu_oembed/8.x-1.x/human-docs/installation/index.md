# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- The **HTTP Client Manager** module (`http_client_manager`) — the base this client
  is built on. Composer installs it automatically as a dependency.
- **Recommended:** the **ECA** module, to use the shipped ECA activity template. For
  ECA to access the module's temporary key-value store, you currently also need the
  patch from
  [ECA issue #3330979](https://www.drupal.org/project/eca/issues/3330979) (until it
  is merged into a stable ECA release).

## Install with Composer

From the project root:

```bash
composer require drupal/http_client_manager_issuu_oembed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including HTTP Client Manager.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/http_client_manager_issuu_oembed -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en http_client_manager_issuu_oembed -y
```

HTTP Client Manager is enabled automatically as a dependency. If you plan to use
the ECA integration, also enable ECA:

```bash
drush en eca -y
```

## Verify it worked

Confirm the module (and `http_client_manager`) show as enabled on **Extend**
(`/admin/modules`) or via `drush pm:list --status=enabled`. To confirm the
integration works end to end, build an ECA model that uses the **Issuu Oembed
Services API** activity against a real Issuu document URL and check that it returns
the thumbnail URL and description.
