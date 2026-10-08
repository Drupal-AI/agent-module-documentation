<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: warm image-style derivatives

The module registers one Drush command (via `drush.services.yml` →
`ImageStylesGeneratorCommands`).

## Command

```
drush image:derive:multiple
```

Aliases: `idm`, `image_derivatives:generate`.

Generates image-style derivatives for **every published image file** on the site
(`file` entities where `status = 1` and `filemime LIKE 'image%'`), for the selected image
styles. Prints "Found N image styles and M images. N*M derivatives to generate.", shows a
progress bar, and finishes with "All derivative images have been generated."

## Options

| Option | Meaning |
|---|---|
| `--image-styles=large,thumbnail` | Comma-separated **image style IDs** to warm. Omit to warm **all** image styles. |
| `--skip-existing` | Skip any file/style pair whose derivative file already exists on disk (idempotent, faster re-runs). Reports how many were skipped. |
| `--image_styles=` | **Deprecated** underscore form of `--image-styles`; logs a warning. |
| `--skip_existing` | **Deprecated** underscore form of `--skip-existing`; logs a warning. |

Without `--skip-existing` the command regenerates every derivative unconditionally
(overwriting existing files).

## Examples

```bash
# Warm all styles for all images:
drush image:derive:multiple

# Warm all styles but skip derivatives already built (idempotent):
drush image:derive:multiple --skip-existing

# Warm only two specific styles:
drush image:derive:multiple --image-styles=large,thumbnail

# Short alias:
drush idm --skip-existing
```

## Notes

- Style IDs are the machine names of `image_style` config entities
  (`drush config:get image.style.<id>` or `drush ev '...loadMultiple()'`).
- The command has **no argument** for limiting to specific files; it always scans every
  published image file. Filtering is only by style.
- The README's `drush image_derivatives:generate` still works (it is an alias), but the
  canonical command name is `image:derive:multiple`.
