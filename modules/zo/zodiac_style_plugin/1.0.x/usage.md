<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Zodiac Style Plugin adds a single Views style, **Zodiac**, that renders a view's results as a carousel/slider built on the bundled `@librarymarket/zodiac` JavaScript library, with slider options that can be tuned globally and overridden per Drupal **breakpoint**.

---

Pick the Zodiac style on any view (with a row style such as fields) and its rows become slides in a horizontal carousel with previous/next buttons, autoplay, infinite scrolling, an accessible live region, and configurable spacing, items-per-view, and animation timing. Everything is set from the Views UI — there is no settings page, route, or permission of its own; the style plugin `Drupal\zodiac_style_plugin\Plugin\views\style\Zodiac` stores its options inside the view, attaches the `zodiac_style_plugin/behavior` library, and passes a per-instance settings object to the JS under `drupalSettings.zodiac`. The distinctive part is breakpoint integration: choosing a core breakpoint group exposes per-breakpoint overrides, and at render time each breakpoint's media-query string becomes a `mediaQueryOptions` entry, so the slider adapts at the same widths the theme already declares rather than at hard-coded ones. Requirements are PHP 8.1+, core `breakpoint` and `views`; the info file declares `^10.1 || ^11` (the info file is what Drupal enforces; composer says `^10.3 || ^11`). The library's own assets ship under `node_modules/@librarymarket/zodiac/dist/` and are referenced directly from the library definition, so that directory must remain deployed alongside the module.

---

- Turn a view of nodes into an autoplaying carousel.
- Build a featured-content slider from a view.
- Show a rotating hero/banner of promoted items.
- Display a product carousel with several items per view.
- Create an image or media gallery slider.
- Add previous/next navigation to a listing.
- Present testimonials as a rotating slider.
- Show related content as a horizontal carousel.
- Adjust items-per-view per breakpoint for mobile vs desktop.
- Slow or speed up the slide transition animation.
- Enable infinite (looping) scrolling on a carousel.
- Pause autoplay when a visitor hovers the slider.
- Announce the active slide to screen readers via a live region.
- Set the gap between slides in pixels.
- Tie slider responsiveness to the theme's breakpoints.
- Disable autoplay on small screens only.
- Build a logo or partner carousel.
- Show recent posts as a swipeable slider.
- Create a news highlights carousel.
- Configure the whole slider from the Views UI without code.
