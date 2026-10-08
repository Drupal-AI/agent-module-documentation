# Installation

## Requirements

Responsive Image formatter link to image style needs:

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- Core's **Image** module (`image`) and **Responsive Image** module
  (`responsive_image`), both enabled — Drupal enables them automatically as
  dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/responsive_image_formatter_link_to_image_style -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine —
> `ddev composer require drupal/responsive_image_formatter_link_to_image_style -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en responsive_image_formatter_link_to_image_style -y
```

## Verify it worked

Make sure you have at least one **responsive image style** (at **Configuration →
Media → Responsive image styles**) and one ordinary **image style** to link to.
Then edit an image field's **Manage display** — the **Format** dropdown should
list **Responsive Image link to image style**. Select it, choose your styles,
save, and view the content: the image should render responsively and be wrapped
in a link to the larger derivative.
