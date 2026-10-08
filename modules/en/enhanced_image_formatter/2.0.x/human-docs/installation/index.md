# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **SVG Image** module (`drupal/svg_image`) — the enhanced formatter extends
  it, inheriting SVG rendering.
- The **Token** module (`drupal/token`) — provides the tokens used in ALT/TITLE
  text and the token-tree helper.

> **Heads up:** this project is minimally maintained (maintenance fixes only) and
> is not covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/enhanced_image_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the SVG Image
and Token dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/enhanced_image_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en enhanced_image_formatter -y
```

This also enables SVG Image and Token if they are not already on.

## Verify it worked

1. Confirm the module is enabled on the **Extend** page (`/admin/modules`).
2. Open the **Manage display** settings of any image field and check that the
   image formatter now shows the **Tokenized ALT and TITLE** options and the
   extended **Image link** targets.
3. Because the module takes over the core `image` formatter **site-wide**, review
   your existing image displays to confirm they still render as you expect.
