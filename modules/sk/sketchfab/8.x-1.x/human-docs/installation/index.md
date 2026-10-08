# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Field** and **Field UI** modules (part of standard Drupal) if you want
  to add the field through the admin interface.

There are no dependent contrib modules and no additional PHP or third-party
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sketchfab -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sketchfab -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sketchfab -y
```

That is all the setup the module itself needs — there is no configuration form.

## Verify it worked

Add an **Embed Sketchfab** field to a content type (see *How to use it* in the
[main guide](../index.md)), paste a Sketchfab model URL into a piece of content,
and view it. You should see the model rendered as an interactive embedded viewer.
