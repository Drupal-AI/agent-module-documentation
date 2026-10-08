# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** module (`field`) and **File** module (`file`) — enabled automatically
  as dependencies. The formatter is added to core's File field, so Field must be enabled.
- **Public file storage and public internet reachability.** Microsoft's viewer fetches
  the file from your site, so files shown this way must live on the public filesystem and
  the site must be reachable from the internet. This formatter will not work on a local
  development environment or behind a firewall.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/md_viewer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/md_viewer -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en md_viewer -y
```

## Verify it worked

Go to **Structure → Content types → *(a type with a File field)* → Manage display**. In
the format drop‑down for the File field you should now see **Embedded Microsoft Document
Viewer Formatter**. Select it, save, and view a node with a **public** document attached —
it should render embedded inline. If it stays blank, the most common cause is that the file
is not publicly reachable from the internet (see Requirements). Setting up the field and
formatter is covered in "How to use it" in the [overview](../index.md).
