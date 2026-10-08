Dark Mode Toggle provides a block with Light / Dark / System buttons that let visitors switch a theme between its light and dark variants, remembering the choice in the browser.

---

The module ships a single Block plugin (`dark_mode_toggle`) whose default render is the `dark-mode-toggle.html.twig` template: an unordered list of three buttons labelled Light, Dark and System, wrapped in a container carrying a `data-dmt-container` attribute. Client-side JavaScript (attached automatically by the template's `attach_library`) toggles two attributes on the `<html>` element: `data-dmt-mode` (`dark` or `light`) and `data-dmt-source` (`user` or `system`). Clicking Light or Dark stores the preference under the `dmt-mode` key in `localStorage` and sets the source to `user`; clicking System removes the stored value, follows the OS `prefers-color-scheme` media query, and sets the source to `system`. A small header script (`dark-mode-toggle.init.js`, loaded in the page `<head>`) applies the stored/OS preference before paint to avoid a flash of the wrong theme (FOUC), and a live listener updates the mode when the OS preference changes while the source is `system`. The module itself only manages these attributes — it is up to the active theme's CSS to actually restyle the page based on `data-dmt-mode` (for example a Tailwind `@custom-variant dark` keyed on `[data-dmt-mode=dark]`). There is no settings form, no configuration route, no permissions, and no stored configuration other than the block placement itself.

---

- Add a Light/Dark/System theme switcher to a site by placing the Dark Mode Toggle block in a region.
- Let visitors opt into a dark colour scheme and have the choice persist across pages via `localStorage`.
- Respect the operating-system dark-mode preference out of the box (`prefers-color-scheme`).
- Avoid a flash of unstyled/wrong-theme content by applying the stored preference in the page header before paint.
- Give users an explicit "follow my system setting" option alongside manual Light and Dark choices.
- Drive a Tailwind CSS dark variant from the `data-dmt-mode=dark` attribute on `<html>`.
- Switch CSS custom properties / design tokens based on the `[data-dmt-mode]` attribute selector.
- Provide a dark-mode toggle in a site header, footer, or sidebar region through Block layout.
- Place the toggle in multiple regions or on specific pages using core block visibility conditions.
- Override the button markup (icons instead of words, a single cycle button) by overriding the Twig template in a custom theme.
- Re-theme the toggle per theme by supplying a theme-level `dark-mode-toggle.html.twig`.
- React in JavaScript to the current mode by reading `document.documentElement.dataset.dmtMode`.
- Distinguish a user-chosen mode from an OS-driven one via the `data-dmt-source` attribute.
- Keep a visitor's dark-mode choice sticky when they return to the site later.
- Update the theme instantly when the OS switches to dark at sunset while the user is on "System".
- Build an accessibility-friendly reduced-glare dark option for a content-heavy site.
- Offer dark mode without writing any custom JavaScript for state persistence.
- Add dark mode support to an existing theme by only writing CSS that keys off `[data-dmt-mode=dark]`.
- Expose the toggle only to authenticated users (or specific roles) using the block's role visibility.
- Use the block in a decoupled-ish progressively enhanced theme where JS handles the class/attribute switching.
- Position the toggle in a Layout Builder region or a custom template via the block plugin.
- Provide light/dark parity for print or embedded views by scoping CSS to the mode attribute.
- Let editors place the switcher without needing a developer, once the theme CSS supports the attribute.
- Standardise the dark-mode attribute contract (`data-dmt-mode` / `data-dmt-source`) across several themes on one site.
