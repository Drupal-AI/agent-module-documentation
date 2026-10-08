Dark Mode Button (dmb) provides a placeable block with an icon button that toggles a client-side dark theme on and off.

---

Dark Mode Button is a lightweight front-end module. Enabling it and placing its "Dark Mode Toggle" block anywhere in a theme's region gives visitors a moon/sun icon button. Clicking the button toggles a `dark-mode` class on the page `<body>` and stores the preference in the browser's `localStorage`, so the choice survives navigation and page reloads for that visitor. The dark appearance is delivered entirely by the module's own `css/dark-mode.css`, which restyles a set of common Olivero/theme selectors (body, containers, headings, links, tabs, pagers, tags, code blocks). The button glyph comes from Bootstrap Icons, loaded as an external stylesheet from a public CDN. There is no server-side state, no configuration UI, no permissions, and nothing per-user is written on the server — the entire toggle lives in JavaScript and CSS. Because it is a plain block, its visibility can be scoped with core block visibility conditions (pages, roles, content types), and multiple placements are possible.

---

- Add a dark-mode toggle button to a public-facing site without writing any custom JavaScript or CSS.
- Give anonymous visitors a way to switch to a darker color scheme that persists across pages via `localStorage`.
- Place the toggle in the header region so it appears site-wide next to branding or the main menu.
- Place the toggle only in the footer for a less prominent, opt-in dark mode control.
- Offer a quick accessibility/comfort option for readers browsing at night.
- Prototype a dark theme quickly by relying on the bundled `dark-mode.css` selectors instead of authoring a full sub-theme.
- Restrict the toggle to authenticated users only, using the block's core "Roles" visibility condition.
- Show the toggle only on article/blog pages using the block's page or content-type visibility conditions.
- Combine the block with core's block layout to position the button absolutely inside its container.
- Provide a moon icon in light mode and a sun icon in dark mode as an intuitive visual cue.
- Remember a visitor's dark-mode choice on their device without cookies or server-side sessions.
- Use it on a demo or portfolio site where a full theme-switching system would be overkill.
- Add a dark mode affordance to a decoupled-lite site whose front end is still rendered by Drupal themes.
- Layer the module's CSS overrides on top of an existing theme to darken common regions and typography.
- Extend the darkening by adding your own `body.dark-mode` CSS rules in a custom theme or library.
- Give editors a preview of how content reads against a dark background.
- Serve as a teaching example of a minimal Drupal block plugin plus attached library.
- Place multiple instances of the toggle (e.g., mobile menu and desktop header) that all share the same `localStorage` state.
- Provide a dark-mode button on a landing page built primarily from blocks.
- Ship a low-maintenance dark mode on a small brochure site with no ongoing configuration.
- Use the Bootstrap Icons dependency it already pulls in to keep icon styling consistent with other Bootstrap-based UI.
