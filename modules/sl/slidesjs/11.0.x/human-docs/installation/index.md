# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** (`block`), **Image** (`image`), and **Media Library**
  (`media_library`) modules — Drupal enables these automatically as dependencies
  when you turn on SlidesJS.
- **No external JavaScript library** — the carousel uses pure JavaScript that
  ships with the module, so there is nothing extra to download.

Note the module is **not covered by the security advisory policy**, so apply
your own judgement before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/slidesjs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/slidesjs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

The Composer package is `drupal/slidesjs`, but the **machine name you enable is
`slidesjs_slider`**:

```bash
drush en slidesjs_slider -y
```

## Verify it worked

Go to **Structure → Block layout** and place a SlidesJS slider block in a
region. If you can open the block's configuration form, upload images, and add
slides, the module is working. See the main guide's "How to use it" section for
the full walkthrough.
