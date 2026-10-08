<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Basic Slider provides a lightweight image slideshow that you place on the page as a block.

Use it when you need a straightforward image carousel without the weight of a full media/slideshow framework.

---

Install with `composer require drupal/basic_slider` and enable it (`drush en basic_slider`); it depends on core `block`.

Add the "Basic Slider" block to a region through Block Layout and configure its images in the block settings. The module ships a Twig template and a JS library that drives the transitions.

---

- Render an image slider as a placeable block.
- Depend only on core Block module.
- Ship a dedicated JavaScript slider library.
- Provide a Twig template for slider markup.
- Configure slides through the block configuration form.
- Keep the implementation intentionally minimal.
- Target Drupal 10.
- Require no third-party slideshow library.
- Let editors position the slider via Block Layout.
- Animate transitions client-side.
- Suit simple hero/banner carousels.
- Attach its CSS/JS only where the block renders.
- Avoid extra field or media configuration.
- Work as a self-contained block plugin.
- Provide a quick way to add rotating images.
- Serve as a small, readable slider example.
- Complement richer slider modules when only basics are needed.