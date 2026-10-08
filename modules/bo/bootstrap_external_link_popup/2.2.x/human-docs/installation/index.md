# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **External Link Pop-up** module (`external_link_popup`) — this is a hard
  dependency and does the actual work of detecting outbound links and showing the
  warning. This module only restyles it.
- A **Bootstrap-based theme**, so the framework's modal component is available.
  On a non-Bootstrap theme the modal markup has nothing to style it.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_external_link_popup -W
```

Composer will pull in the External Link Pop-up parent module as a dependency. The
`-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bootstrap_external_link_popup -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bootstrap_external_link_popup -y
```

Enabling this module also enables `external_link_popup` if it is not already on.
Once both are enabled, configure your outbound-link warnings in the parent
module — this module then renders those warnings as Bootstrap modals with no
further setup.
