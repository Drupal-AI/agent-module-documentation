# Installation

## Requirements

Read More Extra Field (3.x) needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), part of a standard install.
- Two contrib modules, installed automatically by Composer as dependencies:
  - **Extra Field** (`drupal/extra_field`, `^2`)
  - **Extra Field Settings Provider** (`drupal/extra_field_plus`, `^3`)
- Optional: the **Token** module (`drupal/token`) if you want to use tokens in the
  link label, classes, or `title` attribute.

Both Extra Field modules must be enabled or the module's update hooks will fail —
`composer require` and `drush en` handle this for you.

## Install with Composer

From the project root:

```bash
composer require drupal/readmore_extrafield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Extra Field and
Extra Field Settings Provider and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/readmore_extrafield -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en readmore_extrafield -y
```

This also enables Extra Field and Extra Field Settings Provider if they are not
already on. To add token support:

```bash
drush en token -y
```

## Verify it worked

Go to a content type's **Manage display** (for example **Structure → Content
types → Article → Manage display**) and switch to the **Teaser** view mode. In the
**Extra fields** area you should see a **Read more** row you can drag into
position and configure with the settings gear. See
[Configuration](../configuration/index.md) for the field‑by‑field settings.
