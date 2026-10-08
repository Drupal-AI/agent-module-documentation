<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto Retina — configuration & settings

## Install / enable
`drush en auto_retina`. Depends only on core `image`. No install hooks. Optional companions:
`image_style_quality` (quality basis), `imageapi_optimize` (optimize pipeline), `crop` (derivative flush).

## Config object: `auto_retina.settings`
Defaults from `config/install/auto_retina.settings.yml`; schema in `config/schema/auto_retina.schema.yml`.

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `suffix` | string | `@2x` | Space-separated list of retina suffixes, e.g. `@.75x @1.5x @2x @3x`. The numeric part is the magnification multiplier. |
| `quality_multiplier` | float | `1` | Multiplies the JPEG quality basis for magnified images only (0.05–1). `1` = no change. |
| `regex` | string | `(.+)(SUFFIX)\.(png\|jpg\|jpeg\|gif)$` | Detects a retina filename. The `SUFFIX` token is replaced with a `preg_quote`d alternation of the configured suffixes. Start/end delimiters optional (added as `/…/i` if missing). |
| `js` | boolean | `false` | When true, `auto_retina_preprocess_html()` attaches `drupalSettings.autoRetina` (suffix + regex) on every page. |
| `log` | boolean | `true` | When true, a low-quality retina generation writes a notice to the `auto_retina` logger. |

Note: the settings **form** (`src/Form/AutoRetinaAdminSettings.php`) saves `suffix`, `quality_multiplier`,
`regex` and `js`, but not `log` — toggle `log` via config import/drush if needed.

## Settings form
- Route `auto_retina.admin_settings` → `/admin/config/media/image-styles/auto-retina`, permission
  `administer image styles`. Secondary task tab "Auto Retina" under the Image styles collection
  (`auto_retina.links.task.yml`).
- `AutoRetinaAdminSettings` is a `ConfigFormBase`; `getEditableConfigNames()` = `['auto_retina.settings']`.
- The quality-multiplier help text links to the image toolkit settings and, if `image_style_quality` is
  not installed, suggests it.

## Service `auto_retina.core` (`Service\AutoRetina`)
Key methods you may call:
- `getSettings()` → `['suffix' => …, 'regex' => …]` (compiled regex).
- `isPathRetina($path)` / `parsePath($path)` — is a path a retina request, and its parts.
- `getMagnifications()` — configured multipliers as numbers.
- `getSuffixByMagnification($m)` / `getRetinaUri($uri, $m = 2)` — build a retina URI (throws
  `InvalidArgumentException` if the multiplier isn't a configured suffix).
- `prepareStyle(ImageStyleInterface $style, $retina_uri)` — stamps third-party settings
  (`suffix`, `multiplier`, `quality_multiplier`) onto the style and returns the non-retina source URI.

## Migration
`migrations/d7_auto_retina_settings.yml` maps Drupal 7 variables to `auto_retina.settings`.
