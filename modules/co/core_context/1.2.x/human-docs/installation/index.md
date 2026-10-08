# Installation

## Requirements

Core Context is a developer‑facing plumbing module built on ctools. It needs:

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The **Chaos Tools** module (`drupal/ctools`, `^3.15 || ^4.1`), which supplies the
  context mapper Core Context builds on. Composer installs it automatically as a
  dependency.

There are no PHP library requirements. Two optional integrations extend what you can
do, but neither is required:

- **Layout Library** (`drupal/layout_library`) — pair per‑layout contexts with
  reusable layouts.
- **Page Manager** (`drupal/page_manager`, `>= 4.0-beta6`) — expose entity contexts
  to Page Manager variants.

## Install with Composer

From the project root:

```bash
composer require drupal/core_context -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in ctools and update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/core_context -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en core_context -y
```

Enabling it also turns on ctools if it is not already on. There is nothing to
configure — the module registers a `context` handler on every entity type and its
context provider services automatically. From here you attach and read contexts in
code or configuration, as shown in the [overview](../index.md#how-to-use-it).
