# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- Drupal core's **Block** module (`block`) and the **Datetime Range** module
  (`datetime_range`) — both ship with core and are enabled as dependencies.
- No third-party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/service_availability -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/service_availability -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en service_availability -y
```

Enabling the module **automatically creates two content types** — **Service** and
**Service Message** — along with their fields. Drupal enables Block and Datetime
Range (core) as dependencies if they are not already on.

## Set it up

There is no settings form. To get a working status display:

1. Create a **Service** node for each service you want to show, setting its
   current status.
2. Create a **Service Message** node for each scheduled disruption, referencing
   the relevant service and giving it a date/time range, description, and impact.
3. Place the **Service Availability** block (Structure → Block layout) on the
   pages where the status should appear.

## Verify it worked

After creating at least one published Service (and optionally a Service Message)
and placing the block, load a page where the block appears. You should see each
service rendered as a tab with its current status, and any current or upcoming
disruptions listed with their calculated duration. Because the block is
uncached, the status you see is always up to date.
