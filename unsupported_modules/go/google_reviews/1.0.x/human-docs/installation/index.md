# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Google Places API key** from a Google Cloud project with the Places API enabled, and
  the **Place ID** of each business location whose reviews you want to show. You'll enter
  these on the settings form after enabling.
- Working **cron**, if you want reviews to refresh automatically (imports also run on demand).

There are no third‑party Composer packages or module dependencies. The slider's Swiper
JavaScript/CSS is loaded from a CDN, so there's no library to install by hand.

## Install with Composer

Note that the Composer project name (`google_reviews_slider`) differs from the module's
machine name (`google_reviews`). From the project root:

```bash
composer require drupal/google_reviews_slider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_reviews_slider -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**, `google_reviews`:

```bash
drush en google_reviews -y
```

Enabling the module installs the `review` content type and its fields, and adds the settings
form and the reviews block — but nothing is imported or displayed until you configure it.

## Next step

Head to [Configuration](../configuration/index.md) to add your API key and Place IDs and
import your first reviews.
