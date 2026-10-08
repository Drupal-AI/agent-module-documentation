# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- No hard module dependency, but the module's reporting and summary features
  assume the **Webform** module (`drupal/webform`) is installed. The average and
  distribution blocks read their data from a configured Webform's submissions, and
  the module's `hook_webform_submission_*` hooks only fire when Webform is present.
  Install Webform to get the full experience.

## Install with Composer

From the project root:

```bash
composer require drupal/star_rating -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/star_rating -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

To use the Webform-backed reporting and summary blocks, also install Webform:

```bash
composer require drupal/webform -W
```

## Enable the module

```bash
drush en star_rating -y
```

## Verify it worked

After enabling, visit **Configuration → Content authoring → Star Rating**
(`/admin/config/content/star-rating`) — the settings form should load. Then place
the **Star Rating** input block on a node display via **Structure → Block layout**
and click a star; the vote saves over AJAX and a row is written to the module's
`star_rating` table (and to your configured Webform, if set).
