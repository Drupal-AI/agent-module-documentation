# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The contributed **Key** module (`key`) — DocRaptor stores its API key as a Key
  entity. Composer pulls Key in for you as a dependency (see below).
- A **DocRaptor account and API key** from
  [docraptor.com](https://docraptor.com/) (DocRaptor offers test keys for
  development).

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/docraptor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the required **Key**
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/docraptor -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en docraptor -y
```

This also enables the **Key** module if it is not already on. If you prefer to
enable Key explicitly first:

```bash
drush en key -y
drush en docraptor -y
```

## Verify it worked

After enabling, head to [Configuration](../configuration/index.md) to store your
DocRaptor API key as a Key entity. Once the key is in place, the module can
authenticate to DocRaptor and generate PDFs from HTML.
