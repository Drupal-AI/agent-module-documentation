# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Image** module (`image`) — Drupal enables it as a dependency.
- *(Optional)* The **Magnific Popup** JavaScript library for the pop‑up image
  preview. Download it from
  [github.com/dimsemenov/Magnific-Popup](https://github.com/dimsemenov/Magnific-Popup)
  and place it in the site's `/libraries` folder.

## Install with Composer

From the project root:

```bash
composer require drupal/fiu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fiu -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fiu -y
```

## Submodules

The project also ships a companion UI submodule, **`fiu_ui`**, which adds
additional interface pieces. Enable it only if you need it:

```bash
drush en fiu_ui -y
```

## Verify it worked

Go to a content type with an image field and open **Manage form display**
(**Structure → Content types → *(your type)* → Manage form display**). The image
field's **Widget** drop‑down should now offer the Field Image Upload ("Fine image
upload") option. Select it, save, and add a piece of content — the image field
should show the enhanced uploader with preview and drag‑and‑drop.
