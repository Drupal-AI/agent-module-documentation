Darkmode integrates the client-side Darkmode.js library into Drupal as a placeable block that gives visitors a floating button to toggle between a light and dark color scheme.

---

The module ships a single block plugin, `darkmode_switcher`, which does no server-side work: it attaches the bundled `darkmode/initiator` JS and `darkmode/darkmodecss` libraries plus a `drupalSettings.darkmode` payload built from the block's own settings, then instantiates `new Darkmode(options)` in the browser and shows its floating toggle widget. All appearance is controlled from the block's configuration form in Block Layout — the widget's screen position (bottom/right/left offsets), transition time, mix/background colors, dark and light button colors, whether the visitor's choice is remembered in a cookie (`saveInCookies`), and a theme-mode selector (`auto` to follow the OS `prefers-color-scheme`, or a forced `light`/`dark`). The block requires the third-party `darkmode-js` npm-asset to be present at `web/libraries/darkmode-js`. There are no routes, permissions, services, or content entities of its own; it relies entirely on core's block system for placement and access. An `hook_update_10001` migrates legacy `darkmode.config` settings into the block instance settings for sites upgrading from the earlier module-level config approach.

---

- Add a floating light/dark toggle button to any page by placing the Darkmode Switcher block in a region.
- Let visitors switch a site to a dark color scheme for low-light or eye-strain comfort without a full theme rewrite.
- Follow the visitor's operating-system dark/light preference automatically with the `auto` theme mode.
- Force the site to always render dark (or always light) regardless of OS by selecting the `dark` / `light` theme mode.
- Remember each visitor's chosen mode across page loads via the `saveInCookies` option.
- Position the toggle button in a corner (bottom/right/left pixel offsets, or `unset`) to fit an existing layout.
- Restrict where the toggle appears by using core block visibility conditions (per path, content type, role, or region).
- Customize the toggle button colors for dark and light states to match brand colors.
- Tune the fade/transition duration of the dark-mode overlay via the `time` setting.
- Adjust the overlay mix and background colors used by Darkmode.js to invert the page.
- Provide a dark theme option on a site whose base theme has no built-in dark variant.
- Offer multiple differently-configured switchers (e.g. different positions) by placing more than one block instance.
- Give editorial or marketing sites a quick accessibility/comfort feature with no code.
- Prototype a dark-mode experience rapidly before investing in native theme CSS variables.
- Keep the switcher available only to authenticated users by combining the block with a role visibility condition.
- Migrate a site off the module's old `darkmode.config` object automatically via the shipped update hook.
- Style or reposition the injected `.darkmode-toggle` button further with the bundled `css/styles.css` (which raises its `z-index`).
- Expose an OS-matching dark mode on multilingual sites, since the widget is purely client-side and language-agnostic.
- Add dark mode to a decoupled-adjacent or classic Drupal front end without server round-trips on toggle.
- Ship a lightweight dark-mode toggle with essentially zero performance or database cost.
