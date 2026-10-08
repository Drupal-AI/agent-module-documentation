# Configuring the SVG default-image formatter

This submodule contributes one field formatter, **"Image or default image (SVG compatible)"**
(id `config_default_svg_image`), for `image` fields. It behaves exactly like the parent
`config_default_image` formatter but renders through the **SVG Image** base formatter, so the
config-deployable default `path` may point at an `.svg` file (or a raster) and SVG output is handled
correctly.

## Setup (Manage Display)

1. Enable `config_default_svg_image` (pulls in `config_default_image` + `svg_image`).
2. Commit the fallback asset (e.g. `modules/custom/my_module/img/placeholder.svg`) to a git-tracked
   directory.
3. On the entity's **Manage Display**, set the image field's **Format** to
   **"Image or default image (SVG compatible)"**.
4. Open the settings gear, fill in the **Default image** details (`path` is required), leave the
   field's own field-level default image *unset*, and save.
5. `drush cex` and commit both the display config and the SVG/asset.

## Settings

Identical to the parent formatter: the same `settings.default_image` mapping
(`path`, `use_image_style`, `alt`, `title`, `width`, `height`) plus the inherited image-formatter
settings (`image_style`, `image_link`) and SVG Image's own base settings. The full key table, the
`viewElements()` render flow, and the `use_image_style` + schemeless-path copy-to-`public://`
mechanic are documented once in the parent doc:
[../../../../../2.0.x/agent/configure/formatter.md](../../../../../2.0.x/agent/configure/formatter.md).

## What this submodule changes vs the parent

- Base class: `ConfigDefaultSvgImageFormatter extends Drupal\svg_image\...\SvgImageFormatter`
  (the parent's `ConfigDefaultImageFormatter` extends core `Drupal\image\...\ImageFormatter`).
- The runtime fallback `File` built from `path` is passed to the SVG-aware base formatter, so `.svg`
  defaults display via SVG Image's handling rather than a plain core `<img>`.
- Nothing else: `defaultSettings()`, `settingsForm()`, `settingsSummary()` and `viewElements()` all
  come verbatim from `ConfigDefaultImageFormatterTrait`.

## Config schema

The submodule ships no `config/schema`. The parent defines only
`field.formatter.settings.config_default_image` (via the reusable `config_default_image` data type
in `config_default_image.data_types.schema.yml`); there is no
`field.formatter.settings.config_default_svg_image` mapping, so this formatter's `default_image`
settings are effectively schemaless — the same structure, just not wired to this formatter id.
