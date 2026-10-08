Views Slideshow Cycle is the reference engine for Views Slideshow: it provides the `views_slideshow_cycle` slideshow type, powered by the jQuery Cycle library, that actually animates the slides. It is the module most Views Slideshow users enable alongside the base module.

---

The submodule registers a single `ViewsSlideshowType` plugin (`Cycle`, id `views_slideshow_cycle`) that plugs into the base module's Slideshow style and renders the rotating slideshow using the malsup jQuery Cycle plugin. It contributes a large per-display options form — transition effect (fade, scroll, blind, zoom and ~25 others), timeout/speed/delay, sync and random ordering, pause-on-hover / pause-on-click / start-paused, "remember last slide", pause-when-hidden, items-per-slide, fixed-height, wait-for-image-load, IE ClearType tweaks, and a raw "jQuery Cycle custom options" JSON escape hatch exposing every native Cycle option. Its front-end (`views_slideshow_cycle.js` plus `formoptions.js` for the settings UI) implements the actions the base widgets call (nextSlide, previousSlide, pause, play, goToSlide) and emits transition events. It ships its own Twig templates and theme hooks for the main frame and rows, plus preprocess hooks for the pager-fields and slide-counter widgets. Because jQuery Cycle and its helpers are external, the module needs the jQuery Cycle, JSON2, jQuery HoverIntent and jQuery Pause JavaScript libraries installed under `/libraries`; it bundles Drush commands to download them. It has no config of its own — its settings live inside the host View's Slideshow style options under the `views_slideshow_cycle` key.

---

- Provide the actual rotating animation for a Views Slideshow display.
- Fade between slides (the default effect).
- Choose from ~28 jQuery Cycle transition effects (scroll, blind, zoom, shuffle, curtain, etc.).
- Set how long each slide shows (timeout) and how long the transition lasts (speed).
- Stop auto-rotation entirely by setting the timeout to 0.
- Add an initial-slide delay offset before the first transition.
- Randomize slide order instead of using the View's order.
- Pause the slideshow when the visitor hovers over it.
- Pause the slideshow when a slide is clicked.
- Start the slideshow already paused.
- Resume on the last slide a returning visitor viewed (with a configurable remember-days).
- Pause when the slideshow scrolls out of view, with a threshold (vertical/horizontal/area).
- End the slideshow after the last slide instead of wrapping.
- Show more than one item per slide, optionally a different count on the first slide.
- Fix the slide window height to the tallest slide (or let it vary).
- Wait for all slide images to load before starting, with a fallback timeout.
- Apply IE ClearType tweaks for legacy browsers.
- Enter raw jQuery Cycle options as JSON for anything not exposed in the form.
- Install the required JS libraries via `drush views:slideshow:lib` (and per-library commands).
- Serve as the working example for writing your own `ViewsSlideshowType` engine.
- Drive base-module widgets (pager, controls, counter) through its accepts/calls actions.
- Override its main-frame / row Twig templates to change the slide markup.
