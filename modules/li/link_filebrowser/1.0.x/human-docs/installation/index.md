# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Link** field module (part of Drupal core) so you have link fields to
  attach the widget to.
- The module bundles the **jQuery File Browser** library it uses for the explorer
  UI; there are no separate Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/link_filebrowser -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/link_filebrowser -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_filebrowser -y
```

## Set permissions

This module provides a **View link file browser** permission. Grant it only to
trusted editor roles at **People → Permissions**
(`/admin/people/permissions`) — never to anonymous or untrusted users.

## Verify it worked

Add or edit a **Link** field, set its widget to **Link with File browser** on
**Manage form display**, and point it at a folder under `public://`. Then open a
content edit form: the link field should now show a **File browser** button that
opens a modal explorer onto that folder.
