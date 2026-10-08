<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Example styles, preview route, and hooks

## Shipped example image styles (`config/optional/`)

Three ready-made retinafied styles install **optionally** (only if their dependency, this module,
is present). Each is a single `image_scale` effect with `upscale: false` and `retinafy: true`:

| Config / style name | Label | width × height |
|---|---|---|
| `image.style.thumbnail_retina` | `Thumbnail (100×100 retinafied)` | 100 × 100 |
| `image.style.medium_retina` | `Medium (220×220 retinafied)` | 220 × 220 |
| `image.style.large_retina` | `Large (480×480 retinafied)` | 480 × 480 |

Each declares `dependencies.module: [retina_images]`, so uninstalling the module removes them. With
the default multiplier 2, e.g. `medium_retina` produces a ~440×440 derivative from the 220×220
setting. There is **no `config/schema/`** in the module; the `retinafy`/`multiplier` keys added to
effect `data` are therefore unschemed (core image-effect schema covers the rest).

## Preview route, permission, controller

- **Permission** (`retina_images.permissions.yml`): `retina images access preview page` —
  title "Access preview page". Grant to trusted admins/reviewers.
- **Route** (`retina_images.routing.yml`): `retina_images.image_style_preview`
  - path `admin/config/media/image-styles/retina_preview/{image_style}`
  - `_controller: \Drupal\retina_images\Controller\PreviewController::preview`
  - requirement `_permission: 'retina images access preview page'`
  - `{image_style}` is upcast to an existing `ImageStyle` config entity.
- **`PreviewController::preview(Request $request, ImageStyleInterface $image_style)`**
  (`src/Controller/PreviewController.php`):
  - reads `original_path` from `image.settings:preview_image` (the **site-configured** sample
    image — not a request/user path);
  - `$preview_file = $image_style->buildUri($original_path)`; creates the derivative with
    `createDerivative()` if it does not yet exist;
  - loads it via `image.factory`, calls `$image_style->transformDimensions()`, and returns a
    `#theme => 'image'` render array (URL carries a `?cache_bypass=<request time>` token) with a
    "Back" link to the style edit form.
  - Injected services (`create()`): `image.factory`, `logger.factory` (channel `image`),
    `config.factory` (`image.settings`), `file_url_generator`, `datetime.time`.

## `.module` hooks

- `hook_help` — the `help.page.retina_images` about text.
- `hook_image_effect_info_alter` — swaps the four effect classes (see
  [../plugins/image-effects.md](../plugins/image-effects.md)).
- `hook_theme` — registers the three effect-summary templates plus
  `retina_images_image_style_preview`.
- `hook_form_image_style_form_alter` — on the image-style **edit** form (not the add form), replaces
  the core `preview` element with a render of the `retina_images_image_style_preview` theme
  (`#weight -5`, so it sits above the effect list).
- `template_preprocess_retina_images_image_style_preview()` — builds original + derivative preview
  variables from `image.settings:preview_image`, sizing thumbnails to a 160×160 sample box, and
  points the "view actual size" link at the preview route above. Template:
  `templates/retina-images-image-style-preview.html.twig`.

## Operate it

1. `drush en retina_images -y`.
2. Optionally use the shipped `*_retina` styles, or retinafy your own style's effect.
3. To let a role open the in-admin preview, grant **Access preview page**
   (`/admin/people/permissions`).
4. Assign a retinafied style to an image field's formatter, or to a responsive image mapping.
