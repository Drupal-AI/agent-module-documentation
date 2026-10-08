<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Vanilla JavaScript Parallax (VVJP) adds a Views display format that renders each row as a scroll-driven parallax section.

---

Install with `composer require drupal/vvjp:^2.0` (which also pulls in the required `drupal/vvj_core`) and `drush en vvjp`; it needs Drupal 11.3+/12 and PHP 8.3+. There is no settings page — you configure everything in the Views UI. Create or edit a View, set **Format** to *Views Vanilla JavaScript Parallax* and **Show** to *Fields*, make the **first field** an image using the **"URL to image"** formatter (its URL becomes the parallax background), and add a `<div class="vvjp-separator"></div>` field between that image URL and your foreground content fields. Then tune the grouped format settings: responsive breakpoint (**all**/576/768/992/1200/1400 px, below which a plain `<img>` replaces the effect), section height and unit (`vh`/`vw`/`px`/`%`/`em`/`rem`) and max content width, parallax speed (`0.1`–`2.0`), background position/animation speed/easing, a foreground scroll effect (fade, scale, rotate, glow, shadow, 3D, and more), and a color overlay with adjustable opacity (full-row, content-only, or disabled). The effect runs as a lightweight `<vvjp-parallax>` custom element with no jQuery, honors `prefers-reduced-motion`, and an optional `vvjp_example` View ships as a starting point. In header/footer/empty text areas use `[vvjp:field]` (or `[vvjp:field:plain]`) tokens with *Use replacement tokens from the first row* to print field values.

---

- Add a scroll-driven parallax hero or banner to a Views listing.
- Render articles or promoted content as full-width parallax sections.
- Use an image field's URL as a moving background behind text.
- Build a landing page of stacked parallax panels from content.
- Show a featured-content block with a parallax background.
- Configure section height in vh, px, %, em, or rem.
- Cap content width or let it stretch full width.
- Set parallax scroll speed from slow (0.1) to fast (2.0).
- Choose a background position and animation speed/easing.
- Apply a fade, scale, rotate, glow, shadow, or 3D scroll effect to content.
- Overlay the background with a tinted color at a chosen opacity.
- Scope the overlay to sit only under the content, or disable it.
- Disable the parallax below a breakpoint and fall back to a static image.
- Respect visitors' reduced-motion preference automatically.
- Ship a jQuery-free, lightweight parallax on modern Drupal.
- Start from the bundled `vvjp_example` demo View.
- Print a first-row field value in a header/footer with `[vvjp:field]` tokens.
- Upgrade an existing 1.x site in place (composer update + updb + cr).
- Keep parallax active on all breakpoints for immersive full-page designs.
- Restrict who can build these Views via standard Views UI permissions.
- Confirm scroll performance on long lists before production.
