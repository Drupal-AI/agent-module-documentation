Ajax Loader replaces Drupal's default core AJAX throbber with a configurable animated spinner (SpinKit-style) shown while any AJAX request is in flight.

---

Ajax Loader ships a `Throbber` plugin type and twelve ready-made animated throbbers (pulse, wave, chasing dots, folding cube, circle, and more). A single settings form at `/admin/config/user-interface/ajax-loader` lets you pick which throbber to use, and everything is stored in the `ajax_loader.settings` config object. On every non-admin page the module's `hook_page_attachments()` attaches the `ajax_loader/ajax_loader.throbber` library plus the chosen throbber's markup and CSS, and its JavaScript hooks into Drupal's AJAX lifecycle to insert/remove the throbber. You can control whether the throbber renders full-screen as an overlay (`always_fullscreen`), whether the core "loading…" message is suppressed (`hide_ajax_message`), whether it also appears on admin pages (`show_admin_paths`), and — via a CSS selector — where in the DOM it is injected (`throbber_position`, default `body`). Developers extend it by adding their own annotated `@Throbber` plugin under `src/Plugin/ajax_loader`, supplying markup and a CSS file. It has no dependencies beyond Drupal core and adds no Drush commands.

---

- Swap Drupal's plain core AJAX throbber for a polished animated spinner site-wide.
- Give editors visual feedback during Views AJAX pager / exposed-filter refreshes.
- Show a spinner while AJAX-enabled forms (autocomplete, multi-step, file uploads) submit.
- Present a full-screen overlay loader during long AJAX operations so users wait without double-clicking.
- Pick a brand-appropriate loading animation (pulse, wave, circle, cube grid) from twelve built-ins.
- Position the throbber next to a specific DOM element (e.g. a form or region) instead of the page body via a CSS selector.
- Suppress the default "Please wait…" AJAX message and rely on the animation alone.
- Extend loading feedback onto admin pages (BEO/Views admin listings) that normally use the core throbber.
- Keep the core throbber on admin pages while showing the custom one only on the public site.
- Add a custom-branded throbber by writing a `@Throbber` plugin with your own markup and CSS.
- Provide a consistent loading indicator across a decoupled-ish AJAX-heavy theme.
- Improve perceived performance on slow endpoints by giving immediate visual feedback.
- Reduce accidental repeated submissions by overlaying the page during AJAX calls.
- Standardize loading UX across multiple sites by exporting the `ajax_loader.settings` config.
- Demonstrate/prototype different SpinKit loaders quickly using the live preview on the settings form.
- Localize/gate access to the loader configuration with the `administer ajax loader` permission.
- Insert the throbber into a modal or off-canvas container by targeting its selector.
- Ship a default throbber choice with an install profile or recipe via config.
- Replace the throbber animation without touching theme code (config-only change).
- Give AJAX-driven dashboards (charts, tables) a uniform spinner while data loads.
- Turn the loader off site-wide by clearing the `throbber` value (falls back to core).
- Provide accessible loading feedback that survives cache clears (the module reattaches on every page).
- A/B different loaders by changing one config key and clearing caches.
- Match the throbber color/size to a design system by overriding the plugin's CSS in a theme.
