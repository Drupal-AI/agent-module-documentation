<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Background Slider - agent index

**Background Slider** (project `background_sliders`, module `background_slider`) renders a full-background image/video slideshow via a block. Version **1.0.2** (`1.0.x`). Core `^9.4 || ^10`.

## Key files
- `src/Form/SliderForm.php` - settings + per-slide managed-file uploads; saves `background_slider.setting`.
- `src/Plugin/Block/*` - slider block; `templates/block--slider-block.html.twig`.

## Security note
Route `background_slider.settings` (`/admin/config/system/settings`) requires only `_role: 'authenticated'` - any logged-in user can edit slider config and upload image/video files. See campaign report (broken-access-control class).