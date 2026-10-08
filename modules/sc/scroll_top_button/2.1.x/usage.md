Scroll To Top Button adds a customizable "scroll to top" button to the front end of a Drupal site, shown once the visitor scrolls past a configurable distance, with adjustable style, text, animation and speed.

---

The module is entirely configuration-driven from a single settings form at
`/admin/config/user-interface/scroll_top_button` (route `scroll_top_button.settings`, gated by the
core `administer site configuration` permission). All values live in one config object,
`scroll_top_button.settings`. A `hook_page_attachments()` implementation checks whether the button
is enabled (the `enabled` key is the string `'on'` or `'off'`, not a boolean) and, unless the page
is an admin route with `show_on_admin` off, attaches the `scroll_top_button/scroll_top_button`
asset library plus the configuration as `drupalSettings` (button_text, button_style,
button_animation, button_animation_speed, scroll_distance, scroll_speed). The bundled jQuery script
shows/hides the button based on `scroll_distance` and smoothly scrolls the window to the top over
`scroll_speed` ms. Button appearance is one of four styles — `image`, `link`, `pill`, `tab` — and
the reveal animation is `fade`, `slide` or `none`. There is no block, no plugin and no PHP API; you
configure it and it applies site-wide on the active theme.

---

- Add a floating "back to top" button to a long-scrolling homepage or landing page.
- Give blog and article pages a quick way to return to the top after a long read.
- Show the button only after the visitor scrolls down a set number of pixels (`scroll_distance`).
- Choose a pill-shaped button for a modern rounded look (`button_style: pill`).
- Use a tab-style button anchored to the screen edge (`button_style: tab`).
- Use the bundled image/arrow button instead of text (`button_style: image`).
- Present the control as a simple text link (`button_style: link`).
- Customise the button label, e.g. "Back to top" or "Top" (`button_text`).
- Fade the button in when it appears (`button_animation: fade`).
- Slide the button into view instead of fading (`button_animation: slide`).
- Disable the reveal animation entirely for an instant show (`button_animation: none`).
- Tune how fast the button fades/slides in (`button_animation_speed` ms).
- Control how fast the page scrolls back to the top (`scroll_speed` ms).
- Turn the button on or off site-wide without uninstalling the module (`enabled: on`/`off`).
- Also show the button on admin pages for editors (`show_on_admin: TRUE`).
- Keep the button off admin pages so it only appears to end users (default).
- Improve mobile UX on lengthy pages where scrolling up by hand is tedious.
- Deploy the configuration between environments as exported `scroll_top_button.settings` config.
- Provide a lightweight, jQuery-based scroll aid without writing any theme code.
- Make long documentation or FAQ pages easier to navigate.
- Add a return-to-top affordance to infinite-scroll or Views-paged listings.
- Standardise a "to top" control across every page of the site from one settings form.
- Offer accessibility-friendly quick navigation back to the top of content.
- Adjust the trigger threshold so the button never appears on short pages.
