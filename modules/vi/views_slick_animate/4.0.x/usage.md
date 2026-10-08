<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Slick Animation provides a Views "Views slick Animation" style plugin that renders Views results in a Slick carousel with optional animate.css slide animations.

---

Views Slick Animation bundles the Slick carousel library and animate.css and exposes them through a Views style plugin (`slickanimate`). On any View you pick this style and configure the carousel via a rich options form: slider style (basic vs CDN), autoplay, arrows, dots, infinite loop, slidesToShow/Scroll, speed, lazy load, center mode, plus per-breakpoint responsive settings (mobile/tablet/desktop) and an "Additional settings" group mirroring Slick's own options. An "Animation Model" tab turns rows into structured slides in one of three layouts — `default`, `card`, or `hero_banner` — mapping View fields to image, title, subtitle, description and button, and attaching an entrance animation (fadeIn/slideIn/zoom variants) per element. A "random" mode cycles through a chosen set of animate.css classes across slides automatically. Settings are stored in the View's own configuration and passed to the front-end via drupalSettings; a jQuery behavior initializes Slick per instance. It has no admin settings page, no permissions, and no Drush commands — everything is configured on the View. Requires the Views module (Drupal core).

---

- Turn a View's results into a Slick carousel/slideshow.
- Add animate.css entrance animations to slides.
- Build a hero banner slider with image, title, subtitle, description and button.
- Build a card-style animated carousel from View fields.
- Show a plain (non-animated) Slick carousel of rendered rows.
- Enable autoplay with a configurable speed.
- Show prev/next arrows and dot indicators.
- Loop slides infinitely.
- Set how many slides show and scroll at a time.
- Configure center mode with partial adjacent slides.
- Enable variable / auto slide width.
- Lazy-load slide images (on demand or progressive).
- Define responsive breakpoints for mobile, tablet and desktop.
- Tune advanced Slick options (fade, adaptive height, draggable, swipe, rtl, vertical, etc.).
- Map View fields to image/title/subtitle/description/button roles.
- Pick per-element animation types (fadeInLeft, slideInUp, zoomIn, lightSpeedIn, …).
- Apply zoom-in / zoom-out animation to slide images.
- Randomize animations across slides automatically.
- Pause autoplay on hover, focus, or dot hover.
- Use the bundled Slick assets or load Slick from a CDN.
- Present marketing/landing content as an animated banner rotator.
