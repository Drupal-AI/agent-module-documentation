# Installation

## Requirements

SVG Sprite is self‑contained:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No other module dependencies, and no third‑party PHP or JavaScript libraries.

You will, however, need an **SVG sprite file** to point the module at — a single
`.svg` file that bundles many `<symbol id="…">` entries (the kind produced by icon
build tools). It can live at a full URL, a path relative to the web root, or
inside a theme.

## Install with Composer

From the project root:

```bash
composer require drupal/svg_sprite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/svg_sprite -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en svg_sprite -y
```

## Optional: CKEditor 5 submodule

If you want editors to insert sprites into rich‑text (CKEditor 5) fields, also
enable the submodule, which adds an insert button to the editor toolbar:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **SVG Sprite CKEditor 5** | `svg_sprite_ckeditor5` | A CKEditor 5 button for inserting sprites into WYSIWYG content. |

```bash
drush en svg_sprite_ckeditor5 -y
```

The submodule requires the base SVG Sprite module, which is already present once
you have installed it above. After enabling it, add the sprite button to a text
format's CKEditor 5 toolbar under **Configuration → Content authoring → Text
formats and editors**.

## Next step

Before the field, Twig function, or token can render anything, point the module at
a sprite file — see [Configuration](../configuration/index.md).
