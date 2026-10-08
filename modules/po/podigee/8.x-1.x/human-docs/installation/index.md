# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **File** (`file`) module — Drupal enables it automatically as a
  dependency.
- Because the player loads from the external **Podigee** service, the site (and
  visitors' browsers) must be able to reach Podigee's assets over the network.

Note this is an alpha release (version 8.x-1.0-alpha4) with known limitations
(mp3 only, one episode per player).

## Install with Composer

Installing with Composer is recommended. From the project root:

```bash
composer require drupal/podigee -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Composer cannot resolve the stable version, request the
alpha explicitly, as the project suggests:

```bash
composer require drupal/podigee:^1@alpha -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/podigee -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en podigee -y
```

## Verify it worked

Go to a bundle's **Manage display** (**Structure → … → Manage display**) for an
entity with an audio file field. The **Podigee** formatter should be selectable for
that field. Set it, save, and view an entity with an mp3 to confirm the Podigee
player renders and plays.
