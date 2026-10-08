<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Recalculate batch form & route

## Route
`aspect_ratio.recalculate` (`aspect_ratio.routing.yml`):
- path: `/admin/config/media/aspect_ratio/recalculate`
- `_form: '\Drupal\aspect_ratio\Form\BatchCalculateAspectRatio'`
- `_title: 'Recalculate Aspect Ratio'`
- requirement: `_permission: 'administer media'`

An admin menu link (`aspect_ratio.links.menu.yml`, title "Calculate Aspect Ratios") places it under
Configuration ▸ Media (`system.admin_config_media`).

## Form (`src/Form/BatchCalculateAspectRatio.php`)
`BatchCalculateAspectRatio extends FormBase`, id `aspect_ratio.batch_calculate`.

- `getAllMediaIds()` (private static): `\Drupal::entityQuery('media')->condition('bundle', 'image')
  ->accessCheck(FALSE)->execute()` — returns all `image`-bundle media ids. (A `// TODO` notes it currently
  hard-codes the `image` bundle rather than discovering every bundle that has the field.)
- `buildForm()` shows a count ("There are @count media items that will be calculated.") and a single
  "Calculate all aspect ratios" submit button.
- `submitForm()` builds a `BatchBuilder`, adds one operation per media id
  (`aspect_ratio_calculate_and_save_by_id`), and `batch_set()`s it. Each operation loads the media,
  recomputes the ratio, and saves it (which re-triggers the presave hook).

## When to use
Run this after installing the module on a site with existing image media (the presave hook only fires on
future saves), or after a bulk file replacement/import, to backfill/refresh `field_aspect_ratio` for the
whole image library in one batch pass.
