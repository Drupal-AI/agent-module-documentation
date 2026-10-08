<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Style Switcher lets site visitors choose among alternate CSS stylesheets and remembers the pick in a cookie. Admins define named "styles" (a label plus a CSS file path or external URL) at `/admin/config/user-interface/styleswitcher`, and themes can add their own via a `styleswitcher:` key in `.info.yml`. A "Style Switcher" block renders the choices as links; with JavaScript the active stylesheet swaps live, and without it a redirect route persists the choice.

---

Two style sources merge at runtime: admin-defined custom styles (stored in the `styleswitcher.custom_styles` config object, available to every theme) and theme-provided styles (declared in the theme's `.info.yml`, scoped to that theme and its sub-themes). A permanent blank style just clears the effect of other alternates. Per theme, an admin enables, reorders, and sets the default style through the `styleswitcher.config_theme` tab (stored in `styleswitcher.styles_settings`); a global setting toggles a fade overlay during the switch (`styleswitcher.settings`). All administration sits behind the single `administer styleswitcher` permission; switching itself needs no permission, and the visitor's chosen style name is always resolved against the defined styles before any stylesheet is loaded. The chosen stylesheet is injected last (via `hook_css_alter` rewriting a placeholder to the `styleswitcher.css/{theme}` route) so it overrides other CSS, and the choice lives in a per-theme cookie for ~365 days. The block hides itself unless at least two styles are available. The strongest use is accessibility — an opt-in high-contrast or large-text variant is a recognized accommodation — but each variant is only as accessible as the CSS behind it, and it does not replace accessible defaults. Core requirement is `^9.5 || ^10 || ^11`; the release carries the legacy `8.x-2.4` packaging string.

---

- Offer visitors an opt-in high-contrast stylesheet.
- Provide a large-text / text-zoom variant of a site.
- Let visitors pick between light and dark color schemes.
- Remember each visitor's chosen style across pages and visits.
- Add a seasonal or promotional skin without editing the theme.
- Support a recognized accessibility accommodation.
- Show a fade overlay while the stylesheet swaps.
- Place the switcher as a block in the sidebar or header.
- Define a different set of styles per theme.
- Reorder how style links appear to visitors.
- Choose a default style shown to first-time visitors.
- Disable specific styles without deleting them.
- Reference a stylesheet hosted at an external URL.
- Ship alternate stylesheets from a theme's `.info.yml`.
- Export and deploy style definitions via `drush cex`/`cim`.
- Offer a print-friendly or reading-focused variant.
- Support users with light sensitivity or dyslexia-friendly typography.
- A/B a redesign as an opt-in style before making it default.
- Restrict all style administration to one permission.
- Migrate Style Switcher configuration from Drupal 7.
- Swap stylesheets live without a page reload (JS) or via redirect (no-JS).
- Provide a dark variant on an older theme that lacks one.
- Meet a public-sector accessibility commitment with an alternate stylesheet.
