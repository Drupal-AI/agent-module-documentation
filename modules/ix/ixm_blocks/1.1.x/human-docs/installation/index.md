# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block Content** module (`block_content`) — the only dependency, and part
  of a standard Drupal install.
- **Recommended:** start from a fresh build of ImageX's **SWAT** distribution, or at
  least ensure you have the **image**, **video**, and **remote_video** media bundles
  installed if you use any components that need icons, images, or video.

## Install with Composer

From the project root:

```bash
composer require drupal/ixm_blocks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ixm_blocks -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the component submodules you need

The base `ixm_blocks` module is just a shell — the actual block types come from its
submodules, which you enable individually. For example, to add the hero component:

```bash
drush en ixm_blocks_hero -y
```

The available components are:

| Component | Submodule machine name |
|-----------|------------------------|
| Accordion | `ixm_blocks_accordion` |
| Cards | `ixm_blocks_cards` |
| Carousel | `ixm_blocks_carousel` |
| CTA Icons | `ixm_blocks_cta_icons` |
| Hero | `ixm_blocks_hero` |
| Modal | `ixm_blocks_modal` |
| Ping-Pong | `ixm_blocks_ping_pong` |
| Statistics | `ixm_blocks_statistics` |
| Tables | `ixm_blocks_table` |
| Tabs | `ixm_blocks_tabs` |
| Boilerplate (pattern for your own) | `ixm_blocks_boilerplate` |

Enabling a submodule imports that block type's field configuration and its default
template.

## Verify it worked

Go to **Structure → Block types** (`/admin/structure/block-content/types`). The
components you enabled should be listed as custom block types. Create one under
**Content → Blocks** (`/admin/content/block`) and place it via **Block layout** or
**Layout Builder** to confirm it renders.
