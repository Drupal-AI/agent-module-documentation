# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Smart Date** module (`smart_date`).
- Core's **Menu UI**, **Node** and **User** modules.
- **Add content by bundle** (`add_content_by_bundle`).

Requiring the module with Composer pulls in everything it needs.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_date_starter_kit -W
```

The Composer package name (`drupal/smart_date_starter_kit`) matches the module's
machine name (`smart_date_starter_kit`). The `-W` (`--with-all-dependencies`) flag
lets Composer download and install all the necessary modules (including Smart Date)
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/smart_date_starter_kit -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_date_starter_kit -y
```

This creates the **Event** content type and the related **Events** view with its
two displays (upcoming and past), linked together by tab navigation.

## A choice to make before adding content

The Event content type's **When** field allows unlimited values by default (so it
can support recurring dates). If you want each event to have only a single date,
change that at
`/admin/structure/types/manage/event/fields/node.event.field_when/storage`
**before** adding any events.

## Uninstalling

Because this is purely a configuration kit, once it has set things up you can
safely uninstall it and keep the Event content type and Events view it created.
