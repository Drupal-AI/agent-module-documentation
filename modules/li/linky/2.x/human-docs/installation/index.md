# Installation

## Requirements

- **Drupal 10.1 or newer** (`core_version_requirement: >=10.1`) — the 2.x branch
  includes the revision UI, which needs 10.1.
- **PHP 8.1** or newer.
- The **Dynamic Entity Reference** contrib module
  (`dynamic_entity_reference`) — used for the DER widget/field.
- Core's **Link** and **User** modules — enabled automatically as dependencies.

> **Upgrading from 1.x?** If you run a 1.x version older than alpha10, update to
> the latest 1.x and run database updates first (to make Linky entities
> revisionable), *then* upgrade to 2.x. Skipping that can leave the entity in a
> bad state.

## Install with Composer

From the project root:

```bash
composer require drupal/linky -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed — including Dynamic Entity Reference.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/linky -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en linky -y
```

Drupal enables **Dynamic Entity Reference**, **Link**, and **User** automatically
as dependencies.

## Grant permissions

Go to **People → Permissions** and grant Linky's administration permissions to
the roles that should be able to create and manage link (Managed Link) entities.

## Verify it worked

After enabling, you should be able to create a **Managed Link** entity (with a
title and URL) from Linky's management area. Create a test link, reference it in
content, and confirm the reference resolves to the correct URL on output — then
change the link's URL and check every reference updates.
