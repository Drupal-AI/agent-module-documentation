<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Slider turns a block or a layout section into a slider, so a set of components can be shown one at a time.

---

Carousels are asked for constantly and are one of the harder things to implement well. Doing it once, at the suite level, means a site gets consistent behaviour wherever a slider appears rather than three implementations with three keyboard behaviours.

Both `vlsuite_block` and `vlsuite_layout` depend on this, so the slider is available as a property of a component or of a whole section — a section of cards becomes a card carousel without a separate carousel component.

Two things to be clear-eyed about. **Carousels perform poorly at their stated job**: usability research has consistently found that content past the first slide is rarely seen, so a carousel is a reasonable way to present optional extras and a poor way to present something important. Say so when someone proposes putting the primary call to action on slide three.

And **accessibility takes work**: a slider needs keyboard operation, visible focus, an accessible way to reach every slide's content, and it must not auto-advance without a pause control. Verify those on the shipped implementation rather than assuming.

---

- Turn a section of cards into a carousel.
- Show testimonials one at a time.
- Make a block a slider.
- Present optional extras in a rotation.
- Give sliders consistent behaviour sitewide.
- Avoid three carousel implementations.
- Check keyboard operation of the slider.
- Verify visible focus on slider controls.
- Provide a pause control for auto-advance.
- Reach every slide's content accessibly.
- Avoid putting the primary CTA past slide one.
- Advise against a carousel where it will not work.
- Style slider controls with the site's CSS.
- Combine slider behaviour with animations.
- Audit carousels for accessibility.