<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Waypoints packages the jQuery Waypoints library (v4.0.1) as the Drupal asset library `waypoints/waypoints`, which fires a callback when an element scrolls into a given position; an admin checkbox can attach it on every page, otherwise other code attaches it on demand.

---

Scroll-triggered behaviour covers a set of patterns every marketing site eventually wants: a header that becomes compact once the page has scrolled past the hero, a statistic that counts up when it comes into view, a sidebar that sticks within its container and releases at the footer, an infinite-scroll trigger, an element that animates in. This module does little of that itself — it declares the library and gets out of the way. Concretely: it registers `waypoints/waypoints`, whose only JS is `/libraries/waypoints/lib/jquery.waypoints.min.js` (the file must be present under the site's `/libraries`, installed via the Composer package `levmyshkin/waypoints` or manually from the upstream repo — it is **not** vendored inside the module and is **not** fetched from a CDN). A settings form at `/admin/config/user-interface/waypoints`, gated by the `configure waypoints module` permission, exposes one checkbox, *"Always include JavaScript file to the site"*; when it is ticked, `hook_page_attachments` attaches the library on **every** page of the site. Leave it unticked and nothing loads until a theme or another module attaches `waypoints/waypoints` from its own render array. Note that the declared library lists only the Waypoints file and does **not** declare a `core/jquery` dependency, so consuming code that relies on the jQuery build should attach `core/jquery` alongside it. Version **2.2.0**, core `^10.1 || ^11 || ^12`. **The reason to pause before adopting it is that the platform has replaced it.** `IntersectionObserver` is supported everywhere that matters, does the same job, and does it better in the way that counts: Waypoints works by listening to scroll events and measuring positions, which runs code on the main thread on every scroll frame, while `IntersectionObserver` is asynchronous and computed off the main thread — on a phone that is the difference between a page that scrolls smoothly and one that stutters. Two further points that apply whichever mechanism is used. **Scroll-triggered animation must respect `prefers-reduced-motion`**, because content that moves on its own causes real symptoms for a substantial number of people. And **content revealed on scroll must exist without the script**, or a failed load leaves a blank page — the reason "visible by default, enhanced when the script runs" is the safe pattern.

---

- Register the jQuery Waypoints library as a reusable Drupal asset library.
- Attach the Waypoints library on every page via the admin checkbox.
- Let a custom theme attach `waypoints/waypoints` only on the pages that need it.
- Trigger an action when an element scrolls into view.
- Make a header compact after scrolling past the hero.
- Count up a statistic when it becomes visible.
- Stick a sidebar within its container and release it at the footer.
- Trigger infinite-scroll loading (Views Load More integrates with this module).
- Animate a section as it enters the viewport.
- Highlight a nav item for the currently visible section (scrollspy).
- Lazy-load content or images as they approach the viewport.
- Fire analytics when a section is seen.
- Build a scroll-driven narrative or story.
- Reveal a call-to-action or sticky footer bar on scroll.
- Trigger a video to play when it comes into view.
- Reveal a reading-progress indicator.
- Fire a callback at a specific scroll offset.
- Provide the base library that other contrib/custom modules depend on.
