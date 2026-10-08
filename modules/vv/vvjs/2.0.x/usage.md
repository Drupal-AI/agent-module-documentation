VVJS is an accessible, dependency-free (vanilla-JavaScript) slideshow **display format for Views** — regular and hero slideshow modes with transitions, autoplay, arrows/dots/numbers, deep linking, and AAA-level accessibility.

---

Set a View's Format to *Views Vanilla JavaScript Slideshow* (Show: Fields) and each result row becomes a slide. The style plugin `views_vvjs` (`src/Plugin/views/style/Slideshow.php`, extending `VvjStylePluginBase` from the required `vvj_core` foundation) renders a `<vvjs-slideshow>` custom element and attaches libraries; behavior is one web-component class over the element lifecycle. Options (schema `views.style.views_vvjs`, ~30 keys) cover timing/autoplay (`time_in_seconds` 0=off), navigation (`arrows`, `navigation` dots/numbers), animation (7 presets) and `transition_type` (instant + 3 crossfades) with `transition_duration`, hero mode (`hero_slideshow`, `overlay_position`, `overlay_bg_color`/`overlay_bg_opacity`), responsive sizing across 5 breakpoints (576–1400), and behavior toggles (`pause_on_hover`, `enable_swipe`, `enable_keyboard`, `enable_looping`, `start_index`, `show_play_pause`, `show_slide_progress`, `show_total_slides`, `enable_deeplink`+`deeplink_identifier`). Accessibility is first-class: `role="tabpanel"`/`inert`/`aria-hidden` per slide, an ARIA live-region announcer, keyboard nav, pointer/touch swipe, and pause on `prefers-reduced-motion`/hidden tab/off-screen. In Views text areas (header/footer/empty with "use replacement tokens from the first row") use `[vvjs:field]` / `[vvjs:field:plain]` tokens (resolved by `vvj_core.token_resolver`, first row only). External JS can drive any instance through the `Drupal.vvjs.*` API. v2 is a drop-in upgrade from 1.x (same plugin id `views_vvjs`, theme hook `views_view_vvjs`, option keys, library and CSS class names); `vvjs_update_10001` auto-enables the new `vvj_core` dependency.

---

- Build an accessible image carousel from a View of media or image fields.
- Create a full-width hero slideshow with overlay text/CTA content per slide.
- Auto-advance slides on a configurable interval, or disable autoplay entirely.
- Let the slideshow pause on hover, when the tab is hidden, or when scrolled out of view.
- Respect `prefers-reduced-motion` by pausing autoplay for motion-sensitive users.
- Offer crossfade transitions (classic/staged/dynamic) or instant switching.
- Add directional slide/zoom/fade entrance animations.
- Show navigation arrows in several positions, or dots / numbers below the slides.
- Use scrollable dots/numbers for slideshows with many slides.
- Provide a play/pause button, progress bar, and "X of Y" slide counter.
- Enable touch/swipe gestures (RTL-aware) and full keyboard navigation.
- Deep-link to a specific slide via a URL hash like `#gallery-3`.
- Choose which slide shows first with a start index.
- Toggle looping on or off at the end of the sequence.
- Tune responsive behavior separately at 576/768/992/1200/1400px breakpoints.
- Set a hero overlay position (12 options) and rgba overlay color from hex + opacity.
- Constrain slideshow min-height, max content width, and max width.
- Insert dynamic field values into header/footer text with `[vvjs:field]` tokens.
- Render plain-text token values with the `:plain` suffix.
- Disable the bundled CSS to fully theme the slideshow yourself.
- Drive a slideshow from external JS: `Drupal.vvjs.goToSlide('gallery', 3)`.
- Pause or resume every slideshow on a page at once (`pauseAll`/`resumeAll`).
- Query current/total slide numbers or initialization state via the JS API.
- Upgrade an existing VVJS 1.x View in place (`composer update` + `drush updb`).
- Present a product gallery, testimonial rotator, or news highlights slider.
