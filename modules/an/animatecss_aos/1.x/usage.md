<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AnimateCSS On Scroll adds an "AOS" (Animate On Scroll) option group to the AnimateCSS UI so configured elements animate as they scroll into view.

---

Install the module together with its two required dependencies, **AnimateCSS** (`animatecss` / `animatecss_ui`) and **AOS JS** (`aosjs`) — for example `composer require drupal/animatecss_aos` then enable `animatecss_aos`; the AOS JavaScript library is provided by the `aosjs` module, so nothing needs to be placed under `web/libraries/`. There is **no separate settings page**: you configure everything from the AnimateCSS *Add animation* form at `/admin/config/user-interface/animatecss/add`. Add or edit an animate record, choose a CSS selector and an animation, then enable the **AOS** option and set its fields — **Offset** (px, default 120), **Easing**, **Anchor placement**, **Once**, and **Mirror**; the module converts AnimateCSS's named delay/speed values into AOS millisecond `delay`/`duration` automatically. On the front end it reads your enabled selectors, writes `data-aos-*` attributes plus `drupalSettings`, force-loads AOS v3, and calls `AOS.init()`. Front-end display still honours AnimateCSS's global "load" toggle and path-visibility rules. Because scroll animations affect UX and accessibility, respect `prefers-reduced-motion` and weigh performance on long pages.

---

- Animate an element as it scrolls into view.
- Add AOS options to the AnimateCSS UI.
- Trigger AnimateCSS effects on scroll instead of on load.
- Set a scroll Offset (px) per selector.
- Choose an AOS easing function per animation.
- Pick an anchor placement to control the trigger point.
- Make an animation play only once while scrolling down.
- Mirror animations so they play out again when scrolling past.
- Reuse AnimateCSS delay/speed presets as AOS delay/duration.
- Combine AnimateCSS classes with AOS scroll triggering.
- Merge in AOS JS UI selectors when AOS UI is installed.
- Emphasise home-page, slider, or hero sections on scroll.
- Guide attention with scroll-in effects.
- Keep the AOS library served locally from the aosjs module.
- Force the AOS v3 build over an older v2 attachment.
- Configure animations without writing any code.
- Limit animations to specific paths via AnimateCSS visibility rules.
- Respect prefers-reduced-motion for accessibility.
- Weigh performance impact on long, animation-heavy pages.
- Clean up stored AOS options automatically on uninstall.
- Restrict who can add or edit AnimateCSS animations.
- Test scroll behaviour across browsers before production.
