# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** (`field`) module — part of Drupal core.

There are no third‑party PHP libraries to install. The optional **Inline SVG
Media** submodule integrates with Drupal's core Media system.

> **Note on security coverage.** This project is **not** covered by Drupal's
> security advisory policy. Combined with the fact that inline SVG is active markup
> (see the [main guide](../index.md)), be deliberate about which roles you let
> enter SVG.

## Install with Composer

From the project root:

```bash
composer require drupal/inline_svg -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inline_svg -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inline_svg -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Inline SVG Media** | `inline_svg_media` | Integrates Inline SVG with Drupal's Media system so you can store SVG code as reusable **media items**. It adds a media source plugin for raw SVG code, a custom media‑library add form for entering SVG, and configurable display settings for the resulting media entities. |

To use SVG code as reusable media, enable **both** the main module and the
submodule:

```bash
drush en inline_svg_media -y
```

## Verify it worked

Go to **Structure → Content types → *(a type)* → Manage fields → Add field** and
confirm the **SVG Code** field type is available. Add it, then on **Manage
display** pick the SVG formatter and check its per‑display style overrides. See
[How to use it](../index.md#how-to-use-it) for the full walkthrough — and remember
to grant the field only to trusted editors.
