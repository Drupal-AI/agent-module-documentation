# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Sharepoint file download** module (`sharepoint_file_download`) — this is a
  required dependency, and it in turn requires the Sharepoint API module. Composer
  pulls the chain in when you install with `-W`.
- Core's **Filter** module (part of Drupal core) since this module registers a text
  filter.

You will also need the SharePoint connection and credentials configured through the
Sharepoint API module, backed by an environment variable.

## Install with Composer

From the project root:

```bash
composer require drupal/sharepoint_share_link_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the required Sharepoint file download module and
its own Sharepoint API dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sharepoint_share_link_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sharepoint_share_link_filter -y
```

This also enables its dependencies if they are not already on.

## Turn the filter on for your text formats

The module does its work through a text filter, so it only takes effect on formats
where you enable it. Go to **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`), edit the format(s) you want, tick this
module's SharePoint share link filter under **Enabled filters**, and save.
