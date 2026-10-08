# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The **Display Suite** module (`ds`) — this is a hard dependency, since the module
  works by adding a DS field. Composer installs it alongside this module.
- Core's Contact module's **personal contact form** feature, which is what the link
  points to.

There are no third-party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/contact_link -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the Display Suite dependency and
updates any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/contact_link -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contact_link -y
```

Drupal enables Display Suite too if it isn't already on.

## Verify it worked

Go to the user entity's **Manage display** (**Configuration → People → Account
settings → Manage display**), enable a Display Suite layout, and confirm the
**contact link** field is available to place into a region. Placed on a profile, it
should render a link to that user's personal contact form when access rules allow.
