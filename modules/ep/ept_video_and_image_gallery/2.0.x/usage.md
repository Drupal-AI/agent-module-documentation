<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EPT Video and Image Gallery adds a gallery paragraph type combining images and video, opening in a GLightbox lightbox.

---

Mixed galleries are common and awkward: a project page wants photographs and a video clip in one grid, and most gallery components handle one or the other. This one takes both, using `glightbox` for the lightbox and `glightbox_media_video` for the video handling, and places them as an EPT paragraph alongside the rest of that family's components.

**This release cannot be used with `ept_core` 2.0.0, and it was verified.** Its widget calls the parent constructor with the old five-argument signature while `ept_core` 2.0.0's `EptSettingsDefaultWidget::__construct()` requires seven:

```
ArgumentCountError: Too few arguments to function
Drupal\ept_core\Plugin\Field\FieldWidget\EptSettingsDefaultWidget::__construct(),
5 passed in ept_video_and_image_gallery/src/Plugin/Field/FieldWidget/EptSettingsVideoAndImageGalleryWidget.php
on line 49 and exactly 7 expected
```

**This is the second module in the EPT family found with the identical defect** — `ept_cta` 2.0.1 failed the same way in the previous wave. The pattern is now clear: `ept_core`'s widget base gained two constructor arguments (`module_handler`, `entity_type_manager`), and the component modules that override the constructor to inject their own services were not updated. Components that do *not* override it — `ept_timeline`, `ept_basic_button` — inherit correctly and work.

So the rule for the family is concrete: **a component module that overrides `EptSettingsDefaultWidget::__construct()` is suspect against `ept_core` 2.0.0.** Check for `parent::__construct(` with five arguments before adopting one, and pin the EPT modules together — none of them constrains `ept_core`'s version.

Enabling it here also fataled mid-install, leaving several unrelated modules from the same batch half-installed.

---

- Show images and video in one gallery.
- Open gallery items in a lightbox.
- Add a project photo gallery to a page.
- Combine a video clip with photographs.
- Place a gallery as an EPT paragraph.
- Use GLightbox for lightbox behaviour.
- Check the widget constructor before adopting.
- Pin EPT family versions together.
- Recognise the family-wide constructor defect.
- Prefer components that do not override the constructor.
- Diagnose an ArgumentCountError on enable.
- Recover modules half-installed by a mid-install fatal.
- Verify against the resolved ept_core version.
- Report the defect upstream.
- Plan a gallery component for a landing page.
