# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Layout Builder** (`layout_builder`), **Content Translation**
  (`content_translation`), and **Language** (`language`).
- **Layout Builder Asymmetric Translation** (`layout_builder_at`) — a contributed
  module that provides the per-translation layout storage this module seeds into.
  It is a hard dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/lb_translation_block_seed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in
`layout_builder_at` and any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lb_translation_block_seed -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lb_translation_block_seed -y
```

Enabling it also enables `layout_builder_at` and the core translation modules if
they are not already on.

## Set up translatable layouts

For seeding to have any effect, complete the standard Layout Builder translation
setup:

1. Enable **Layout Builder** on the content type whose layouts should be
   translatable.
2. Enable **Content Translation** and configure the content type for translation.
3. Mark the **Layout Builder field as translatable** so each translation stores
   its own layout (via `layout_builder_at`).
4. Grant the **Push Layout Builder block translations** permission to your
   translator roles under **People → Permissions**.

## Verify it worked

Create a translation of an existing Layout Builder page. The translated layout and
its inline blocks should be created automatically and be immediately editable from
the Layout Builder canvas — without you rebuilding the page by hand.
