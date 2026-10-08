# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.1** or newer.
- The **GraphQL** module (`graphql`) with at least one GraphQL server
  configured — this is the only module dependency, and there is nothing to
  export without a server.

There are no additional third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/graphql_export -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If the GraphQL module is not already present, Composer
will pull it in.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/graphql_export -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en graphql_export -y
```

Enabling GraphQL Export also ensures the GraphQL module is on, since it is a
dependency.

## Verify it worked

Go to **Configuration → Web services → GraphQL Servers**, open one of your
servers, and look for the **Export** tab
(`/admin/config/graphql/servers/manage/{server_machine_id}/export`). You should
be able to view and download the schema there. To confirm the Drush command is
registered, run `drush list | grep graphql-export`.
