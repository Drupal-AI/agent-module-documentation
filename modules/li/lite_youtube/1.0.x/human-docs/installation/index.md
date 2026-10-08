# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9||^9||^10||^11`).
- The contributed **YouTube** module (`drupal/youtube`), which provides the
  YouTube video field this formatter renders. Composer pulls it in automatically
  with the command below.
- The `lite-youtube` front‑end library is bundled with the module, so there's
  nothing separate to download.

There are no PHP library requirements.

> **A note on security coverage:** this project is **not** currently covered by
> the Drupal security advisory policy. Weigh that when deciding where to use it.

## Install with Composer

From the project root:

```bash
composer require drupal/lite_youtube -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
— including the required YouTube module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lite_youtube -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lite_youtube -y
```

This enables the YouTube module as a dependency if it isn't already on.

## Verify it worked

Go to the **Manage display** screen of a content type that has a YouTube video
field (**Structure → Content types → *(bundle)* → Manage display**). The field's
**Format** dropdown should now offer **Lite Youtube**. Select it, save, and view a
piece of content: you should see a thumbnail with a play button, and the full
YouTube player should load only after you click it.
