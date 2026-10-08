# Installation

## Requirements

- **Drupal 10.2, 11 or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- Module dependencies, all resolved for you by Composer/Drush:
  - Core **Comment** (`comment`), **Field** (`field`), **Node** (`node`),
    **RDF** (`rdf`) and **Text** (`text`).
  - **Drutopia Core** (`drutopia_core`) — the shared base feature.
- The Composer package also requires **`drupal/config_actions`** as part of the
  distribution's config-management workflow.

There are no PHP library requirements. It is normally installed as part of a full
Drutopia site rather than in isolation.

## Install with Composer

From the project root:

```bash
composer require drupal/drutopia_comment -W
```

The `-W` (`--with-all-dependencies`) flag is important here — it lets Composer
pull in Drutopia Core and the rest of the dependency stack.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drutopia_comment -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drutopia_comment -y
```

On a Drutopia site this module is usually enabled automatically by the install
profile. Enabling it installs the bundled comment configuration (comment type,
fields and displays) and its dependencies.

## Verify it worked

- Go to **Structure → Comment types** (`/admin/structure/comment`) and confirm
  the shipped comment configuration is present.
- Visit **People → Permissions** (`/admin/people/permissions`) and confirm the
  core Comment permissions are available to assign to roles.
- Post a test comment on a piece of content that has commenting enabled and
  confirm it appears under **Content → Comments** (`/admin/content/comment`).
