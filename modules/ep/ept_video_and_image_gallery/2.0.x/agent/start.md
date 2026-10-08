<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EPT: Video and Image Gallery (ept_video_and_image_gallery) — agent index

Gallery paragraph type combining **images and video**, with **GLightbox**.
Version **2.0.0**. Core `^10.1 || ^11 || ^12`.
Depends on `media`, `ept_core`, `glightbox`, `glightbox_media_video`, `paragraphs`.

**Documented from source — broken against `ept_core` 2.0.0, verified:**

```
ArgumentCountError: Too few arguments to …EptSettingsDefaultWidget::__construct(),
5 passed in ept_video_and_image_gallery/src/Plugin/Field/FieldWidget/EptSettingsVideoAndImageGalleryWidget.php:49,
exactly 7 expected
```

**Second module in the family with the identical defect** (`ept_cta` 2.0.1 in wave 83). Pattern:
`ept_core`'s widget base gained `module_handler` and `entity_type_manager`; component modules that
**override the constructor** to inject their own services were not updated. Components that do
*not* override it (`ept_timeline`, `ept_basic_button`) inherit correctly and work.

**Concrete rule for the family:** a component overriding `EptSettingsDefaultWidget::__construct()`
is suspect against `ept_core` 2.0.0 — grep for `parent::__construct(` with five arguments. None of
these modules constrains `ept_core`'s version, so pin them together.

Enabling it here fataled **mid-install**, leaving unrelated modules from the same batch
half-installed.