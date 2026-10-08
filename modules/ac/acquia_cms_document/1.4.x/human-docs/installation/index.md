# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core **Media** (`media`) and **Media Library** (`media_library`).
- **Acquia CMS Common** (`acquia_cms_common`) — the shared Acquia CMS layer.
- **Field Group** (`field_group`) — groups fields on the document form.

Enabling Document pulls in the common layer and its dependencies, so expect the
broader Acquia CMS set to come along with it.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_cms_document -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in
`acquia_cms_common`, `field_group`, and the other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/acquia_cms_document -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_cms_document -y
```

Drush enables the dependencies automatically. Once it finishes, the **Document**
media type is available under **Content → Media → Add media**. There is no
required configuration.
