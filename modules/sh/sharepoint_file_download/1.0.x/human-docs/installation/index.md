# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Sharepoint API** module (`sharepoint_api`) — this is a required dependency
  that provides the SharePoint connection and credentials used to fetch files.
  Composer pulls it in when you install with `-W`.

You will also need the SharePoint connection configured through Sharepoint API,
with its app credentials backed by an environment variable.

## Install with Composer

From the project root:

```bash
composer require drupal/sharepoint_file_download -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the required Sharepoint API module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sharepoint_file_download -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sharepoint_file_download -y
```

This also enables Sharepoint API if it is not already on.

## Grant the download permission

Downloading is controlled by the **Download sharepoint files**
(`download sharepoint files`) permission. Go to **People → Permissions**
(`/admin/people/permissions`), grant it to the roles that should be able to download
SharePoint documents, and save. Keep it restricted to trusted roles, since it lets
those users retrieve files through the site's SharePoint connection.
