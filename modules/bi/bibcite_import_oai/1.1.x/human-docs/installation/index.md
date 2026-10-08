# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Bibcite** module (`bibcite`) — Composer pulls it in for you if it is not
  already present. Imported records become Bibcite Reference entities.
- Outbound network access from the server so cURL can reach your OAI-PMH
  repository endpoints. No API key or credentials are required for public OAI
  endpoints.

## Install with Composer

From the project root:

```bash
composer require drupal/bibcite_import_oai -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Bibcite
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bibcite_import_oai -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bibcite_import_oai -y
```

Drupal enables Bibcite automatically as a dependency.

## Grant the import permission

The module defines an OAI import permission. Go to **People → Permissions**
(`/admin/people/permissions`) and grant it to the roles that should be able to
configure and run imports.

> **Heads up:** on some releases the routing references this permission by its
> title rather than its machine name (`import from oai`), which can cause the
> config/import pages to deny access even after you grant it. If the pages are
> inaccessible, this known issue is the likely cause.

Once enabled and permitted, continue to
[Configuration](../configuration/index.md) to add repository URLs and run your
first import.
