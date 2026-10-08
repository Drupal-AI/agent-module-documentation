<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Animate CSS integrates the third-party [animate.css](https://animate.style/) library into Drupal, attaching its stylesheet on every page so you can trigger ready-made, cross-browser CSS animations by adding class names to markup.

---

The module is a thin asset-library wrapper. It has no settings form, no configure route, no permissions, no plugins and no config schema. On install it registers one Drupal asset library, `animate_css/animate`, whose single CSS file is the animate.css stylesheet expected at `/libraries/animate.css/animate.css` (shipped by the Composer package `drupal-shimmy/animate.css` 4.1.1). `hook_page_attachments()` unconditionally attaches that library to every page render, so the animation classes are globally available to themes, blocks, fields, JavaScript and CKEditor content. `hook_requirements()` adds a status-report check that warns (REQUIREMENT_ERROR) when the library file is missing from `/libraries/animate.css`. Because this is animate.css v4, animations use the double-underscore prefixed classes: add `animate__animated` plus an effect class such as `animate__bounce` to an element (optionally utility classes like `animate__delay-2s`, `animate__slow`, `animate__infinite`). The module never adds classes for you — you (or your theme/JS) decide which elements animate.

---

- Add an entrance animation to a hero heading by giving it `class="animate__animated animate__fadeInUp"`.
- Bounce a call-to-action button on page load with `animate__animated animate__bounce`.
- Trigger an animation from JavaScript, e.g. `element.classList.add('animate__animated', 'animate__shakeX')` on an event.
- Animate slide/carousel items using animate.css effect classes instead of writing keyframes.
- Emphasise a form validation error by adding `animate__animated animate__headShake` to the field.
- Loop an attention-seeking animation with `animate__animated animate__pulse animate__infinite`.
- Delay an animation using utility classes like `animate__delay-1s` / `animate__delay-2s`.
- Slow down or speed up an effect with `animate__slow`, `animate__slower`, `animate__fast`, `animate__faster`.
- Animate blocks placed in a region by adding animate classes via the block's CSS classes / template.
- Add flip or zoom entrance effects to cards in a Views listing.
- Provide fun hover/entry animations in a landing page built with Layout Builder.
- Animate a modal or message on appearance from custom JS.
- Reuse animate.css effects inside CKEditor content via a class on an inline element.
- Highlight a "new" badge with `animate__animated animate__tada`.
- Apply exit animations (e.g. `animate__fadeOut`) before removing an element in JS.
- Standardise animation vocabulary across a site by relying on animate.css class names.
- Prototype motion quickly without adding custom keyframe CSS to the theme.
- Add cross-browser attention seekers (`flash`, `rubberBand`, `wobble`, `jello`) to promo elements.
- Animate icons or images on scroll by toggling animate classes with an intersection observer.
- Give menu items or accordions subtle entrance animations.
- Ensure the animate library is loaded site-wide without each theme having to declare the dependency.
- Verify (via the status report) that the animate.css library is correctly installed under `/libraries`.
- Combine with a theme library override if you want the animations loaded only on specific pages.
