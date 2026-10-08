<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Background Slider renders a full-page background slideshow of images or videos, configured slide-by-slide and displayed through a Drupal block.

Use it for a hero/landing background where you want rotating imagery or looping video behind page content.

---

Install with `composer require drupal/background_sliders` and enable the `background_slider` module (`drush en background_slider`).

Configure the number of slides, the slider type (image or video) and upload each slide's media on the settings form. Place the provided slider block in a region (typically a header or full-width region) via Block Layout.

Security note: the settings route (`background_slider.settings`) is gated only by `_role: 'authenticated'`, so any authenticated user - not just administrators - can open the form, change slider configuration and upload image/video files. Restrict registration or patch the route to an admin permission if that matters for your site.

---

- Display a rotating background slideshow site-wide.
- Support image slides (gif, png, jpg, jpeg, webp).
- Support video slides (mp4, m4v, mov, flv, ogg, webm and more).
- Let an admin choose the number of slides.
- Switch between image and video slider types.
- Upload each slide's media through a managed-file widget.
- Mark uploaded files permanent on save.
- Render the slideshow through a dedicated Drupal block.
- Attach the slider CSS/JS library on every page.
- Provide a settings form for slide count and type.
- Use an AJAX callback to swap slide fields when the type changes.
- Store configuration in `background_slider.setting` config.
- Enforce upload extension validators to limit file types.
- Store images under `public://bk-imgs` and videos under `public://bk-videos`.
- Provide an `access configuration form` permission (defined but the route uses a role check).
- Work on Drupal 9.4 and Drupal 10.
- Give a landing page an app-like animated background.