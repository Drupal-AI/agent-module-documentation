# Installation

## Requirements

This module only makes sense on a site that is already set up as an **Acquia
Content Hub subscriber**. It needs:

- **Drupal 8.8, 9, 10 or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **Acquia Content Hub** (`acquia_contenthub`) — the main Content Hub integration,
  configured and connected to your Content Hub subscription.
- **Content Hub Unsubscribe** (`acquia_contenthub_unsubscribe`) — the submodule
  that provides the underlying desynchronise flag this module surfaces on the form.

Drupal enables these as dependencies. You still need a working, configured Content
Hub connection for the feature to do anything meaningful.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_contenthub_unsubscribe_checkbox -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Content Hub
dependencies and update shared packages.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/acquia_contenthub_unsubscribe_checkbox -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_contenthub_unsubscribe_checkbox -y
```

This also enables `acquia_contenthub` and `acquia_contenthub_unsubscribe` if they
are not already on.

## Verify it worked

Open the edit form of a syndicated entity on your subscriber site. You should see a
**Check to desynchronise content** checkbox. There is nothing to configure — the
checkbox is the whole feature.
